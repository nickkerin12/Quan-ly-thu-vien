<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card-login { border: none; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .form-control { border-radius: 8px; padding: 10px 15px; }
        .btn-login { border-radius: 8px; padding: 10px; font-weight: bold; font-size: 16px; }
        .login-header { background: transparent; border-bottom: none; padding-top: 20px; }
    </style>
</head>
<body>

    <jsp:include page="../header.jsp" />

    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
            <div class="col-md-5">
                <div class="card card-login bg-white">
                    <div class="card-header login-header text-center">
                        <h3 class="fw-bold text-primary">Đăng Nhập</h3>
                        <p class="text-muted small">Vui lòng đăng nhập để tiếp tục</p>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger text-center p-2"><small>${error}</small></div>
                        </c:if>
                        
                        <c:if test="${not empty message}">
                            <div class="alert alert-success text-center p-2"><small>${message}</small></div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/auth" method="post">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">Tên đăng nhập</label>
                                <input type="text" name="username" class="form-control" placeholder="Nhập username..." required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                            </div>
                            
                            <div class="d-flex justify-content-between mb-3 small">
                                <div></div>
                                <a href="${pageContext.request.contextPath}/auth?action=forgotPassword" class="text-decoration-none">Quên mật khẩu?</a>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-login">Đăng Nhập</button>
                            </div>
                        </form>
                        
                        <hr class="my-4 text-secondary">
                        <div class="text-center">
                            <span class="text-muted">Chưa có tài khoản?</span>
                            <a href="${pageContext.request.contextPath}/auth?action=register" class="text-decoration-none fw-bold ms-1">Đăng ký ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>