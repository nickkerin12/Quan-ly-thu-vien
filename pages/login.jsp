<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .card-login { width: 100%; max-width: 400px; }
    </style>
</head>
<body>

<div class="card card-login shadow border-0">
    <div class="card-body p-4">
        <h3 class="text-center text-primary mb-4">ĐĂNG NHẬP</h3>

        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center" role="alert">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="post">
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Vào Hệ Thống</button>
        </form>
    </div>
</div>

</body>
</html>