package com.almiv.spring.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.almiv.spring.model.Student;
import com.almiv.spring.util.StudentUtil;

@Repository("studentDao")
public class StudentDaoImpl extends AbstractDao<String, Student> implements StudentDao{
	private static final Log  logger = LogFactory.getLog(StudentDaoImpl.class);
	
	@Override
	public Student findByNric(String nric) {
		Student stud=null;
		try {
			stud =getByKey(nric);
		}catch(Exception e) {
			logger.error(e.getMessage());
			System.out.println(e);
		}
		return stud;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Student> findUnPaidStudents() {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("registered_year", StudentUtil.getCurrentYear())).add(Restrictions.eq("hasPaidFees", "N")).addOrder(Order.asc("studentClass"));
		List<Student> list = (List<Student>) criteria.list();
		return list;
	}

	@Override
	public void registerNewStudent(Student student) {
		persist(student);

	}

	@Override
	public void processNewPayment(Student student) {
		persist(student);

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Student> listAllStudents() {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("registered_year", StudentUtil.getCurrentYear())).addOrder(Order.asc("studentClass")).addOrder(Order.desc("gender"));
		List<Student> list = (List<Student>) criteria.list();
		return list;
	}


}
