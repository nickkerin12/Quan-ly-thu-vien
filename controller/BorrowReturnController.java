package controller;

import dao.BorrowDAO;
import dao.BookDAO;
import dao.ReaderDAO;
import model.BorrowRecord;
import model.Book;
import model.Reader;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

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

    private void listRecords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BorrowRecord> list = borrowDAO.getAllBorrowRecords();
        request.setAttribute("borrowList", list);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/borrow-list.jsp");
        rd.forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách sách và độc giả để hiển thị trong dropdown (select option)
        List<Book> books = bookDAO.getAllBooks();
        List<Reader> readers = readerDAO.getAllReaders();
        request.setAttribute("books", books);
        request.setAttribute("readers", readers);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/borrow-form.jsp");
        rd.forward(request, response);
    }

    // Logic trả sách (Action: return)
    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int recordId = Integer.parseInt(request.getParameter("id"));
            BorrowRecord record = borrowDAO.getBorrowRecordById(recordId);
            
            if (record != null && !"Đã trả".equals(record.getStatus())) {
                // 1. Cập nhật thông tin trả
                record.setReturnDate(LocalDate.now());
                record.setStatus("Đã trả");
                // Có thể tính phạt ở đây nếu muốn
                
                // 2. Gọi DAO cập nhật phiếu mượn (Dùng updateBorrowRecord thay vì returnBook)
                borrowDAO.updateBorrowRecord(record);

                // 3. Tăng số lượng sách còn lại lên 1
                Book book = bookDAO.getBookById(record.getBookId());
                if (book != null) {
                    bookDAO.updateBookQuantity(book.getBookId(), book.getSoLuongConLai() + 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("borrow");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Lấy borrowId, nếu null hoặc rỗng thì mặc định là 0 (Tạo mới)
            String idStr = request.getParameter("borrowId");
            int borrowId = (idStr == null || idStr.isEmpty()) ? 0 : Integer.parseInt(idStr);
            
            int readerId = Integer.parseInt(request.getParameter("readerId"));
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            LocalDate borrowDate = LocalDate.parse(request.getParameter("borrowDate"));
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            
            // Xử lý returnDate (có thể null nếu đang tạo mới)
            String returnDateStr = request.getParameter("returnDate");
            LocalDate returnDate = (returnDateStr != null && !returnDateStr.isEmpty()) 
                                   ? LocalDate.parse(returnDateStr) : null;
            
            String status = request.getParameter("status");
            if (status == null) status = "Đang mượn";

            String fineStr = request.getParameter("fineAmount");
            double fineAmount = (fineStr == null || fineStr.isEmpty()) ? 0 : Double.parseDouble(fineStr);

            BorrowRecord record = new BorrowRecord(borrowId, readerId, bookId, borrowDate, dueDate, returnDate, status, fineAmount);

            if (borrowId == 0) {
                // --- TRƯỜNG HỢP MƯỢN SÁCH MỚI ---
                
                // 1. Kiểm tra sách còn không
                Book book = bookDAO.getBookById(bookId);
                if (book != null && book.getSoLuongConLai() > 0) {
                    // 2. Thêm phiếu mượn (Dùng addBorrowRecord thay vì borrowBook)
                    borrowDAO.addBorrowRecord(record);
                    
                    // 3. Giảm số lượng sách
                    bookDAO.updateBookQuantity(bookId, book.getSoLuongConLai() - 1);
                } else {
                    // Xử lý lỗi: Hết sách (Có thể redirect kèm thông báo lỗi)
                    System.out.println("Sách đã hết, không thể mượn!");
                }
            } else {
                // --- TRƯỜNG HỢP CẬP NHẬT (SỬA) ---
                borrowDAO.updateBorrowRecord(record);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("borrow");
    }
}