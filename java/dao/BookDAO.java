package dao;

import model.Book;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    // Lấy tất cả sách
    public List<Book> getAllBooks() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM Books";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("bookId"));
                book.setMaSach(rs.getString("maSach"));
                book.setTenSach(rs.getString("tenSach"));
                book.setTacGia(rs.getString("tacGia"));
                book.setTheLoai(rs.getString("theLoai"));
                book.setNamXB(rs.getInt("namXB"));
                book.setSoLuong(rs.getInt("soLuong"));
                book.setSoLuongConLai(rs.getInt("soLuongConLai"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy sách theo ID
    public Book getBookById(int id) {
        String sql = "SELECT * FROM Books WHERE bookId = ?";
        Book book = null;
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    book = new Book();
                    book.setBookId(rs.getInt("bookId"));
                    book.setMaSach(rs.getString("maSach"));
                    book.setTenSach(rs.getString("tenSach"));
                    book.setTacGia(rs.getString("tacGia"));
                    book.setTheLoai(rs.getString("theLoai"));
                    book.setNamXB(rs.getInt("namXB"));
                    book.setSoLuong(rs.getInt("soLuong"));
                    book.setSoLuongConLai(rs.getInt("soLuongConLai"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return book;
    }

    // Thêm sách mới
    public void addBook(Book book) {
        String sql = "INSERT INTO Books (maSach, tenSach, tacGia, theLoai, namXB, soLuong, soLuongConLai) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, book.getMaSach());
            ps.setString(2, book.getTenSach());
            ps.setString(3, book.getTacGia());
            ps.setString(4, book.getTheLoai());
            ps.setInt(5, book.getNamXB());
            ps.setInt(6, book.getSoLuong());
            ps.setInt(7, book.getSoLuongConLai());
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật sách
    public void updateBook(Book book) {
        String sql = "UPDATE Books SET maSach = ?, tenSach = ?, tacGia = ?, theLoai = ?, " +
                     "namXB = ?, soLuong = ?, soLuongConLai = ? WHERE bookId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, book.getMaSach());
            ps.setString(2, book.getTenSach());
            ps.setString(3, book.getTacGia());
            ps.setString(4, book.getTheLoai());
            ps.setInt(5, book.getNamXB());
            ps.setInt(6, book.getSoLuong());
            ps.setInt(7, book.getSoLuongConLai());
            ps.setInt(8, book.getBookId());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa sách
    public void deleteBook(int id) {
        String sql = "DELETE FROM Books WHERE bookId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //Cập nhật sách
    /**
     * HÀM MỚI: Cập nhật chỉ số lượng sách còn lại (dùng khi mượn/trả sách).
     * @param bookId ID của sách cần cập nhật
     * @param soLuongConLai Số lượng mới
     */
    public void updateBookQuantity(int bookId, int soLuongConLai) {
        String sql = "UPDATE Books SET soLuongConLai = ? WHERE bookId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, soLuongConLai);
            ps.setInt(2, bookId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}