package com.almiv.spring.dao;

import java.util.List;

import com.almiv.spring.model.Student;

public interface StudentDao {
	Student findByNric(String nric);
	 
    void registerNewStudent(Student student);
     
    List<Student> findUnPaidStudents();
    
    List<Student> listAllStudents();
 
	void processNewPayment(Student student);

}
