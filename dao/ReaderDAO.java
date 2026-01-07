package dao;

import model.Reader;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReaderDAO {

	// Lấy tất cả độc giả
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * HÀM MỚI: Lấy thông tin một độc giả theo ID.
	 */
	public Reader getReaderById(int id) {
		String sql = "SELECT * FROM Readers WHERE readerId = ?";
		Reader reader = null;
		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reader;
	}

	/**
	 * HÀM MỚI: Thêm một độc giả mới. Lưu ý: Cần xử lý logic tạo tài khoản (Users)
	 * tương ứng ở Controller.
	 */
	public void addReader(Reader reader) {
		String sql = "INSERT INTO Readers (maDocGia, hoTen, diaChi, soDienThoai, userId) " + "VALUES (?, ?, ?, ?, ?)";
		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, reader.getMaDocGia());
			ps.setString(2, reader.getHoTen());
			ps.setString(3, reader.getDiaChi());
			ps.setString(4, reader.getSoDienThoai());
			ps.setInt(5, reader.getUserId());
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * HÀM MỚI: Cập nhật thông tin độc giả.
	 */
	public void updateReader(Reader reader) {
		String sql = "UPDATE Readers SET maDocGia = ?, hoTen = ?, diaChi = ?, soDienThoai = ? " + "WHERE readerId = ?";
		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, reader.getMaDocGia());
			ps.setString(2, reader.getHoTen());
			ps.setString(3, reader.getDiaChi());
			ps.setString(4, reader.getSoDienThoai());
			ps.setInt(5, reader.getReaderId());
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * HÀM MỚI: Xóa một độc giả. Lưu ý: Cần xử lý xóa (hoặc vô hiệu hóa) tài khoản
	 * Users tương ứng. Và kiểm tra xem độc giả có đang mượn sách không trước khi
	 * xóa.
	 */
	public void deleteReader(int id) {
		String sql = "DELETE FROM Readers WHERE readerId = ?";
		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// HÀM MỚI: Tìm thông tin Độc giả dựa trên User ID (Tài khoản đăng nhập)
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
					r.setUserId(rs.getInt("userId"));
					// Các trường khác nếu cần...
					return r;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}