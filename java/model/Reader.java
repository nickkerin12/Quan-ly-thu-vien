package model;

public class Reader {
    private int readerId;
    private String maDocGia; // Mã độc giả hiển thị (ví dụ: "DG-001")
    private String hoTen;
    private String diaChi;
    private String soDienThoai;
    private int userId; // Khóa ngoại liên kết đến bảng User

    // Constructor mặc định
    public Reader() {
    }

    // Constructor đầy đủ
    public Reader(int readerId, String maDocGia, String hoTen, String diaChi, String soDienThoai, int userId) {
        this.readerId = readerId;
        this.maDocGia = maDocGia;
        this.hoTen = hoTen;
        this.diaChi = diaChi;
        this.soDienThoai = soDienThoai;
        this.userId = userId;
    }

    // Getters and Setters
    public int getReaderId() {
        return readerId;
    }

    public void setReaderId(int readerId) {
        this.readerId = readerId;
    }

    public String getMaDocGia() {
        return maDocGia;
    }

    public void setMaDocGia(String maDocGia) {
        this.maDocGia = maDocGia;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}