package controller;

import dao.BorrowDAO;
import dao.BookDAO;
import dao.ReaderDAO;
import model.BorrowRecord;
import model.Book;
import model.Reader;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/borrow")
public class BorrowReturnController extends HttpServlet {
    private BorrowDAO borrowDAO;
    private BookDAO bookDAO;
    private ReaderDAO readerDAO;

    @Override
    public void init() {
        borrowDAO = new BorrowDAO();
        bookDAO = new BookDAO();
        readerDAO = new ReaderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                showForm(request, response);
                break;
            case "return":
                returnBook(request, response);
                break;
            default:
                listRecords(request, response);
        }
    }

    // --- 1. LOGIC HIỂN THỊ DANH SÁCH ---
    // Admin thấy hết - Độc giả chỉ thấy của mình
    private void listRecords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<BorrowRecord> list = new ArrayList<>();

        if (user != null) {
            String role = user.getRole();
            // Nếu là Admin hoặc Thủ thư: Lấy tất cả
            if ("Admin".equalsIgnoreCase(role) || "Thủ thư".equalsIgnoreCase(role)) {
                list = borrowDAO.getAllBorrowRecords();
            } 
            // Nếu là Độc giả: Chỉ lấy của chính mình
            else {
                Reader reader = readerDAO.getReaderByUserId(user.getUserId());
                if (reader != null) {
                    list = borrowDAO.getBorrowRecordsByReaderId(reader.getReaderId());
                }
            }
        }
        request.setAttribute("borrowList", list);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/borrow-list.jsp");
        rd.forward(request, response);
    }

    // --- 2. LOGIC HIỂN THỊ FORM MƯỢN ---
    // Admin có danh sách chọn người - Độc giả chỉ hiện tên mình
    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Luôn lấy danh sách sách để chọn
        List<Book> books = bookDAO.getAllBooks();
        request.setAttribute("books", books);

        if (user != null) {
            String role = user.getRole();
            if ("Admin".equalsIgnoreCase(role) || "Thủ thư".equalsIgnoreCase(role)) {
                // Admin: Lấy list tất cả độc giả để chọn
                List<Reader> readers = readerDAO.getAllReaders();
                request.setAttribute("readers", readers);
            } else {
                // Độc giả: Lấy thông tin của chính họ
                Reader myReader = readerDAO.getReaderByUserId(user.getUserId());
                request.setAttribute("myReader", myReader);
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher("/pages/borrow-form.jsp");
        rd.forward(request, response);
    }

    // --- 3. LOGIC LƯU PHIẾU MƯỢN ---
    // Tự động gán ID độc giả nếu là người dùng thường
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            String idStr = request.getParameter("borrowId");
            int borrowId = (idStr == null || idStr.isEmpty()) ? 0 : Integer.parseInt(idStr);
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            LocalDate borrowDate = LocalDate.parse(request.getParameter("borrowDate"));
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            
            // XỬ LÝ READER ID
            int readerId = 0;
            String role = user.getRole();
            
            if ("Admin".equalsIgnoreCase(role) || "Thủ thư".equalsIgnoreCase(role)) {
                // Admin: Lấy ID từ form (do Admin chọn)
                readerId = Integer.parseInt(request.getParameter("readerId"));
            } else {
                // Độc giả: TỰ ĐỘNG lấy ID của chính mình (Chống hack)
                Reader myReader = readerDAO.getReaderByUserId(user.getUserId());
                if (myReader != null) readerId = myReader.getReaderId();
            }

            String status = "Đang mượn"; 
            BorrowRecord record = new BorrowRecord(borrowId, readerId, bookId, borrowDate, dueDate, null, status, 0);

            if (borrowId == 0) {
                // Mượn mới
                Book book = bookDAO.getBookById(bookId);
                if (book != null && book.getSoLuongConLai() > 0) {
                    borrowDAO.addBorrowRecord(record);
                    bookDAO.updateBookQuantity(bookId, book.getSoLuongConLai() - 1);
                }
            } else {
                // Cập nhật (Chỉ Admin mới thường dùng cái này để sửa lỗi)
                borrowDAO.updateBorrowRecord(record);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("borrow");
    }

    // --- 4. LOGIC TRẢ SÁCH ---
    private void returnBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
         try {
            int recordId = Integer.parseInt(request.getParameter("id"));
            BorrowRecord record = borrowDAO.getBorrowRecordById(recordId);
            
            if (record != null && !"Đã trả".equals(record.getStatus())) {
                record.setReturnDate(LocalDate.now());
                record.setStatus("Đã trả");
                
                borrowDAO.updateBorrowRecord(record);
                
                Book book = bookDAO.getBookById(record.getBookId());
                if (book != null) {
                    bookDAO.updateBookQuantity(book.getBookId(), book.getSoLuongConLai() + 1);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        response.sendRedirect("borrow");
    }
}