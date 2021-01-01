package com.almiv.spring.model;

import java.text.NumberFormat;
import java.util.Locale;

public class StudentJson {
	private String name;
	private char gender;
	private String nric;
	private String hpNo;
	private String studentClass;
	private String email;
	private String address;
	private String isNew="N";
	private String registered_year;
	private String hasPaidFees="N";
	private String payment;
	
	public String getPayment() {
		return payment;
	}
	public void setPayment(double p) {
		NumberFormat currencyformatter=NumberFormat.getCurrencyInstance(new Locale("en","SG"));
		payment=currencyformatter.format(p);
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public String getNric() {
		return nric;
	}
	public void setNric(String nric) {
		this.nric = nric;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getStudentClass() {
		return studentClass;
	}
	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIsNew() {
		return isNew;
	}
	public void setIsNew(String isNew) {
		if(isNew.equalsIgnoreCase("Y")) {
			this.isNew="New";
		}else {
			this.isNew = "Existing";	
		}
		
	}
	public String getRegistered_year() {
		return registered_year;
	}
	public void setRegistered_year(String registered_year) {
		this.registered_year = registered_year;
	}
	public String getHasPaidFees() {
		return hasPaidFees;
	}
	public void setHasPaidFees(String hasPaidFees) {
		this.hasPaidFees = hasPaidFees;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}	
}
