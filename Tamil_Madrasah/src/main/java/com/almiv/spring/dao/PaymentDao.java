package com.almiv.spring.dao;

import com.almiv.spring.model.Payment;

public interface PaymentDao {
	void processNewPayment(Payment payment);
	int getReceiptIndex();
}
