package com.almiv.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.almiv.spring.dao.AdminDao;
import com.almiv.spring.model.Adminstrator;

@Service("adminService")
@Transactional
public class AdminServiceImpl  implements AdminService {
	@Autowired
	private AdminDao adminDao;
	
	@Override
	public Adminstrator findByAdminID(String adminID) {
		return adminDao.findByAdminID(adminID);
	}

}
