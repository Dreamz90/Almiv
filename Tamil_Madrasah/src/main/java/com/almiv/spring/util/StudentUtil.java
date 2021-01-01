package com.almiv.spring.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import com.almiv.spring.model.Payment;
import com.almiv.spring.model.Student;

public class StudentUtil {
	public static Map<String, String> getClassList()
	{
		Map<String,String> classList = new LinkedHashMap<String,String>();
		classList.put("K2", "K2");
		classList.put("Primary 1", "Primary 1");
		classList.put("Primary 2", "Primary 2");
		classList.put("Primary 3", "Primary 3");
		classList.put("Primary 4", "Primary 4");
		classList.put("Primary 5", "Primary 5");
		classList.put("Primary 6", "Primary 6");
		classList.put("Secondary 1", "Secondary 1");
		classList.put("Secondary 2", "Secondary 2");
		classList.put("Secondary 3", "Secondary 3");
		classList.put("Secondary 4", "Secondary 4");
		classList.put("Secondary 5", "Secondary 5");
		classList.put("ITE/Poly/JC", "ITE/Poly/JC");
		classList.put("Adult", "Adult");

		return classList;
	}

	public static String convertdate_date(Date date) {
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		System.out.println(dateFormat.format(date)); //20/12/1990
		return dateFormat.format(date);
	}
	
	public static String convertdate_datetime(Date date) {
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		System.out.println(dateFormat.format(date)); //20/12/1990 12:08:43
		return dateFormat.format(date);
	}
	
	public static String getSerialDate() {
		Date date= new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyMMdd");
		return dateFormat.format(date);
	}
	
	public static String getCurrentYear() {
		Calendar now = Calendar.getInstance();
		return String.valueOf(now.get(Calendar.YEAR));
	}
	
	public static String verifyFullPayment(Student student,String studentClass, String isNewStudent,Payment payment) {
		System.out.println("studentClass:"+studentClass+" isNewStudent:"+isNewStudent);
		if(studentClass.equalsIgnoreCase("Adult")) {
			if(payment.getAmount_paid()>=150) {
				return "Y";
			}
		}else if(isNewStudent.equalsIgnoreCase("Y")) {
			if(payment.getAmount_paid()>=150) {
				return "Y";
			}
		}else if(isNewStudent.equalsIgnoreCase("N")){
			if(payment.getAmount_paid()>=120) {
				return "Y";
			}
		}
		return "N";
	}

}
