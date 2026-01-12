package model;

public class Book {
    private int bookId; 
    private String maSach; // Mã sách hiển thị (ví dụ: "SGK-001")
    private String tenSach;
    private String tacGia;
    private String theLoai;
    private int namXB; // Năm xuất bản
    private int soLuong; // Tổng số lượng
    private int soLuongConLai; // Số lượng còn lại trong thư viện

    // Constructor mặc định
    public Book() {
    }

    // Constructor đầy đủ
    public Book(int bookId, String maSach, String tenSach, String tacGia, String theLoai, int namXB, int soLuong, int soLuongConLai) {
        this.bookId = bookId;
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.tacGia = tacGia;
        this.theLoai = theLoai;
        this.namXB = namXB;
        this.soLuong = soLuong;
        this.soLuongConLai = soLuongConLai;
    }

    // Getters and Setters
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getMaSach() {
        return maSach;
    }

    public void setMaSach(String maSach) {
        this.maSach = maSach;
    }

    public String getTenSach() {
        return tenSach;
    }

    public void setTenSach(String tenSach) {
        this.tenSach = tenSach;
    }

    public String getTacGia() {
        return tacGia;
    }

    public void setTacGia(String tacGia) {
        this.tacGia = tacGia;
    }

    public String getTheLoai() {
        return theLoai;
    }

    public void setTheLoai(String theLoai) {
        this.theLoai = theLoai;
    }

    public int getNamXB() {
        return namXB;
    }

    public void setNamXB(int namXB) {
        this.namXB = namXB;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public int getSoLuongConLai() {
        return soLuongConLai;
    }

    public void setSoLuongConLai(int soLuongConLai) {
        this.soLuongConLai = soLuongConLai;
    }
}