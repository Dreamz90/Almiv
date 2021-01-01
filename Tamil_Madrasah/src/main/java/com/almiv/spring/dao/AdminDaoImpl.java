package com.almiv.spring.dao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import com.almiv.spring.model.Adminstrator;

@Repository("adminDao")
public class AdminDaoImpl  extends AbstractDao<String, Adminstrator> implements AdminDao{
	private static final Log  logger = LogFactory.getLog(AdminDaoImpl.class);

	@Override
	public Adminstrator findByAdminID(String adminID) {
		Adminstrator admin=null;
		try {
			admin =getByKey(adminID);
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return admin;
	}

}
