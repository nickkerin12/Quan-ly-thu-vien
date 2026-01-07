package controller;

import dao.UserDAO;
import dao.ReaderDAO; 
import model.User;
import model.Reader; 
import util.EmailUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/auth")
public class AuthController extends HttpServlet {
	private UserDAO userDAO;
	private ReaderDAO readerDAO; 

	@Override
	public void init() {
		userDAO = new UserDAO();
		readerDAO = new ReaderDAO(); 
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("logout".equals(action)) {
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
			rd.forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		if ("register".equals(action)) {
			registerUser(request, response);
		} else if ("forgotPassword".equals(action)) {
			handleForgotPassword(request, response);
		} else {
			loginUser(request, response);
		}
	}

	// --- HÀM ĐĂNG KÝ (ĐÃ NÂNG CẤP TỰ ĐỘNG TẠO ĐỘC GIẢ) ---
	private void registerUser(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		try {
			String fullName = request.getParameter("fullName");
			String email = request.getParameter("email").trim();
			String username = request.getParameter("username").trim();
			String password = request.getParameter("password");

			// 1. Tạo User mới
			User newUser = new User();
			newUser.setUsername(username);
			newUser.setPassword(password);
			newUser.setFullName(fullName);
			newUser.setEmail(email);
			newUser.setRole("Độc giả"); // Mặc định là độc giả

			// 2. Lưu User vào DB và LẤY VỀ ID vừa tạo
			// (Trong UserDAO bạn đã có code trả về generated keys rồi)
			int newUserId = userDAO.addUser(newUser);

			if (newUserId > 0) {
				// --- ĐÂY LÀ ĐOẠN TỰ ĐỘNG HÓA ---
				// 3. Tự động tạo hồ sơ Độc giả liên kết với User vừa tạo
				Reader newReader = new Reader();
				newReader.setUserId(newUserId); // Liên kết ID tài khoản
				newReader.setHoTen(fullName); // Lấy tên người dùng làm tên độc giả
				newReader.setDiaChi("Chưa cập nhật"); // Mặc định
				newReader.setSoDienThoai(""); // Mặc định

				// Tự sinh Mã độc giả ngẫu nhiên (Ví dụ: DG + số ngẫu nhiên)
				// Để tránh trùng lặp
				Random rand = new Random();
				String maDocGia = "DG" + (1000 + rand.nextInt(9000));
				newReader.setMaDocGia(maDocGia);

				// Lưu vào bảng Readers
				readerDAO.addReader(newReader);
				// ---------------------------------

				// 4. Thông báo thành công
				request.setAttribute("message", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
				RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
				rd.forward(request, response);
			} else {
				request.setAttribute("error", "Đăng ký thất bại! Tên đăng nhập hoặc Email đã tồn tại.");
				RequestDispatcher rd = request.getRequestDispatcher("/pages/register.jsp");
				rd.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/pages/error.jsp");
		}
	}

	// --- HÀM QUÊN MẬT KHẨU (CODE CŨ GIỮ NGUYÊN) ---
	private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username").trim();
		String email = request.getParameter("email").trim();

		if (userDAO.checkUserAndEmail(username, email)) {
			String newPass = EmailUtil.generateRandomPassword();
			if (userDAO.updatePassword(username, newPass)) {
				try {
					String subject = "Cấp lại mật khẩu - Library System";
					String content = "Xin chào " + username + ",\n\nMật khẩu mới: " + newPass;
					EmailUtil.sendEmail(email, subject, content);
					request.setAttribute("message", "Mật khẩu mới đã gửi về email: " + email);
				} catch (Exception e) {
					request.setAttribute("error", "Lỗi gửi mail: " + e.getMessage());
				}
			} else {
				request.setAttribute("error", "Lỗi hệ thống.");
			}
		} else {
			request.setAttribute("error", "Tên tài khoản hoặc Email không đúng!");
		}
		request.getRequestDispatcher("/pages/forgot-password.jsp").forward(request, response);
	}

	// --- HÀM ĐĂNG NHẬP (CODE CŨ GIỮ NGUYÊN) ---
	private void loginUser(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = userDAO.getUser(username, password);

		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		} else {
			request.setAttribute("error", "Sai thông tin đăng nhập!");
			request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
		}
	}
}