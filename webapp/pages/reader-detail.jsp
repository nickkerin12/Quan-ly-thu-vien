<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Độc giả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="../header.jsp" />

    <div class="container mt-4">
        <a href="readers" class="btn btn-secondary mb-3">← Quay lại danh sách</a>

        <div class="row">
            <div class="col-md-4">
                <div class="card shadow mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="m-0">👤 Thông tin cá nhân</h5>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <img src="https://via.placeholder.com/150" class="rounded-circle" alt="Avatar">
                        </div>
                        <p><strong>Mã Độc giả:</strong> <span class="text-primary">${reader.maDocGia}</span></p>
                        <p><strong>Họ tên:</strong> ${reader.hoTen}</p>
                        <p><strong>Số điện thoại:</strong> ${reader.soDienThoai}</p>
                        <p><strong>Địa chỉ:</strong> ${reader.diaChi}</p>
                        <hr>
                        <div class="d-grid">
                            <a href="readers?action=edit&id=${reader.readerId}" class="btn btn-warning">Chỉnh sửa thông tin</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="m-0">📚 Lịch sử mượn sách</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty history}">
                            <div class="alert alert-info">Độc giả này chưa mượn cuốn sách nào.</div>
                        </c:if>

                        <c:if test="${not empty history}">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Mã phiếu</th>
                                            <th>ID Sách</th>
                                            <th>Ngày mượn</th>
                                            <th>Ngày trả</th>
                                            <th>Trạng thái</th>
                                            <th>Phạt</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="rec" items="${history}">
                                            <tr>
                                                <td>#${rec.borrowId}</td>
                                                <td>${rec.bookId}</td>
                                                <td>${rec.borrowDate}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${rec.returnDate != null}">
                                                            ${rec.returnDate}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning text-dark">Chưa trả</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${rec.status == 'Đã trả'}">
                                                            <span class="badge bg-success">Đã trả</span>
                                                        </c:when>
                                                        <c:when test="${rec.status == 'Quá hạn'}">
                                                            <span class="badge bg-danger">Quá hạn</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-info">${rec.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${rec.fineAmount > 0}">
                                                        <span class="text-danger fw-bold">
                                                            <fmt:formatNumber value="${rec.fineAmount}" type="currency" currencySymbol="đ"/>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${rec.fineAmount <= 0}">-</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>