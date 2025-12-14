package controller;

import dao.ReaderDAO;
import dao.BorrowDAO;
import model.Reader;
import model.BorrowRecord;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/readers")
public class ReaderController extends HttpServlet {
	private ReaderDAO readerDAO;
	private BorrowDAO borrowDAO;

	@Override
	public void init() {
		readerDAO = new ReaderDAO();
		borrowDAO = new BorrowDAO();
	}

	// Hàm kiểm tra quyền Admin
	private boolean isAdmin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		model.User user = (model.User) session.getAttribute("user");
		return user != null && "admin".equalsIgnoreCase(user.getRole());
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// --- BẢO MẬT: Chặn truy cập nếu không phải Admin ---
		if (!isAdmin(request)) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		// --------------------------------------------------

		String action = request.getParameter("action");
		if (action == null)
			action = "list";

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
//		case "view":
//			viewReaderDetail(request, response);
//			break;
		default:
			listReaders(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");

		// --- BẢO MẬT: Chặn truy cập nếu không phải Admin ---
		if (!isAdmin(request)) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}

		String idStr = request.getParameter("readerId");
		int readerId = (idStr == null || idStr.isEmpty()) ? 0 : Integer.parseInt(idStr);
		String maDocGia = request.getParameter("maDocGia");
		String hoTen = request.getParameter("hoTen");
		String diaChi = request.getParameter("diaChi");
		String soDienThoai = request.getParameter("soDienThoai");
		int userId = Integer.parseInt(request.getParameter("userId"));

		Reader reader = new Reader(readerId, maDocGia, hoTen, diaChi, soDienThoai, userId);

		if (readerId == 0)
			readerDAO.addReader(reader);
		else
			readerDAO.updateReader(reader);

		response.sendRedirect("readers");
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

	private void deleteReader(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		readerDAO.deleteReader(id);
		response.sendRedirect("readers");
	}

//	private void viewReaderDetail(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		try {
//			int id = Integer.parseInt(request.getParameter("id"));
//			Reader reader = readerDAO.getReaderById(id);
//			List<BorrowRecord> history = borrowDAO.getBorrowRecordById(id);
//			request.setAttribute("reader", reader);
//			request.setAttribute("history", history);
//			RequestDispatcher rd = request.getRequestDispatcher("/pages/reader-detail.jsp");
//			rd.forward(request, response);
//		} catch (Exception e) {
//			e.printStackTrace();
//			response.sendRedirect("readers");
//		}
//	}
}