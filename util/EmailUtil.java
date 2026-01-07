package util;

import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    
    // CẤU HÌNH EMAIL GỬI ĐI (Sử dụng Gmail)
    // Bạn cần bật xác thực 2 bước và tạo "Mật khẩu ứng dụng" (App Password) trong cài đặt Google Account
    private static final String HOST_NAME = "smtp.gmail.com";
    private static final int TSL_PORT = 587;
    private static final String APP_EMAIL = "doAnWeb23130235@gmail.com"; 
    private static final String APP_PASSWORD = "wxia ukct ikzy pyrn";

    public static void sendEmail(String toAddress, String subject, String message) throws MessagingException {
        // 1. Cấu hình SMTP Server
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.port", TSL_PORT);

        // 2. Tạo phiên làm việc (Session)
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });

        // 3. Tạo nội dung Email
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(APP_EMAIL));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
        msg.setSubject(subject);
        msg.setText(message);
        msg.setHeader("Content-Type", "text/plain; charset=UTF-8");

        // 4. Gửi email
        Transport.send(msg);
    }
    
    // Hàm tiện ích tạo mật khẩu ngẫu nhiên
    public static String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 8; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
}