<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Ký Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .card-register { width: 100%; max-width: 500px; }
    </style>
</head>
<body>

<div class="card card-register shadow border-0">
    <div class="card-body p-4">
        <h3 class="text-center text-primary mb-4">ĐĂNG KÝ TÀI KHOẢN</h3>

        <form action="${pageContext.request.contextPath}/auth?action=register" method="post">
            <div class="mb-3">
                <label class="form-label">Họ và Tên</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            
            <input type="hidden" name="role" value="Độc giả">

            <button type="submit" class="btn btn-primary w-100">Đăng Ký</button>
            
            <div class="text-center mt-3">
                <p class="mb-0">Đã có tài khoản?</p>
                <a href="login.jsp" class="text-decoration-none fw-bold">Đăng nhập ngay</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>