package com.almiv.spring.dao;

import com.almiv.spring.model.Adminstrator;

public interface AdminDao {
	Adminstrator findByAdminID(String adminID);
}
