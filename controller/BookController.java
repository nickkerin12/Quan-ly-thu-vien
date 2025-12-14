package controller;

import dao.BookDAO;
import model.Book;
import model.User; // Bắt buộc phải import User để lấy role
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookController extends HttpServlet {
    private BookDAO bookDAO;

    @Override
    public void init() {
        bookDAO = new BookDAO();
    }

    // --- HÀM KIỂM TRA QUYỀN ADMIN ---
    // Dùng equalsIgnoreCase để chấp nhận cả "admin", "Admin", "ADMIN"
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                // CHẶN: Nếu không phải Admin thì đá về trang danh sách
                if (!isAdmin(request)) {
                    response.sendRedirect("books");
                    return;
                }
                showForm(request, response);
                break;
                
            case "edit":
                // CHẶN
                if (!isAdmin(request)) {
                    response.sendRedirect("books");
                    return;
                }
                editForm(request, response);
                break;
                
            case "delete":
                // CHẶN
                if (!isAdmin(request)) {
                    response.sendRedirect("books");
                    return;
                }
                deleteBook(request, response);
                break;
                
            default:
                // Ai cũng được xem danh sách
                listBooks(request, response);
        }
    }
  
    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> list = bookDAO.getAllBooks();
        request.setAttribute("bookList", list);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/book-list.jsp");
        rd.forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/pages/book-form.jsp");
        rd.forward(request, response);
    }

    private void editForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("bookId"));
            Book existing = bookDAO.getBookById(id);
            request.setAttribute("book", existing);
            RequestDispatcher rd = request.getRequestDispatcher("/pages/book-form.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("books");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("bookId"));
            bookDAO.deleteBook(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect("books");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // CHẶN: Không cho gửi form nếu không phải Admin
        if (!isAdmin(request)) {
            response.sendRedirect("books");
            return;
        }

        request.setCharacterEncoding("UTF-8"); 
        
        int bookId = 0;
        try {
            bookId = Integer.parseInt(request.getParameter("bookId"));
        } catch (NumberFormatException e) {
            bookId = 0;
        }

        String maSach = request.getParameter("maSach");
        String tenSach = request.getParameter("tenSach");
        String tacGia = request.getParameter("tacGia");
        String theLoai = request.getParameter("theLoai");
        int namXB = Integer.parseInt(request.getParameter("namXB"));
        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        
        // Logic xử lý số lượng còn lại
        int soLuongConLai;
        if (bookId == 0) {
            // Nếu thêm mới: Còn lại = Tổng số
            soLuongConLai = soLuong; 
        } else {
            // Nếu sửa: Lấy từ form
            soLuongConLai = Integer.parseInt(request.getParameter("soLuongConLai"));
        }

        Book book = new Book(bookId, maSach, tenSach, tacGia, theLoai, namXB, soLuong, soLuongConLai);

        if (bookId == 0) {
            bookDAO.addBook(book);
        } else {
            bookDAO.updateBook(book);
        }
        response.sendRedirect("books");
    }
}