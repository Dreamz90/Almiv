package com.almiv.spring.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.almiv.spring.model.Payment;
@Repository("paymentDao")
public class PaymentDaoImpl  extends AbstractDao<String, Payment> implements PaymentDao{
	
	JdbcTemplate jdbcTemplate;
	final private String receipt_index_query="Select serial_no from receipt_index";

	@Autowired
	public PaymentDaoImpl(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public void processNewPayment(Payment payment) {
		persist(payment);

	}
	
	public int getReceiptIndex() {
		int counter=0;
		counter= jdbcTemplate.queryForObject(receipt_index_query, Integer.class);
		return counter;
	}
	
}
