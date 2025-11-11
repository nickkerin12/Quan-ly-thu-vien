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
        List<Book> books = bookDAO.getAllBooks();
        List<Reader> readers = readerDAO.getAllReaders();
        request.setAttribute("books", books);
        request.setAttribute("readers", readers);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/borrow-form.jsp");
        rd.forward(request, response);
    }

    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int recordId = Integer.parseInt(request.getParameter("id"));
        borrowDAO.returnBook(recordId);
        response.sendRedirect("borrow");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));
        int readerId = Integer.parseInt(request.getParameter("readerId"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        LocalDate borrowDate =  LocalDate.parse(request.getParameter("borrowDate"));
        LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
        LocalDate returnDate = LocalDate.parse(request.getParameter("returnDate"));
        String status = request.getParameter("status");
        double fineAmount = Double.parseDouble(request.getParameter("fineAmount"));

        BorrowRecord record = new BorrowRecord(borrowId, readerId, bookId, borrowDate, dueDate, returnDate, status, fineAmount);
        borrowDAO.borrowBook(record);
        response.sendRedirect("borrow");
    }
}
