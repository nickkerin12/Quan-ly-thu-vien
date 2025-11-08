package dao;

import model.BorrowRecord;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BorrowDAO {

    // Lấy tất cả lịch sử mượn/trả
    public List<BorrowRecord> getAllBorrowRecords() {
        List<BorrowRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM BorrowRecords ORDER BY borrowDate DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BorrowRecord record = new BorrowRecord();
                record.setBorrowId(rs.getInt("borrowId"));
                record.setReaderId(rs.getInt("readerId"));
                record.setBookId(rs.getInt("bookId"));
                
                record.setBorrowDate(rs.getDate("borrowDate").toLocalDate());
                record.setDueDate(rs.getDate("dueDate").toLocalDate());
                if (rs.getDate("returnDate") != null) {
                    record.setReturnDate(rs.getDate("returnDate").toLocalDate());
                }
                
                record.setStatus(rs.getString("status"));
                record.setFineAmount(rs.getDouble("fineAmount"));
                list.add(record);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * HÀM MỚI: Lấy một phiếu mượn bằng ID.
     */
    public BorrowRecord getBorrowRecordById(int id) {
        String sql = "SELECT * FROM BorrowRecords WHERE borrowId = ?";
        BorrowRecord record = null;
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    record = new BorrowRecord();
                    record.setBorrowId(rs.getInt("borrowId"));
                    record.setReaderId(rs.getInt("readerId"));
                    record.setBookId(rs.getInt("bookId"));
                    
                    record.setBorrowDate(rs.getDate("borrowDate").toLocalDate());
                    record.setDueDate(rs.getDate("dueDate").toLocalDate());
                    if (rs.getDate("returnDate") != null) {
                        record.setReturnDate(rs.getDate("returnDate").toLocalDate());
                    }
                    
                    record.setStatus(rs.getString("status"));
                    record.setFineAmount(rs.getDouble("fineAmount"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return record;
    }
    
    // Thêm một lượt mượn mới
    public void addBorrowRecord(BorrowRecord record) {
        String sql = "INSERT INTO BorrowRecords (readerId, bookId, borrowDate, dueDate, status, fineAmount) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, record.getReaderId());
            ps.setInt(2, record.getBookId());
            ps.setDate(3, java.sql.Date.valueOf(record.getBorrowDate()));
            ps.setDate(4, java.sql.Date.valueOf(record.getDueDate()));
            ps.setString(5, record.getStatus());
            ps.setDouble(6, record.getFineAmount());
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Cập nhật khi trả sách
    public void updateBorrowRecord(BorrowRecord record) {
        String sql = "UPDATE BorrowRecords SET returnDate = ?, status = ?, fineAmount = ? WHERE borrowId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (record.getReturnDate() != null) {
                ps.setDate(1, java.sql.Date.valueOf(record.getReturnDate()));
            } else {
                ps.setNull(1, java.sql.Types.DATE);
            }
            
            ps.setString(2, record.getStatus());
            ps.setDouble(3, record.getFineAmount());
            ps.setInt(4, record.getBorrowId());
            
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}