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
        if (uri.contains("/login.jsp") || 
            uri.contains("/register.jsp") || 
            uri.contains("/auth") || 
            uri.contains("/css/") || 
            uri.contains("/js/") || 
            uri.endsWith("forgot-password.jsp") || // Trang quên mật khẩu sắp làm
            uri.contains("/images/")) {
            
            chain.doFilter(request, response);
            return;
        }

        // 2. KIỂM TRA ĐĂNG NHẬP
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Chưa đăng nhập -> Chuyển về trang Login
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        // 3. PHÂN QUYỀN ADMIN (AUTHORIZATION)
        // Nếu truy cập trang quản lý Sách hoặc Độc giả mà không phải Admin
        boolean isAdminPage = uri.contains("/books") || uri.contains("/readers");
        boolean isAdminUser = "Admin".equalsIgnoreCase(user.getRole()) || "Thủ thư".equalsIgnoreCase(user.getRole());

        if (isAdminPage && !isAdminUser) {
            // Người thường cố tình vào trang Admin -> Đẩy về trang chủ hoặc báo lỗi
            res.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        // Cho phép đi tiếp
        chain.doFilter(request, response);
    }
}