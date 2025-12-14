# 📚 Library Management System (Hệ thống Quản lý Thư viện)

Hệ thống quản lý thư viện đơn giản và hiệu quả được xây dựng bằng **Java Servlet, JSP và SQL Server**. Dự án áp dụng mô hình **MVC (Model-View-Controller)** và tuân thủ các nguyên tắc thiết kế hướng đối tượng.

## 🚀 Tính Năng Chính

Hệ thống phân chia quyền hạn rõ ràng giữa **Quản trị viên (Admin)** và **Độc giả (User)**.

### 1. Quản lý Sách (Books)
* Xem danh sách sách, hiển thị trạng thái (Có sẵn / Hết sách).
* **Admin:** Thêm sách mới, Sửa thông tin sách, Xóa sách.
* Tìm kiếm/Lọc sách theo tác giả.
* Tự động quản lý số lượng tồn kho.

### 2. Quản lý Độc giả (Readers)
* **Admin:** Xem danh sách độc giả, Thêm/Sửa/Xóa độc giả.
* **Chi tiết:** Xem lịch sử mượn sách của từng độc giả.

### 3. Quản lý Mượn / Trả (Borrow/Return)
* Tạo phiếu mượn sách mới (Kiểm tra tồn kho, kiểm tra độc giả).
* Ghi nhận trả sách.
* **Tính phí phạt:** Tự động tính tiền phạt nếu trả quá hạn.
* **Nộp phạt:** Chức năng xác nhận thu tiền phạt.

### 4. Hệ thống Tài khoản (Auth)
* Đăng ký / Đăng nhập.
* Phân quyền (Role-based Authorization): Admin và Độc giả.
* Bảo mật các trang quản trị (Redirect về trang chủ hoặc Login nếu cố tình truy cập).

---

## 🛠️ Công Nghệ Sử Dụng

* **Ngôn ngữ:** Java (JDK 11 hoặc cao hơn).
* **Web Framework:** Java Servlet, JSP, JSTL.
* **Database:** Microsoft SQL Server.
* **Frontend:** Bootstrap 5 (Giao diện Responsive), HTML5, CSS3.
* **IDE:** Eclipse (Enterprise Java and Web Developer).
* **Server:** Apache Tomcat 9/10.

---

## 📂 Cấu Trúc Dự Án

```text
webapp/
├── index.jsp                  # Trang Dashboard chính
├── pages/                     
│   ├── header.jsp             # Menu điều hướng (Navbar)
│   ├── login.jsp              # Form Đăng nhập
│   ├── register.jsp           # Form Đăng ký
│   ├── book-list.jsp          # Danh sách sách
│   ├── book-form.jsp          # Form Thêm/Sửa sách
│   ├── reader-list.jsp        # Danh sách độc giả
│   ├── reader-detail.jsp      # Chi tiết & Lịch sử mượn của độc giả
│   ├── reader-form.jsp        # Form Thêm/Sửa độc giả
│   ├── borrow-list.jsp        # Danh sách phiếu mượn & Nộp phạt
│   └── borrow-form.jsp        # Form Mượn sách
└── META-INF/ & WEB-INF/       # Cấu hình hệ thống
