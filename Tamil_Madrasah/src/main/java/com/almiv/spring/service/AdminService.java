package com.almiv.spring.service;

import com.almiv.spring.model.Adminstrator;

public interface AdminService {
	
	Adminstrator findByAdminID(String adminID);
}
