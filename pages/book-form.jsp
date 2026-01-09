<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty book ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <jsp:include page="../header.jsp" />

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">${empty book ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/books" method="post">
                            <input type="hidden" name="bookId" value="${empty book ? 0 : book.bookId}">
                            <c:if test="${not empty book}">
                                <input type="hidden" name="soLuongConLai" value="${book.soLuongConLai}">
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Mã Sách</label>
                                <input type="text" name="maSach" class="form-control" value="${book.maSach}" required placeholder="VD: BK001">
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên Sách</label>
                                <input type="text" name="tenSach" class="form-control" value="${book.tenSach}" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Tác Giả</label>
                                    <input type="text" name="tacGia" class="form-control" value="${book.tacGia}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Thể Loại</label>
                                    <input type="text" name="theLoai" class="form-control" value="${book.theLoai}">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Năm XB</label>
                                    <input type="number" name="namXB" class="form-control" value="${empty book ? 2024 : book.namXB}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Tổng Số Lượng</label>
                                    <input type="number" name="soLuong" class="form-control" value="${empty book ? 1 : book.soLuong}" min="1" required>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-3">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">Hủy bỏ</a>
                                <button type="submit" class="btn btn-primary">
                                    ${empty book ? 'Thêm Mới' : 'Lưu Cập Nhật'}
                                </button>
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