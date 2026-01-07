package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthController extends HttpServlet {
	private UserDAO userDAO;

	@Override
	public void init() {
		userDAO = new UserDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("logout".equals(action)) {
			HttpSession session = request.getSession();
			session.invalidate(); // Hủy session
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
		} else if ("forgotPassword".equals(action)) { // Xử lý quên mật khẩu
			handleForgotPassword(request, response);
		} else {
			loginUser(request, response);
		}
	}

	// --- HÀM XỬ LÝ ĐĂNG KÝ ---
	private void registerUser(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		try {
			String fullName = request.getParameter("fullName");
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String role = request.getParameter("role"); // Mặc định là "Độc giả" từ form

			// Kiểm tra sơ bộ
			User existingUser = userDAO.getUser(username, password); // Cách này chưa tối ưu nhưng tạm dùng để check
																		// trùng
			// Đúng ra nên có hàm userDAO.checkUsername(username)

			User newUser = new User();
			newUser.setUsername(username);
			newUser.setPassword(password); // Lưu ý: Thực tế nên mã hóa password
			newUser.setFullName(fullName);
			newUser.setEmail(email);
			newUser.setRole(role);

			int result = userDAO.addUser(newUser);

			if (result > 0) {
				// Đăng ký thành công -> Về trang login và báo thành công
				request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
				RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
				rd.forward(request, response);
			} else {
				// Đăng ký thất bại
				request.setAttribute("error", "Đăng ký thất bại! Có thể tên đăng nhập đã tồn tại.");
				RequestDispatcher rd = request.getRequestDispatcher("/pages/register.jsp");
				rd.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/pages/error.jsp");
		}
	}

	// --- HÀM XỬ LÝ ĐĂNG NHẬP ---
	private void loginUser(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		User user = userDAO.getUser(username, password);

		if (user != null) {
			// Đăng nhập thành công
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			response.sendRedirect(request.getContextPath() + "/index.jsp");
		} else {
			// Đăng nhập thất bại
			request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");

			// Forward về lại trang login để hiện lỗi
			RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
			rd.forward(request, response);
		}
	}

	// Hàm xử lý Quên Mật Khẩu
	private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy cả Username và Email từ form, dùng trim() để xóa khoảng trắng thừa
        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        
        // 2. Kiểm tra xem cặp Username + Email này có tồn tại không
        if (userDAO.checkUserAndEmail(username, email)) {
            
            // 3. Tạo mật khẩu mới
            String newPass = util.EmailUtil.generateRandomPassword();
            
            // 4. Cập nhật vào DB (Dựa theo username)
            boolean updated = userDAO.updatePassword(username, newPass);
            
            if (updated) {
                // 5. Gửi mail
                try {
                    String subject = "Cấp lại mật khẩu - Library System";
                    String content = "Xin chào " + username + ",\n\nMật khẩu mới của bạn là: " + newPass + "\n\nVui lòng đăng nhập và đổi lại mật khẩu.";
                    util.EmailUtil.sendEmail(email, subject, content);
                    
                    request.setAttribute("message", "Mật khẩu mới đã được gửi vào email: " + email);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Lỗi gửi mail: " + e.getMessage());
                }
            } else {
                request.setAttribute("error", "Lỗi hệ thống, không thể cập nhật mật khẩu.");
            }
        } else {
            // Báo lỗi nếu Username không khớp với Email
            request.setAttribute("error", "Tên tài khoản hoặc Email không chính xác!");
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/pages/forgot-password.jsp");
        rd.forward(request, response);
    }
}