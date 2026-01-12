package model;

import java.time.LocalDate;

public class BorrowRecord {
    private int borrowId;
    private int readerId; 
    private int bookId; 
    
    private LocalDate borrowDate; // Ngày mượn 
    private LocalDate dueDate; // Ngày hẹn trả
    private LocalDate returnDate; // Ngày trả thực tế (có thể null nếu chưa trả)
    
    private String status; // Trạng thái: "Đang mượn", "Đã trả", "Quá hạn" 
    private double fineAmount; // Tiền phạt 

    // Constructor mặc định
    public BorrowRecord() {
    }

    // Constructor đầy đủ
    public BorrowRecord(int borrowId, int readerId, int bookId, LocalDate borrowDate, LocalDate dueDate, LocalDate returnDate, String status, double fineAmount) {
        this.borrowId = borrowId;
        this.readerId = readerId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.status = status;
        this.fineAmount = fineAmount;
    }

    // Getters and Setters
    public int getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(int borrowId) {
        this.borrowId = borrowId;
    }

    public int getReaderId() {
        return readerId;
    }

    public void setReaderId(int readerId) {
        this.readerId = readerId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getFineAmount() {
        return fineAmount;
    }

    public void setFineAmount(double fineAmount) {
        this.fineAmount = fineAmount;
    }
}