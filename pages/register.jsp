<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card-register { border: none; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .form-control { border-radius: 8px; padding: 10px 15px; }
        .btn-register { border-radius: 8px; padding: 10px; font-weight: bold; font-size: 16px; }
        .register-header { background: transparent; border-bottom: none; padding-top: 20px; }
    </style>
</head>
<body>

    <jsp:include page="../header.jsp" />

    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-5">
                <div class="card card-register bg-white my-5">
                    <div class="card-header register-header text-center">
                        <h3 class="fw-bold text-primary">Tạo Tài Khoản</h3>
                        <p class="text-muted small">Nhập thông tin để đăng ký thành viên mới</p>
                    </div>

                    <div class="card-body p-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger text-center p-2"><small>${error}</small></div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/auth" method="post">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">Họ và tên</label>
                                <input type="text" name="fullName" class="form-control" placeholder="Nguyễn Văn A" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">Email</label>
                                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">Tên đăng nhập</label>
                                <input type="text" name="username" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>

                            <div class="d-grid mt-4">
                                <button type="submit" class="btn btn-primary btn-register">Đăng Ký Ngay</button>
                            </div>
                        </form>

                        <hr class="my-4 text-secondary">
                        <div class="text-center">
                            <span class="text-muted">Đã có tài khoản?</span>
                            <a href="${pageContext.request.contextPath}/auth?action=login" class="text-decoration-none fw-bold ms-1">Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>