<%-- File: src/main/webapp/pages/reader-list.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Độc giả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <jsp:include page="../header.jsp" /> 

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary fw-bold"><i class="fas fa-users"></i> Quản lý Độc giả</h2>
            <a href="${pageContext.request.contextPath}/readers?action=new" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i> Thêm Độc giả mới
            </a>
        </div>

        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>ID</th>
                                <th>Mã ĐG</th>
                                <th>Họ và Tên</th>
                                <th>Số điện thoại</th>
                                <th>Địa chỉ</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty readerList}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        Chưa có độc giả nào trong hệ thống.
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="r" items="${readerList}">
                                <tr>
                                    <td class="text-center fw-bold text-secondary">${r.readerId}</td>
                                    <td class="text-center"><span class="badge bg-info text-dark">${r.maDocGia}</span></td>
                                    <td class="fw-bold">${r.hoTen}</td>
                                    <td>${r.soDienThoai}</td>
                                    <td>${r.diaChi}</td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/readers?action=view&id=${r.readerId}" class="btn btn-info btn-sm text-white" title="Xem chi tiết">
                                                <i class="fas fa-eye"></i> Xem
                                            </a>
                                            <a href="${pageContext.request.contextPath}/readers?action=edit&id=${r.readerId}" class="btn btn-warning btn-sm" title="Sửa">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/readers?action=delete&id=${r.readerId}" class="btn btn-danger btn-sm" 
                                               onclick="return confirm('Bạn có chắc muốn xóa độc giả này không?');" title="Xóa">
                                                <i class="fas fa-trash-alt"></i> Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="mt-3 text-end">
            <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none">← Quay về Trang chủ</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>