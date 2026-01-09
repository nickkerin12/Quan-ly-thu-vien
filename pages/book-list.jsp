<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <jsp:include page="../header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary fw-bold"><i class="fas fa-book"></i> Kho Sách</h2>
            
            <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Thủ thư'}">
                <a href="${pageContext.request.contextPath}/books?action=new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm Sách
                </a>
            </c:if>
        </div>

        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>Mã sách</th>
                                <th>Tên sách</th>
                                <th>Tác giả</th>
                                <th>Thể loại</th>
                                <th>Năm XB</th>
                                <th>Số lượng</th>
                                <th>Còn lại</th> <c:if test="${sessionScope.user.role == 'Admin'}">
                                    <th>Hành động</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${bookList}">
                                <tr>
                                    <td class="text-center fw-bold text-secondary">${b.maSach}</td>
                                    <td class="fw-bold text-primary">${b.tenSach}</td>
                                    <td>${b.tacGia}</td>
                                    <td><span class="badge bg-secondary">${b.theLoai}</span></td>
                                    <td class="text-center">${b.namXB}</td>
                                    <td class="text-center">${b.soLuong}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${b.soLuongConLai > 0}">
                                                <span class="badge bg-success">${b.soLuongConLai}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Hết hàng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <c:if test="${sessionScope.user.role == 'Admin'}">
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/books?action=edit&bookId=${b.bookId}" class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/books?action=delete&bookId=${b.bookId}" class="btn btn-danger btn-sm" onclick="return confirm('Xóa sách này?');">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>