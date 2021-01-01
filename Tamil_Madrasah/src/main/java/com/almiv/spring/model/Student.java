package com.almiv.spring.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;

import com.almiv.spring.util.StudentUtil;

@Entity
@Table(name="student")
public class Student {
	
	private String name;
	private char gender;
	@Id
	private String nric;
	private String hpNo;
	private String studentClass;
	private String email;
	private String address;
	private String isNew="N";
	private String registered_year;
	private String hasPaidFees="N";
	
	@OneToOne(mappedBy="student", cascade=CascadeType.ALL)
	private Payment payment;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name.toUpperCase();
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
		this.nric = nric.toUpperCase();
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
		this.email = email.toLowerCase();
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getIsNew() {
		return isNew;
	}
	public void setIsNew(String isNew) {
		this.isNew = isNew;
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
	
	@PrePersist
    public void prePersist() {
		registered_year = StudentUtil.getCurrentYear();
    }
 
    @PreUpdate
    public void preUpdate() {
    	registered_year = StudentUtil.getCurrentYear();
    }
    
	public Payment getPayment() {
		return payment;
	}
	public void setPayment(Payment payment) {
		this.payment = payment;
	}
	@Override
	public String toString() {
		return "Student [name=" + name + ", gender=" + gender + ", nric=" + nric + ", hpNo=" + hpNo + ", studentClass="
				+ studentClass + ", email=" + email + ", address=" + address + ", isNew=" + isNew + ", registered_year="
				+ registered_year + ", hasPaidFees=" + hasPaidFees + ", payment=" + payment + "]";
	}

	
	
}
