<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row justify-content-center mt-4">
	<div class="col-md-6">
		<div class="card shadow">
			<div class="card-header bg-success text-white">
				<h4>Tạo Phiếu Mượn Mới</h4>
			</div>
			<div class="card-body">
				<form action="${pageContext.request.contextPath}/borrow"
					method="post">
					<input type="hidden" name="borrowId" value="0"> <input
						type="hidden" name="status" value="Đang mượn"> <input
						type="hidden" name="fineAmount" value="0.0">

					<div class="mb-3">
						<label class="form-label">Chọn Độc Giả:</label> <select
							name="readerId" class="form-select" required>
							<option value="" disabled selected>-- Chọn độc giả --</option>
							<c:forEach var="r" items="${readers}">
								<option value="${r.readerId}">${r.hoTen}(Mã:
									${r.maDocGia})</option>
							</c:forEach>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label">Chọn Sách:</label> <select name="bookId"
							class="form-select" required>
							<option value="" disabled selected>-- Chọn sách --</option>
							<c:forEach var="b" items="${books}">
								<option value="${b.bookId}"
									${b.soLuongConLai <= 0 ? 'disabled' : ''}>
									${b.tenSach} - (Còn: ${b.soLuongConLai}) ${b.soLuongConLai <= 0 ? '[HẾT]' : ''}
								</option>
							</c:forEach>
						</select>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label>Ngày Mượn</label> <input type="date" name="borrowDate"
								id="dateToday" class="form-control" required>
						</div>
						<div class="col-md-6 mb-3">
							<label>Ngày Hẹn Trả</label> <input type="date" name="dueDate"
								class="form-control" required>
						</div>
					</div>

					<button type="submit" class="btn btn-success w-100">Xác
						Nhận Mượn</button>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	// JS thuần để set ngày hôm nay vào input
	document.getElementById('dateToday').valueAsDate = new Date();
</script>

</div>
</body>
</html>