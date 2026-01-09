<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty reader ? 'Thêm Độc Giả' : 'Sửa Độc Giả'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <jsp:include page="../header.jsp" />

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">${empty reader ? 'Thêm Độc Giả Mới' : 'Cập Nhật Thông Tin'}</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/readers" method="post">
                            <input type="hidden" name="readerId" value="${empty reader ? 0 : reader.readerId}">

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Mã Độc Giả</label>
                                    <input type="text" name="maDocGia" class="form-control" value="${reader.maDocGia}" required placeholder="VD: DG001">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">User ID (Liên kết tài khoản)</label>
                                    <input type="number" name="userId" class="form-control" value="${reader.userId}" required placeholder="Nhập ID của User">
                                    <small class="text-muted">Nhập ID tài khoản đăng nhập của người này.</small>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Họ và Tên</label>
                                <input type="text" name="hoTen" class="form-control" value="${reader.hoTen}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Số Điện Thoại</label>
                                <input type="text" name="soDienThoai" class="form-control" value="${reader.soDienThoai}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Địa Chỉ</label>
                                <textarea name="diaChi" class="form-control" rows="3">${reader.diaChi}</textarea>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-3">
                                <a href="${pageContext.request.contextPath}/readers" class="btn btn-secondary">Hủy bỏ</a>
                                <button type="submit" class="btn btn-primary">
                                    ${empty reader ? 'Thêm Mới' : 'Lưu Thay Đổi'}
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