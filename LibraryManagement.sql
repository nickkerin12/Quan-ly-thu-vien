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
('thuthu01', '123', N'Nguyễn Văn Thủ Thư', 'thuthu01@thuvien.com', 'Thủ thư'),
('docgia01', '123', N'Trần Thị Độc Giả', 'docgia01@gmail.com', 'Độc giả');

-- 2. Thêm thông tin độc giả (liên kết với tài khoản 'docgia01' có userId = 3)
INSERT INTO Readers (maDocGia, hoTen, diaChi, soDienThoai, userId)
VALUES
('DG001', N'Trần Thị Độc Giả', N'123 Đường ABC, Quận 1, TP. HCM', '0909123456', 3);

-- 3. Thêm sách
INSERT INTO Books (maSach, tenSach, tacGia, theLoai, namXB, soLuong, soLuongConLai)
VALUES
('BK001', N'Lập trình Java Web', N'Nhiều tác giả', N'Công nghệ thông tin', 2023, 50, 50),
('BK002', N'SQL Server cơ bản', N'Nguyễn Tác Giả', N'Cơ sở dữ liệu', 2022, 30, 30),
('BK003', N'Cấu trúc dữ liệu & Giải thuật', N'Vũ Tác Giả', N'Công nghệ thông tin', 2021, 40, 39);

-- 4. Thêm một phiếu mượn (Độc giả DG001 mượn sách BK003)
INSERT INTO BorrowRecords (readerId, bookId, borrowDate, dueDate, status)
VALUES
(1, 3, '2025-11-01', '2025-11-15', N'Đang mượn');
-- (Lưu ý: sách BK003 đã được cập nhật soLuongConLai = 39 ở trên)

GO

PRINT 'Hoàn tất tạo CSDL và chèn dữ liệu mẫu.';
GO