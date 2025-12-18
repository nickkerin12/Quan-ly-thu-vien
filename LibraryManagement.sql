-- 1. TẠO CƠ SỞ DỮ LIỆU
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'LibraryManagement')
BEGIN
    CREATE DATABASE LibraryManagement;
END
GO

-- 2. SỬ DỤNG CƠ SỞ DỮ LIỆU VỪA TẠO
USE LibraryManagement;
GO

-- 3. TẠO BẢNG USERS (Quản lý tài khoản)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' and xtype='U')
BEGIN
    CREATE TABLE Users (
        userId INT IDENTITY(1,1) PRIMARY KEY,
        username VARCHAR(100) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL, -- Trong thực tế, bạn PHẢI HASH mật khẩu này
        fullName NVARCHAR(255),
        email VARCHAR(255) UNIQUE,
        role VARCHAR(50) NOT NULL CHECK (role IN ('Admin', 'Thủ thư', 'Độc giả'))
    );
END
GO

-- 4. TẠO BẢNG READERS (Quản lý độc giả)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Readers' and xtype='U')
BEGIN
    CREATE TABLE Readers (
        readerId INT IDENTITY(1,1) PRIMARY KEY,
        maDocGia VARCHAR(50) NOT NULL UNIQUE,
        hoTen NVARCHAR(255) NOT NULL,
        diaChi NVARCHAR(500),
        soDienThoai VARCHAR(20),
        
        -- Mỗi độc giả liên kết với MỘT tài khoản người dùng
        -- Dùng UNIQUE để đảm bảo mối quan hệ 1-1
        userId INT NOT NULL UNIQUE, 
        
        CONSTRAINT FK_Reader_User FOREIGN KEY (userId) REFERENCES Users(userId)
    );
END
GO

-- 5. TẠO BẢNG BOOKS (Quản lý sách)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Books' and xtype='U')
BEGIN
    CREATE TABLE Books (
        bookId INT IDENTITY(1,1) PRIMARY KEY,
        maSach VARCHAR(50) NOT NULL UNIQUE,
        tenSach NVARCHAR(500) NOT NULL,
        tacGia NVARCHAR(255),
        theLoai NVARCHAR(100),
        namXB INT,
        soLuong INT NOT NULL,
        soLuongConLai INT NOT NULL,

        -- Đảm bảo số lượng còn lại không thể lớn hơn tổng số lượng
        CONSTRAINT CHK_SoLuong CHECK (soLuongConLai <= soLuong AND soLuongConLai >= 0)
    );
END
GO

-- 6. TẠO BẢNG BORROWRECORDS (Quản lý mượn - trả)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BorrowRecords' and xtype='U')
BEGIN
    CREATE TABLE BorrowRecords (
        borrowId INT IDENTITY(1,1) PRIMARY KEY,
        readerId INT NOT NULL,
        bookId INT NOT NULL,
        
        borrowDate DATE NOT NULL, -- Ngày mượn
        dueDate DATE NOT NULL,    -- Ngày hẹn trả
        returnDate DATE NULL,     -- Ngày trả thực tế (NULL nếu chưa trả)
        
        status NVARCHAR(100) NOT NULL, -- Ví dụ: 'Đang mượn', 'Đã trả', 'Quá hạn'
        fineAmount DECIMAL(10, 2) DEFAULT 0.00, -- Tiền phạt
        
        CONSTRAINT FK_Borrow_Reader FOREIGN KEY (readerId) REFERENCES Readers(readerId),
        CONSTRAINT FK_Borrow_Book FOREIGN KEY (bookId) REFERENCES Books(bookId)
    );
END
GO

--- DỮ LIỆU MẪU (TÙY CHỌN) ---

PRINT 'Đã tạo bảng thành công. Đang chèn dữ liệu mẫu...';

-- 1. Thêm tài khoản
INSERT INTO Users (username, password, fullName, email, role)
VALUES
('admin', '123', N'Quản Trị Viên', 'admin@thuvien.com', 'Admin'),
('thuthu', '123', N'Lê Thủ Thư', 'thuthu@thuvien.com', 'Thủ thư'),
('docgia01', '123', N'Trần Thị Ngọc Anh', 'docgia01@gmail.com', 'Độc giả'),
('docgia02', '123', N'Nguyễn Văn An', 'nguyenvanan@gmail.com', 'Độc giả'),
('docgia03', '123', N'Phạm Thị Bình', 'phamthibinh@gmail.com', 'Độc giả'),
('docgia04', '123', N'Lê Minh Cường', 'leminhcuong@gmail.com', 'Độc giả'),
('docgia05', '123', N'Hoàng Văn Dũng', 'hoangdung@gmail.com', 'Độc giả'),
('docgia06', '123', N'Vũ Thị Hoa', 'vuthihoa@gmail.com', 'Độc giả'),
('docgia07', '123', N'Ngô Minh Khánh', 'ngominhkhanh@gmail.com', 'Độc giả'),
('docgia08', '123', N'Bùi Thị Lan', 'buithilan@gmail.com', 'Độc giả'),
('docgia09', '123', N'Phan Văn Long', 'phanvanlong@gmail.com', 'Độc giả');

-- 2. Thêm thông tin độc giả (liên kết với tài khoản 'docgia01' có userId = 3)
INSERT INTO Readers (maDocGia, hoTen, diaChi, soDienThoai, userId)
VALUES
('DG001', N'Trần Thị Ngọc Anh', N'123 Đường ABC, Quận 1, TP. HCM', '0909123456', 3),
('DG002', N'Nguyễn Văn An', N'45 Lê Lợi, Quận 3, TP. HCM', '0912345678', 5),
('DG003', N'Phạm Thị Bình', N'78 Hai Bà Trưng, Quận 1, TP. HCM', '0987654321', 6),
('DG004', N'Lê Minh Cường', N'12 Nguyễn Huệ, Quận 5, TP. HCM', '0933123456', 7),
('DG005', N'Hoàng Văn Dũng', N'25 Nguyễn Trãi, Q.5, TP.HCM', '0908111222', 8),
('DG006', N'Vũ Thị Hoa', N'88 Trường Chinh, Q.Tân Bình, TP.HCM', '0911222333', 9),
('DG007', N'Ngô Minh Khánh', N'12 Lạc Long Quân, Q.11, TP.HCM', '0922333444', 10),
('DG008', N'Bùi Thị Lan', N'101 Âu Cơ, Q.Tân Phú, TP.HCM', '0933444555', 11),
('DG009', N'Phan Văn Long', N'56 Điện Biên Phủ, Q.Bình Thạnh, TP.HCM', '0944555666', 12);

-- 3. Thêm sách
INSERT INTO Books (maSach, tenSach, tacGia, theLoai, namXB, soLuong, soLuongConLai)
VALUES
('BK001', N'Lập trình Java Web', N'Nhiều tác giả', N'Công nghệ thông tin', 2023, 50, 50),
('BK002', N'SQL Server cơ bản', N'Nguyễn Tác Giả', N'Cơ sở dữ liệu', 2022, 30, 30),
('BK003', N'Cấu trúc dữ liệu & Giải thuật', N'Vũ Tác Giả', N'Công nghệ thông tin', 2021, 40, 40),
('BK004', N'Lập trình JSP & Servlet', N'Nguyễn Công Nghệ', N'Công nghệ thông tin', 2020, 20, 20),
('BK005', N'Hệ điều hành', N'Trần Khoa', N'Khoa học máy tính', 2019, 25, 25),
('BK006', N'Mạng máy tính', N'Andrew S. Tanenbaum', N'Công nghệ thông tin', 2018, 15, 15),
('BK007', N'Nhập môn Trí tuệ nhân tạo', N'Stuart Russell', N'Công nghệ thông tin', 2022, 10, 10);


-- 4. Thêm phiếu mượn (Độc giả DG001 mượn sách BK003)
INSERT INTO BorrowRecords (readerId, bookId, borrowDate, dueDate, status)
VALUES
(5, 2, '2025-11-08', '2025-11-22', N'Đang mượn'),
(6, 3, '2025-11-09', '2025-11-23', N'Đang mượn'),
(7, 5, '2025-11-10', '2025-11-24', N'Đang mượn'),
(8, 6, '2025-11-11', '2025-11-25', N'Đang mượn'),
(9, 7, '2025-11-12', '2025-11-26', N'Đang mượn');

-- 5. Thêm phiếu trả (Độc giả DG004 trả sách BK001)
INSERT INTO BorrowRecords (readerId, bookId, borrowDate, dueDate, status)
VALUES
(4, 1, '2025-10-02', '2025-10-16', '2025-10-15', N'Đã trả'),
(5, 4, '2025-10-04', '2025-10-18', '2025-10-17', N'Đã trả'),
(6, 6, '2025-10-06', '2025-10-20', '2025-10-19', N'Đã trả'),
(7, 2, '2025-10-08', '2025-10-22', '2025-10-21', N'Đã trả'),
(8, 3, '2025-10-10', '2025-10-24', '2025-10-23', N'Đã trả');

-- Cập nhật số sách còn lại sau khi mượn
UPDATE Books SET soLuongConLai = soLuongConLai - 1 WHERE bookId IN (2,3,5,6,7);

GO

PRINT 'Hoàn tất tạo CSDL và chèn dữ liệu mẫu.';
GO
