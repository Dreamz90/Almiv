package com.almiv.spring.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name="Payment_Details")
public class Payment {
	@Id
	String nric;
    double amount_paid;
    String year_paid_for;
    String recieved_by;
    @OneToOne(cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
    private Student student;
    
	public String getNric() {
		return nric;
	}
	public void setNric(String nric) {
		this.nric = nric;
	}
	public double getAmount_paid() {
		return amount_paid;
	}
	public void setAmount_paid(double amount_paid) {
		this.amount_paid = amount_paid;
	}
	public String getYear_paid() {
		return year_paid_for;
	}
	public void setYear_paid(String year_paid) {
		this.year_paid_for = year_paid;
	}
	public String getRecieved_by() {
		return recieved_by;
	}
	public void setRecieved_by(String recieved_by) {
		this.recieved_by = recieved_by;
	}
    
    
}
