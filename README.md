# 📚 Library Management System (Hệ thống Quản lý Thư viện)

Hệ thống quản lý thư viện được xây dựng bằng **Java Servlet, JSP và SQL Server** theo mô hình **MVC (Model-View-Controller)**. Dự án tập trung vào việc xử lý nghiệp vụ quản lý sách, độc giả và quy trình mượn trả, tích hợp phân quyền và gửi email tự động.

## 🚀 Tính Năng Chính

Hệ thống phân chia quyền hạn rõ ràng giữa **Quản trị viên (Admin/Thủ thư)** và **Độc giả**.

### 1. Quản lý Sách (Books)
* **Hiển thị:** Danh sách sách, trạng thái tồn kho (Có sẵn / Hết sách), phân trang (tùy chỉnh).
* **Admin/Thủ thư:** Thêm sách mới, Cập nhật thông tin, Xóa sách.
* **Logic:** Tự động trừ số lượng khi có người mượn, cộng lại khi trả.

### 2. Quản lý Độc giả (Readers)
* **Tự động hóa:** Tự động tạo hồ sơ độc giả khi người dùng đăng ký tài khoản mới.
* **Admin:** Xem danh sách độc giả, Sửa thông tin liên lạc.
* **Chi tiết:** Xem lịch sử mượn trả sách của từng độc giả (gồm cả sách đang mượn và sách đã trả).

### 3. Quản lý Mượn / Trả (Borrow/Return)
* **Mượn sách:**
    * Admin có thể chọn độc giả từ danh sách.
    * Độc giả có thể tự xem sách và yêu cầu mượn (hiện thị thông tin tự động).
    * Kiểm tra số lượng sách còn lại trước khi cho mượn.
* **Trả sách:** Ghi nhận ngày trả thực tế.
* **Trạng thái:** Quản lý các trạng thái: *Đang mượn, Đã trả, Quá hạn*.
* **Phạt:** Hệ thống tính toán và hiển thị tiền phạt nếu trả muộn.

### 4. Hệ thống Tài khoản & Bảo mật (Auth)
* **Đăng nhập / Đăng xuất:** Sử dụng Session để quản lý phiên làm việc.
* **Đăng ký:** Người dùng mới đăng ký tài khoản (Role mặc định là Độc giả).
* **Quên mật khẩu:** Gửi mật khẩu mới qua Email (Sử dụng SMTP Gmail).
* **Phân quyền (Filter):** Sử dụng `AuthFilter` để chặn truy cập trái phép vào các trang quản trị (Admin/Thủ thư) nếu không đủ quyền.

---

## 🛠️ Công Nghệ Sử Dụng

* **Ngôn ngữ:** Java (JDK 11 trở lên).
* **Mô hình:** MVC (Model - View - Controller).
* **Web Server:** Apache Tomcat 10 (Hỗ trợ `jakarta.servlet`).
* **Database:** Microsoft SQL Server.
* **Frontend:** JSP, JSTL, Bootstrap 5 (Giao diện Responsive).
* **Thư viện (Dependencies):**
    * `mssql-jdbc-13.2.1.jre11.jar`: Kết nối Database.
    * `jakarta.servlet.jsp.jstl-3.0.0.jar`: Thư viện thẻ JSTL.
    * `javax.mail-1.6.2.jar`: Gửi Email.

---

## 📂 Cấu Trúc Dự Án

```tree
LibraryManagementSystem/
│
├── src/main/java/                     <-- BACKEND (JAVA)
│   │
│   ├── controller/                    <-- Xử lý điều hướng & Logic
│   │   ├── AuthController.java        (Login, Register, Logout, ForgotPass)
│   │   ├── BookController.java        (CRUD Sách)
│   │   ├── ReaderController.java      (CRUD Độc giả)
│   │   ├── BorrowReturnController.java (Mượn, Trả, Lịch sử)
│   │   └── HomeController.java        (Điều hướng trang chủ)
│   │
│   ├── dao/                           <-- Thao tác dữ liệu (JDBC)
│   │   ├── UserDAO.java               (Login, Check Email)
│   │   ├── BookDAO.java               (Thêm/Sửa/Xóa Sách)
│   │   ├── ReaderDAO.java             (Quản lý hồ sơ độc giả)
│   │   └── BorrowDAO.java             (Xử lý phiếu mượn)
│   │
│   ├── model/                         <-- Object Mapping (POJO)
│   │   ├── User.java
│   │   ├── Book.java
│   │   ├── Reader.java
│   │   └── BorrowRecord.java
│   │
│   ├── filter/                        <-- Bảo mật & Phân quyền
│   │   └── AuthFilter.java            (Chặn truy cập trái phép, set UTF-8)
│   │
│   └── util/                          <-- Tiện ích
│       ├── DBConnect.java             (Kết nối SQL Server)
│       └── EmailUtil.java             (Gửi mail SMTP)
│
├── src/main/webapp/                   <-- FRONTEND
│   │
│   ├── index.jsp                      (Trang chủ giới thiệu)
│   │
│   ├── pages/                         <-- Giao diện chức năng
│   │   ├── header.jsp                 (Menu điều hướng dùng chung)
│   │   ├── login.jsp                  (Form Đăng nhập)
│   │   ├── register.jsp               (Form Đăng ký)
│   │   ├── error.jsp                  (Trang báo lỗi)
│   │   ├── forgot-password.jsp        (Trang quên mật khẩu)
│   │   │
│   │   ├── book-list.jsp              (Danh sách Sách)
│   │   ├── book-form.jsp              (Thêm/Sửa Sách)
│   │   │
│   │   ├── reader-list.jsp            (Danh sách Độc giả)
│   │   ├── reader-form.jsp            (Sửa Độc giả)
│   │   ├── reader-detail.jsp          (Chi tiết & Lịch sử mượn)
│   │   │
│   │   ├── borrow-list.jsp            (Danh sách phiếu mượn)
│   │   └── borrow-form.jsp            (Tạo phiếu mượn mới)
│   │
│   ├── WEB-INF/
│   │   ├── web.xml                    (Deployment Descriptor)
│   │   └── lib/                       (Nơi chứa file .jar)
│
└── LibraryManagement.sql              (Script tạo CSDL SQL Server)
