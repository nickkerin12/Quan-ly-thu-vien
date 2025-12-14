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
LibraryManagementSystem/
│
├── src/main/java/                     <-- SOURCE CODE JAVA (BACKEND)
│   │
│   ├── controller/                    <-- Xử lý điều hướng & Logic nghiệp vụ
│   │   ├── AuthController.java        (Đăng nhập, Đăng xuất, Đăng ký)
│   │   ├── BookController.java        (CRUD Sách, Xem sách theo tác giả)
│   │   ├── ReaderController.java      (CRUD Độc giả, Xem chi tiết độc giả)
│   │   └── BorrowReturnController.java (Mượn sách, Trả sách, Nộp phạt)
│   │
│   ├── dao/                           <-- Giao tiếp với SQL Server
│   │   ├── UserDAO.java               (Xử lý bảng Users)
│   │   ├── BookDAO.java               (Xử lý bảng Books)
│   │   ├── ReaderDAO.java             (Xử lý bảng Readers)
│   │   └── BorrowDAO.java             (Xử lý bảng BorrowRecords)
│   │
│   ├── model/                         <-- Đối tượng dữ liệu (POJO)
│   │   ├── User.java
│   │   ├── Book.java
│   │   ├── Reader.java
│   │   └── BorrowRecord.java
│   │
│   └── util/                          <-- Tiện ích dùng chung
│       └── DBConnect.java             (Kết nối JDBC SQL Server)
│
├── src/main/webapp/                   <-- GIAO DIỆN WEB (FRONTEND)
│   │
│   ├── index.jsp                      <-- Trang chủ (Dashboard) & Điều hướng chính
│   │
│   ├── pages/                         <-- Thư mục chứa các file giao diện con
│   │   ├── header.jsp                 (Thanh menu điều hướng dùng chung)
│   │   ├── login.jsp                  (Form Đăng nhập)
│   │   ├── register.jsp               (Form Đăng ký)
│   │   │
│   │   ├── book-list.jsp              (Danh sách Sách - Phân quyền Admin/User)
│   │   ├── book-form.jsp              (Form Thêm / Sửa Sách)
│   │   ├── books-by-author.jsp        (Danh sách sách lọc theo Tác giả)
│   │   │
│   │   ├── reader-list.jsp            (Danh sách Độc giả - Phân quyền Admin/User)
│   │   ├── reader-form.jsp            (Form Thêm / Sửa Độc giả)
│   │   ├── reader-detail.jsp          (Xem thông tin & Lịch sử mượn của Độc giả)
│   │   │
│   │   ├── borrow-list.jsp            (Danh sách phiếu Mượn/Trả & Nộp phạt)
│   │   └── borrow-form.jsp            (Form Tạo phiếu mượn mới)
│   │
│   ├── META-INF/
│   │   └── MANIFEST.MF
│   │
│   └── WEB-INF/                       <-- Cấu hình & Thư viện
│       ├── web.xml                    (File cấu hình Servlet - Deployment Descriptor)
│       └── lib/                       (Nơi chứa các file .jar)
│           ├── mssql-jdbc-12.x.x.jar  (Driver kết nối SQL Server)
│           ├── jakarta.servlet.jsp.jstl-3.0.0.jar
│           └── jakarta.servlet.jsp.jstl-api-3.0.0.jar
│
└── LibraryManagement.sql              (File Script tạo bảng SQL Server để lưu trữ)
