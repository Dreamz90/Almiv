package com.almiv.spring.model;

public class Receipt {
	String studentName;
	String studentClass;
	double amount;
	int receiptSerialNo;

	//	public Receipt(String name,double amt) {
	//		this.studentName=name;
	//		this.amount=amt;
	//	}
	public Receipt(String name,String studentClass,double amt) {
		this.studentName=name;
		this.studentClass=studentClass;
		this.amount=amt;
	}

	public Receipt(String studentName, String studentClass, double amount, int receiptSerialNo) {
		super();
		this.studentName = studentName;
		this.studentClass = studentClass;
		this.amount = amount;
		this.receiptSerialNo = receiptSerialNo;
	}


	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getStudentClass() {
		return studentClass;
	}
	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}

	public int getReceiptSerialNo() {
		return receiptSerialNo;
	}

	public void setReceiptSerialNo(int receiptSerialNo) {
		this.receiptSerialNo = receiptSerialNo;
	}
}
