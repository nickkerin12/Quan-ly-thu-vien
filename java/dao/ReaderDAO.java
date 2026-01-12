package dao;

import model.Reader;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReaderDAO {

    public List<Reader> getAllReaders() {
        List<Reader> list = new ArrayList<>();
        String sql = "SELECT * FROM Readers";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Reader reader = new Reader();
                reader.setReaderId(rs.getInt("readerId"));
                reader.setMaDocGia(rs.getString("maDocGia"));
                reader.setHoTen(rs.getString("hoTen"));
                reader.setDiaChi(rs.getString("diaChi"));
                reader.setSoDienThoai(rs.getString("soDienThoai"));
                reader.setUserId(rs.getInt("userId"));
                list.add(reader);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Reader getReaderById(int id) {
        String sql = "SELECT * FROM Readers WHERE readerId = ?";
        Reader reader = null;
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reader = new Reader();
                    reader.setReaderId(rs.getInt("readerId"));
                    reader.setMaDocGia(rs.getString("maDocGia"));
                    reader.setHoTen(rs.getString("hoTen"));
                    reader.setDiaChi(rs.getString("diaChi"));
                    reader.setSoDienThoai(rs.getString("soDienThoai"));
                    reader.setUserId(rs.getInt("userId"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return reader;
    }

    public void addReader(Reader reader) {
        String sql = "INSERT INTO Readers (maDocGia, hoTen, diaChi, soDienThoai, userId) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reader.getMaDocGia());
            ps.setString(2, reader.getHoTen());
            ps.setString(3, reader.getDiaChi());
            ps.setString(4, reader.getSoDienThoai());
            ps.setInt(5, reader.getUserId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void updateReader(Reader reader) {
        String sql = "UPDATE Readers SET maDocGia = ?, hoTen = ?, diaChi = ?, soDienThoai = ? WHERE readerId = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reader.getMaDocGia());
            ps.setString(2, reader.getHoTen());
            ps.setString(3, reader.getDiaChi());
            ps.setString(4, reader.getSoDienThoai());
            ps.setInt(5, reader.getReaderId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // --- PHẦN SỬA ĐỔI QUAN TRỌNG: DELETE READER ---
    public void deleteReader(int readerId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnect.getConnection();
            
            // 1. Lấy userId trước khi xóa
            int userId = -1;
            String getSql = "SELECT userId FROM Readers WHERE readerId = ?";
            ps = conn.prepareStatement(getSql);
            ps.setInt(1, readerId);
            rs = ps.executeQuery();
            if (rs.next()) userId = rs.getInt("userId");
            rs.close(); ps.close();

            // 2. Xóa lịch sử mượn trả (BorrowRecords) trước
            String delBorrow = "DELETE FROM BorrowRecords WHERE readerId = ?";
            ps = conn.prepareStatement(delBorrow);
            ps.setInt(1, readerId);
            ps.executeUpdate();
            ps.close();

            // 3. Xóa Độc giả (Readers)
            String delReader = "DELETE FROM Readers WHERE readerId = ?";
            ps = conn.prepareStatement(delReader);
            ps.setInt(1, readerId);
            ps.executeUpdate();
            ps.close();

            // 4. Xóa User (Users)
            if (userId != -1) {
                String delUser = "DELETE FROM Users WHERE userId = ?";
                ps = conn.prepareStatement(delUser);
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn!=null) conn.close(); } catch(Exception e){}
        }
    }

    public Reader getReaderByUserId(int userId) {
        String sql = "SELECT * FROM Readers WHERE userId = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Reader r = new Reader();
                    r.setReaderId(rs.getInt("readerId"));
                    r.setMaDocGia(rs.getString("maDocGia"));
                    r.setHoTen(rs.getString("hoTen"));
                    r.setDiaChi(rs.getString("diaChi"));
                    r.setSoDienThoai(rs.getString("soDienThoai"));
                    r.setUserId(rs.getInt("userId"));
                    return r;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}