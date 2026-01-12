USE LibraryManagement; -- Đảm bảo đang chọn đúng Database
GO

-- =============================================
-- PHẦN 1: XÓA BẢNG CŨ (Theo thứ tự Con -> Cha)
-- =============================================
IF OBJECT_ID('dbo.BorrowRecords', 'U') IS NOT NULL DROP TABLE dbo.BorrowRecords;
IF OBJECT_ID('dbo.Readers', 'U') IS NOT NULL DROP TABLE dbo.Readers;
IF OBJECT_ID('dbo.Books', 'U') IS NOT NULL DROP TABLE dbo.Books;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
GO

-- =============================================
-- PHẦN 2: TẠO BẢNG MỚI (Cấu trúc chuẩn)
-- =============================================

-- 1. Bảng Users (Tài khoản đăng nhập)
CREATE TABLE Users (
    userId INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL, -- Tên đăng nhập không dấu
    password VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,      -- Tên hiển thị có dấu
    email VARCHAR(100) NOT NULL,
    -- Quan trọng: role là NVARCHAR để lưu 'Độc giả', 'Thủ thư'
    role NVARCHAR(50) NOT NULL CHECK (role IN ('Admin', N'Thủ thư', N'Độc giả'))
);

-- 2. Bảng Books (Sách)
CREATE TABLE Books (
    bookId INT IDENTITY(1,1) PRIMARY KEY, -- Tự động tăng ID
    maSach VARCHAR(20) UNIQUE NOT NULL,   -- Mã sách phải duy nhất
    tenSach NVARCHAR(255) NOT NULL,
    tacGia NVARCHAR(100),
    theLoai NVARCHAR(100),
    namXB INT,
    soLuong INT DEFAULT 0,
    soLuongConLai INT DEFAULT 0 CHECK (soLuongConLai >= 0)
);

-- 3. Bảng Readers (Hồ sơ độc giả)
CREATE TABLE Readers (
    readerId INT IDENTITY(1,1) PRIMARY KEY, -- Tự động tăng ID
    maDocGia VARCHAR(20) UNIQUE NOT NULL,
    hoTen NVARCHAR(100) NOT NULL,
    diaChi NVARCHAR(255),
    soDienThoai VARCHAR(15),
    userId INT UNIQUE, -- Liên kết 1-1 với Users
    FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
);

-- 4. Bảng BorrowRecords (Mượn trả)
CREATE TABLE BorrowRecords (
    borrowId INT IDENTITY(1,1) PRIMARY KEY, -- Tự động tăng ID
    readerId INT,
    bookId INT,
    borrowDate DATE DEFAULT GETDATE(),
    dueDate DATE,
    returnDate DATE,
    status NVARCHAR(50) DEFAULT N'Đang mượn', -- Trạng thái tiếng Việt
    fineAmount FLOAT DEFAULT 0,
    FOREIGN KEY (readerId) REFERENCES Readers(readerId) ON DELETE CASCADE,
    FOREIGN KEY (bookId) REFERENCES Books(bookId) ON DELETE CASCADE
);
GO

-- =============================================
-- PHẦN 3: INSERT DỮ LIỆU MẪU 
-- =============================================

-- 1. Thêm Users
INSERT INTO Users (username, password, fullName, email, role) VALUES 
('admin', '12345', N'Quản Trị Viên', 'admin@library.com', 'Admin'),
('thuthu', '12345', N'Trần Thị Thủ Thư', 'thuthu@library.com', N'Thủ thư'),
('docgia1', '12345', N'Nguyễn Văn A', 'nva@gmail.com', N'Độc giả'),
('docgia2', '12345', N'Lê Thị B', 'ltb@gmail.com', N'Độc giả');

-- 2. Thêm Books
INSERT INTO Books (maSach, tenSach, tacGia, theLoai, namXB, soLuong, soLuongConLai) VALUES 
('IT-001', N'Lập trình Java căn bản', N'Phạm Văn Ất', N'Giáo trình', 2020, 10, 10),
('IT-002', N'Cấu trúc dữ liệu và giải thuật', N'Nguyễn Đức Nghĩa', N'Giáo trình', 2019, 5, 5),
('NV-001', N'Nhà Giả Kim', N'Paulo Coelho', N'Tiểu thuyết', 2018, 7, 6), -- Đã cho mượn 1 cuốn
('NV-002', N'Đắc Nhân Tâm', N'Dale Carnegie', N'Kỹ năng sống', 2021, 15, 15),
('KH-001', N'Vũ trụ trong vỏ hạt dẻ', N'Stephen Hawking', N'Khoa học', 2017, 3, 3);

-- 3. Thêm Readers (Liên kết với Users ở trên)
-- Lưu ý: userId phải khớp với thứ tự insert ở bảng Users
INSERT INTO Readers (maDocGia, hoTen, diaChi, soDienThoai, userId) VALUES 
('DG001', N'Nguyễn Văn A', N'Hà Nội', '0901234567', 3), -- Link với docgia1
('DG002', N'Lê Thị B', N'TP.HCM', '0909876543', 4); -- Link với docgia2

-- 4. Thêm BorrowRecords (Lịch sử mượn)
INSERT INTO BorrowRecords (readerId, bookId, borrowDate, dueDate, returnDate, status, fineAmount) VALUES 
(1, 3, '2023-12-01', '2023-12-15', NULL, N'Đang mượn', 0), -- Độc giả 1 mượn sách 3 chưa trả
(2, 1, '2023-11-20', '2023-12-05', '2023-12-04', N'Đã trả', 0); -- Độc giả 2 mượn sách 1 đã trả

PRINT N'=== KHỞI TẠO CSDL THÀNH CÔNG ===';
GO

USE LibraryManagement;
GO

INSERT INTO Books (maSach, tenSach, tacGia, theLoai, namXB, soLuong, soLuongConLai) VALUES 
-- 1. Sách Công nghệ thông tin (Tiếp nối mã IT)
('IT-003', N'Clean Code - Mã sạch', N'Robert C. Martin', N'Công nghệ thông tin', 2008, 5, 5),
('IT-004', N'Design Patterns', N'Erich Gamma', N'Công nghệ thông tin', 1994, 3, 3),
('IT-005', N'Nhập môn Trí tuệ nhân tạo', N'Stuart Russell', N'Giáo trình', 2021, 10, 10),
('IT-006', N'Hacker Lược sử', N'Steven Levy', N'Công nghệ thông tin', 2010, 4, 4),

-- 2. Sách Văn học Việt Nam (Mã VH)
('VH-001', N'Mắt Biếc', N'Nguyễn Nhật Ánh', N'Văn học VN', 2019, 15, 15),
('VH-002', N'Dế Mèn phiêu lưu ký', N'Tô Hoài', N'Văn học VN', 2015, 20, 20),
('VH-003', N'Số Đỏ', N'Vũ Trọng Phụng', N'Văn học VN', 2018, 8, 8),
('VH-004', N'Tuổi thơ dữ dội', N'Phùng Quán', N'Văn học VN', 2017, 6, 6),
('VH-005', N'Tắt đèn', N'Ngô Tất Tố', N'Văn học VN', 2016, 10, 10),

-- 3. Sách Văn học Nước ngoài (Mã NN)
('NN-001', N'Rừng Na Uy', N'Haruki Murakami', N'Tiểu thuyết', 2000, 7, 7),
('NN-002', N'Giết con chim nhại', N'Harper Lee', N'Tiểu thuyết', 2020, 12, 12),
('NN-003', N'Harry Potter và Hòn đá phù thủy', N'J.K. Rowling', N'Viễn tưởng', 1997, 10, 10),
('NN-004', N'Bố già (The Godfather)', N'Mario Puzo', N'Tiểu thuyết', 2018, 5, 5),
('NN-005', N'Hoàng tử bé', N'Antoine de Saint-Exupéry', N'Thiếu nhi', 2022, 25, 25),

-- 4. Sách Kinh tế & Quản trị (Mã KT)
('KT-001', N'Cha giàu cha nghèo', N'Robert Kiyosaki', N'Kinh tế', 2019, 15, 15),
('KT-002', N'Nhà đầu tư thông minh', N'Benjamin Graham', N'Kinh tế', 2020, 5, 5),
('KT-003', N'Marketing giỏi phải kiếm được tiền', N'Sergio Zyman', N'Kinh tế', 2016, 8, 8),

-- 5. Sách Kỹ năng sống & Tâm lý (Mã KN)
('KN-001', N'Tư duy nhanh và chậm', N'Daniel Kahneman', N'Tâm lý học', 2011, 6, 6),
('KN-002', N'Đánh thức con người phi thường trong bạn', N'Anthony Robbins', N'Kỹ năng sống', 2018, 10, 10),
('KN-003', N'Quẳng gánh lo đi và vui sống', N'Dale Carnegie', N'Kỹ năng sống', 2021, 20, 20);

GO
PRINT N'Đã thêm thành công 20 cuốn sách mới!';