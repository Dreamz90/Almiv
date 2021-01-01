package com.almiv.spring.service;


import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.almiv.spring.dao.PaymentDao;
import com.almiv.spring.dao.StudentDao;
import com.almiv.spring.model.Payment;
import com.almiv.spring.model.Receipt;
import com.almiv.spring.model.Student;
import com.almiv.spring.util.EMailUtil;
import com.almiv.spring.util.GenerateReceipt;
import com.almiv.spring.util.StudentUtil;

@Service("studentService")
@Transactional
public class StudentServiceImpl implements StudentService {
	private static final Log  logger = LogFactory.getLog(StudentServiceImpl.class);

	@Autowired
	private StudentDao dao;

	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
    JavaMailSender mailSender;

	@Override
	public Student findByNric(String nric) {
		return dao.findByNric(nric);
	}

	@Override
	public boolean registerNewStudent(Student student) {
		if(student.getRegistered_year()==null){
			student.setRegistered_year(StudentUtil.getCurrentYear());
		}
		//check if student exist
		Student existStudent=dao.findByNric(student.getNric());
		if(existStudent==null) {
			dao.registerNewStudent(student);
			logger.info("New Registration success!");
			return true;
		}
		logger.info("New Registration failed! Student is a existing student");
		return false;


	}

	@Override
	public void registerExistingStudent(Student student) {
		Student entity = dao.findByNric(student.getNric());
		entity.setRegistered_year(StudentUtil.getCurrentYear());
		entity.setStudentClass(student.getStudentClass());
		entity.setEmail(student.getEmail());
		entity.setHpNo(student.getHpNo());
		entity.setAddress(student.getAddress());
	}

	@Override
	public List<Student> findUnPaidStudents() {
		List<Student> studentList=dao.findUnPaidStudents();
		return studentList;
	}

	@Override
	public boolean isStudentNricUnique(String nric) {
		Student student = findByNric(nric);
		return ( student == null || ((nric != null) && (student.getNric() == nric)));
	}

	@Override
	public void updateStudent(Student student) {
		Student entity = dao.findByNric(student.getNric());
		entity.setName(student.getName());
		entity.setGender(student.getGender());
		entity.setAddress(student.getAddress());
		entity.setHpNo(student.getHpNo());
		entity.setEmail(student.getEmail());
		entity.setStudentClass(student.getStudentClass());
		entity.setIsNew(student.getIsNew());
		entity.setRegistered_year(student.getRegistered_year());
		entity.setHasPaidFees(student.getHasPaidFees());
	}

	@Override
	public void processPayment(Student student) {
		try {
			Student entity = dao.findByNric(student.getNric());

			Payment paymentEntity=entity.getPayment();
			if(paymentEntity==null) {
				paymentEntity=student.getPayment();
				paymentEntity.setYear_paid(StudentUtil.getCurrentYear());
				paymentDao.processNewPayment(paymentEntity);
				
				int counter=paymentDao.getReceiptIndex();
				Receipt receiptObj= new Receipt(entity.getName(),entity.getStudentClass(),paymentEntity.getAmount_paid(),counter);
				
				if(!student.getEmail().equalsIgnoreCase("")) {
					new EMailUtil().sendEmail(mailSender,receiptObj,student.getEmail());
				}else {
					new GenerateReceipt().GenerateReceipt_PDFv2(receiptObj);
				}
					

			}else {
				//record exist, so add current payment with existing payment record
				double amt=paymentEntity.getAmount_paid()+student.getPayment().getAmount_paid();
				paymentEntity.setYear_paid(StudentUtil.getCurrentYear());
				paymentEntity.setAmount_paid(amt);
				paymentEntity.setRecieved_by(student.getPayment().getRecieved_by());
				
				int counter=paymentDao.getReceiptIndex();
				Receipt receiptObj= new Receipt(entity.getName(),entity.getStudentClass(),student.getPayment().getAmount_paid(),counter);
				
				if(!student.getEmail().equalsIgnoreCase("")) {
					new EMailUtil().sendEmail(mailSender,receiptObj,student.getEmail());
				}else {
					new GenerateReceipt().GenerateReceipt_PDFv2(receiptObj);
				}
					
			}

			String hasPaidFullFees=StudentUtil.verifyFullPayment(entity, entity.getStudentClass(), entity.getIsNew(),paymentEntity);
			entity.setHasPaidFees(hasPaidFullFees);	
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}

	@Override
	public List<Student> listAllStudents() {
		List<Student> studentList=dao.listAllStudents();
		return studentList;
	}
	
	@Override
	public int getReceiptIndex() {
		int counter=paymentDao.getReceiptIndex();
		return counter;
	}

}
