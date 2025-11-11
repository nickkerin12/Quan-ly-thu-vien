package controller;

import dao.ReaderDAO;
import model.Reader;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/readers")
public class ReaderController extends HttpServlet {
    private ReaderDAO readerDAO;

    @Override
    public void init() {
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
            case "edit":
                editForm(request, response);
                break;
            case "delete":
                deleteReader(request, response);
                break;
            default:
                listReaders(request, response);
        }
    }

    private void listReaders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Reader> list = readerDAO.getAllReaders();
        request.setAttribute("readerList", list);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/reader-list.jsp");
        rd.forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/pages/reader-form.jsp");
        rd.forward(request, response);
    }

    private void editForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Reader existing = readerDAO.getReaderById(id);
        request.setAttribute("reader", existing);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/reader-form.jsp");
        rd.forward(request, response);
    }

    private void deleteReader(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        readerDAO.deleteReader(id);
        response.sendRedirect("readers");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int readerId = request.getParameter("readerId") == null ? 0 : Integer.parseInt(request.getParameter("id"));
        String maDocGia = request.getParameter("maDocGia");
        String hoTen = request.getParameter("hoTen");
        String diaChi = request.getParameter("diaChi");
        String soDienThoai = request.getParameter("soDienThoai");
        int userId = Integer.parseInt(request.getParameter("userId"));

        Reader reader = new Reader(readerId, maDocGia, hoTen, diaChi,soDienThoai, userId);

        if (readerId == 0)
            readerDAO.addReader(reader);
        else
            readerDAO.updateReader(reader);

        response.sendRedirect("readers");
    }
}