<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo Phiếu Mượn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <jsp:include page="../header.jsp" />

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h4 class="mb-0">Phiếu Mượn Sách</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/borrow" method="post">
                            <input type="hidden" name="action" value="new"> 
                            <div class="mb-3">
                                <label class="form-label fw-bold">Người Mượn:</label>
                                <c:choose>
                                    <%-- Nếu là Admin: Cho chọn độc giả từ danh sách --%>
                                    <c:when test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Thủ thư'}">
                                        <select name="readerId" class="form-select" required>
                                            <option value="">-- Chọn Độc Giả --</option>
                                            <c:forEach var="r" items="${readers}">
                                                <option value="${r.readerId}">${r.hoTen} (${r.maDocGia})</option>
                                            </c:forEach>
                                        </select>
                                    </c:when>
                                    <%-- Nếu là Độc giả: Tự hiện tên mình và khóa lại --%>
                                    <c:otherwise>
                                        <input type="text" class="form-control" value="${sessionScope.user.fullName}" disabled readonly />
                                        </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Chọn Sách:</label>
                                <select name="bookId" class="form-select" required>
                                    <option value="">-- Chọn Sách Muốn Mượn --</option>
                                    <c:forEach var="b" items="${books}">
                                        <%-- Chỉ hiện sách còn hàng --%>
                                        <c:if test="${b.soLuongConLai > 0}">
                                            <option value="${b.bookId}">
                                                ${b.tenSach} - Tác giả: ${b.tacGia} (Còn: ${b.soLuongConLai})
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Ngày Mượn</label>
                                    <input type="date" name="borrowDate" class="form-control" required value="<%= LocalDate.now() %>">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Hẹn Trả (Dự kiến)</label>
                                    <input type="date" name="dueDate" class="form-control" required value="<%= LocalDate.now().plusDays(14) %>">
                                </div>
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn btn-primary btn-lg">Xác nhận Mượn Sách</button>
                                <a href="${pageContext.request.contextPath}/borrow" class="btn btn-outline-secondary">Quay lại danh sách</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>