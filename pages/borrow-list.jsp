<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Mượn Trả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <jsp:include page="../header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary fw-bold"><i class="fas fa-list-alt"></i> Danh sách Phiếu mượn</h2>
            <a href="${pageContext.request.contextPath}/borrow?action=new" class="btn btn-primary">
                <i class="fas fa-plus"></i> Tạo Phiếu Mượn
            </a>
        </div>

        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>Mã phiếu</th>
                                <th>Độc giả (ID)</th>
                                <th>Sách (ID)</th>
                                <th>Ngày mượn</th>
                                <th>Hạn trả</th>
                                <th>Ngày trả</th>
                                <th>Trạng thái</th>
                                <th>Phạt</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty borrowList}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">Chưa có dữ liệu mượn trả.</td>
                                </tr>
                            </c:if>

                            <c:forEach var="br" items="${borrowList}">
                                <tr>
                                    <td class="text-center fw-bold">#${br.borrowId}</td>
                                    <td class="text-center">${br.readerId}</td>
                                    <td class="text-center">${br.bookId}</td>
                                    <td class="text-center">${br.borrowDate}</td>
                                    <td class="text-center text-danger">${br.dueDate}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${br.returnDate != null}">${br.returnDate}</c:when>
                                            <c:otherwise><span class="badge bg-secondary">Chưa trả</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${br.status == 'Đã trả'}"><span class="badge bg-success">Đã trả</span></c:when>
                                            <c:when test="${br.status == 'Quá hạn'}"><span class="badge bg-danger">Quá hạn</span></c:when>
                                            <c:otherwise><span class="badge bg-warning text-dark">${br.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center text-danger fw-bold">
                                        <c:if test="${br.fineAmount > 0}">
                                            <fmt:formatNumber value="${br.fineAmount}" type="currency" currencySymbol="đ"/>
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <c:if test="${br.status != 'Đã trả'}">
                                            <a href="${pageContext.request.contextPath}/borrow?action=return&id=${br.borrowId}" 
                                               class="btn btn-primary btn-sm"
                                               onclick="return confirm('Xác nhận trả sách cho phiếu #${br.borrowId}?');">
                                               <i class="fas fa-undo"></i> Trả sách
                                            </a>
                                        </c:if>
                                        <c:if test="${br.status == 'Đã trả'}">
                                            <button class="btn btn-secondary btn-sm" disabled><i class="fas fa-check"></i> Hoàn tất</button>
                                        </c:if>
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