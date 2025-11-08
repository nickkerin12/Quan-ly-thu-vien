package dao;

import model.User;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDAO {

    /**
     * Kiểm tra thông tin đăng nhập và trả về đối tượng User nếu hợp lệ.
     */
    public User getUser(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        User user = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password); 

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("userId"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("fullName"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    /**
     * Lấy thông tin User bằng ID
     */
    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE userId = ?";
        User user = null;
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("userId"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("fullName"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    /**
     * Thêm một User mới (dùng cho đăng ký).
     * Trả về ID của User vừa được tạo (quan trọng để liên kết với Reader).
     */
    public int addUser(User user) {
        String sql = "INSERT INTO Users (username, password, fullName, email, role) " +
                     "VALUES (?, ?, ?, ?, ?)";
        int generatedUserId = -1; // -1 nếu thất bại

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getRole());
            
            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedUserId = rs.getInt(1);
                    }
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedUserId; // Trả về ID
    }

    /**
     * Cập nhật thông tin cơ bản của User (không bao gồm mật khẩu).
     * Mật khẩu nên có hàm riêng (changePassword).
     */
    public void updateUser(User user) {
        String sql = "UPDATE Users SET fullName = ?, email = ?, role = ? WHERE userId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRole());
            ps.setInt(4, user.getUserId());
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Xóa một User khỏi CSDL.
     * LƯU Ý QUAN TRỌNG: Hàm này sẽ thất bại nếu userId này đang được liên kết trong bảng Readers (lỗi khóa ngoại).
     * Bạn phải xóa Reader liên kết trước khi xóa User.
     */
    public void deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE userId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi: Không thể xóa User. User này có thể đang được liên kết bởi một Độc giả (Reader).");
        }
    }
}