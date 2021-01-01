package com.almiv.spring.model;

public class AdminSession {
	private Adminstrator admin;
	private Student student;
	public Adminstrator getAdmin() {
		return admin;
	}
	public void setAdmin(Adminstrator admin) {
		this.admin = admin;
	}
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	

}
