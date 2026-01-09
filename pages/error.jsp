<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đã xảy ra lỗi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .error-code { font-size: 6rem; font-weight: bold; color: #dc3545; }
    </style>
</head>
<body class="bg-light">
    <div class="container error-container">
        <div>
            <div class="error-code">Opps!</div>
            <h2 class="mb-4">Đã xảy ra lỗi không mong muốn</h2>
            
            <div class="alert alert-warning d-inline-block text-start">
                <strong>Chi tiết lỗi:</strong> <br>
                <% 
                    String msg = (String) request.getAttribute("message");
                    if(msg == null) msg = "Hệ thống đang bận hoặc gặp sự cố kỹ thuật.";
                %>
                <%= msg %>
            </div>
            
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary btn-lg">
                    🏠 Quay về Trang chủ
                </a>
                <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg ms-2">
                    Quay lại trang trước
                </a>
            </div>
        </div>
    </div>
</body>
</html>