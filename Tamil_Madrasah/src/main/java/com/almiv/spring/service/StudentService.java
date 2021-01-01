package com.almiv.spring.service;

import java.util.List;

import com.almiv.spring.model.Student;

public interface StudentService {
	
	Student findByNric(String nric);

	boolean registerNewStudent(Student student);

	void registerExistingStudent(Student student);

	List<Student> findUnPaidStudents();
	
	List<Student> listAllStudents();

	boolean isStudentNricUnique(String nric);
	
	void updateStudent(Student student);
	
	void processPayment(Student student);
	
	int getReceiptIndex();

}
