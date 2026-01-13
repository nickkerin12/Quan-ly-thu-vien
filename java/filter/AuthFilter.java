package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;

// Áp dụng bộ lọc cho toàn bộ ứng dụng
@WebFilter("/*")
public class AuthFilter implements Filter {

	
    // --- HÀM KIỂM TRA QUYỀN ADMIN ---
    // Dùng equalsIgnoreCase để chấp nhận cả "admin", "Admin", "ADMIN"
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }
	
	
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        

        
        // Đặt mã hóa UTF-8 cho toàn bộ request/response
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        
        // 1. DANH SÁCH CÁC TRANG CÔNG KHAI (Không cần đăng nhập)
        // Bao gồm: login, register, file css/js, và servlet auth
        if (uri.contains("/register.jsp") || 
        	uri.contains("/book-list.jsp") || 
        	uri.contains("/borrow-list.jsp") || 
            uri.contains("/books") ||
            uri.contains("/home") ||
            uri.contains("/auth") || 
            uri.contains("/css/") || 
            uri.contains("/js/") || 
            uri.endsWith("forgot-password.jsp") ||
            uri.contains("/images/")) {
            
            chain.doFilter(request, response);
            return;
        }

        // 2. KIỂM TRA ĐĂNG NHẬP
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // 3. PHÂN QUYỀN ADMIN (AUTHORIZATION)
        // Nếu truy cập trang quản lý Sách hoặc Độc giả mà không phải Admin
        boolean isAdminPage = uri.contains("/books") || uri.contains("/readers");
        boolean isAdminUser = ((user != null)
        		&&("Admin".equalsIgnoreCase(user.getRole()) || "Thủ thư".equalsIgnoreCase(user.getRole())));

		if (user == null) {
            // Chưa đăng nhập mà vào trang chức năng -> Chuyển về trang chủ
        	req.setAttribute("error", "Bạn phải đăng nhập mới dùng được chức năng này");
        	req.getRequestDispatcher("/home").forward(req, res);
            return;
        }
				
        if (isAdminPage && !isAdmin(req)) {
            // Người thường cố tình vào trang Admin -> Đẩy về trang chủ hoặc báo lỗi
        	req.setAttribute("error", "Bạn phải là ADMIN hoặc THỦ THƯ mới dùng được chức năng này");
            req.getRequestDispatcher("/home").forward(req, res);
            return;
        }


        // Cho phép đi tiếp
        chain.doFilter(request, response);
    }
}
