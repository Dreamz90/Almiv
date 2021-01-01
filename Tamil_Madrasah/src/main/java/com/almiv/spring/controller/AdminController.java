package com.almiv.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.almiv.spring.model.AdminSession;
import com.almiv.spring.model.Adminstrator;
import com.almiv.spring.model.Student;
import com.almiv.spring.model.StudentJson;
import com.almiv.spring.service.AdminService;
import com.almiv.spring.service.StudentService;
import com.almiv.spring.util.StudentUtil;

@Controller
@SessionAttributes("session")
public class AdminController {
	private static final Log  logger = LogFactory.getLog(AdminController.class);

	@Autowired
	StudentService studentService;

	@Autowired
	AdminService adminService;

	//	@Autowired
	//	MailService mailService;

	@Autowired
	MessageSource messageSource;


	@ModelAttribute("session")
	public AdminSession setUpUserForm() {
		return new AdminSession();
	}
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public ModelAndView login(Model model) {
		System.out.println("Login Page Requested");
		return new ModelAndView("login", "session", new AdminSession());
	}

	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public ModelAndView menu(@Validated @ModelAttribute("session") AdminSession session, ModelMap model) {
		System.out.println("Menu Page Requested");
		model.addAttribute("ID",session.getAdmin().getAdminID());
		ModelAndView modelAndView = new ModelAndView();
		//check login
		Adminstrator adminEntity=adminService.findByAdminID(session.getAdmin().getAdminID().toLowerCase());
		if (adminEntity==null) {
			//return error
			model.addAttribute("error","Administrator ID does not exist.");
			modelAndView.setViewName("login");
		}else {
			session.getAdmin().setAdminName(adminEntity.getAdminName());
			model.addAttribute("name", session.getAdmin().getAdminName());
			modelAndView.setViewName("admin/menu");
		}		
		return modelAndView;
	}

	@RequestMapping(value = "/options", method = RequestMethod.POST)
	public ModelAndView options(@Validated @ModelAttribute("session") AdminSession session, BindingResult result, ModelMap model, @RequestParam String action) {
		System.out.println("Options Page Requested "+session.getAdmin().getAdminID()+" "+session.getAdmin().getAdminName());
		ModelAndView modelAndView = new ModelAndView();
		
		model.addAttribute("ID",session.getAdmin().getAdminID());
		model.addAttribute("name", session.getAdmin().getAdminName());

		switch(action){
		case "pendingPayment":{
			String json=getPendingPaymentJson();
			if(json.equalsIgnoreCase("")) {
				model.addAttribute("error","No data to display");
			}else {
				model.addAttribute("json", json);
				modelAndView.setViewName("admin/pending_payment");
			}
			 break;
		}
		case "allStudentList":{
			String json=getAllStudentJson();
			if(json.equalsIgnoreCase("")) {
				model.addAttribute("error","No data to display");
			}else {
				model.addAttribute("json", json);
				modelAndView.setViewName("admin/all_students");
			}
			 break;
		}
		case "editStudent":{
			model.addAttribute("Display","true");
			modelAndView.setViewName("admin/editStudent");
			session.setStudent(new Student());
			break;
		}
		default:
			modelAndView.setViewName("admin/menu");
		}

//		if(action.equalsIgnoreCase("pendingPayment")) {
//			String json=getPendingPaymentJson();
//			if(json.equalsIgnoreCase("")) {
//				model.addAttribute("error","No data to display");
//			}else {
//				model.addAttribute("json", json);
//				modelAndView.setViewName("admin/pending_payment");
//			}
//
//		}else if(action.equalsIgnoreCase("allStudentList")) {
//			String json=getAllStudentJson();
//			if(json.equalsIgnoreCase("")) {
//				model.addAttribute("error","No data to display");
//			}else {
//				model.addAttribute("json", json);
//				modelAndView.setViewName("admin/all_students");
//			}
//
//		}else if(action.equalsIgnoreCase("editStudent")) {
//			modelAndView.setViewName("admin/editStudent");
//		}
//		else if(action.equalsIgnoreCase("editInnerClass")) {
//
//		}else if(action.equalsIgnoreCase("resendReceipt")) {
//			modelAndView.setViewName("admin/resendReceipt");
//		}
		return modelAndView;
	}
	@RequestMapping(value = "/processPayment", method = RequestMethod.POST)
	public ModelAndView processPayment(@Validated @ModelAttribute("session") AdminSession session, BindingResult result, ModelMap model) {
		System.out.println("Process Payment request Requested");

		session.getStudent().getPayment().setRecieved_by(session.getAdmin().getAdminID());
		session.getStudent().getPayment().setNric(session.getStudent().getNric());
		try {
			studentService.processPayment(session.getStudent());
			model.addAttribute("sMsg", "Payment processed sucessfully!");
		}catch (Exception e) {
			logger.error(e.getStackTrace());
			model.addAttribute("eMsg","Error in processing payment.Please contact the adminstrator");
		}
		

		ModelAndView modelAndView = new ModelAndView();
		model.addAttribute("ID",session.getAdmin().getAdminID());
		model.addAttribute("name", session.getAdmin().getAdminName());

		String json=getPendingPaymentJson();
		if(json.equalsIgnoreCase("")) {
			model.addAttribute("error","No data to display");
		}else {
			model.addAttribute("json", json);
			modelAndView.setViewName("admin/pending_payment");
		}
		session.setStudent(new Student());
		return modelAndView;
	}

	@RequestMapping(value = "/retireveStudent", method = RequestMethod.POST)
	public ModelAndView retireveStudent(@Validated @ModelAttribute("session") AdminSession session, BindingResult result, ModelMap model) {
		System.out.println("Retrieve Student request Requested");
		session.setStudent(studentService.findByNric(session.getStudent().getNric()));

		ModelAndView modelAndView = new ModelAndView();
		model.addAttribute("ID",session.getAdmin().getAdminID());
		model.addAttribute("name", session.getAdmin().getAdminName());
		model.addAttribute("Display","false");
		model.addAttribute("classList", StudentUtil.getClassList());
		modelAndView.setViewName("admin/editStudent");

		return modelAndView;
	}
	@RequestMapping(value = "/editStudent", method = RequestMethod.POST)
	public ModelAndView editStudent(@Validated @ModelAttribute("session") AdminSession session, BindingResult result, ModelMap model) {
		System.out.println("Edit Student request Requested");
		ModelAndView modelAndView = new ModelAndView();
		model.addAttribute("ID",session.getAdmin().getAdminID());
		model.addAttribute("name", session.getAdmin().getAdminName());
		model.addAttribute("Display","true");
		model.addAttribute("classList", StudentUtil.getClassList());
		try {
			studentService.updateStudent(session.getStudent());
			model.addAttribute("sMsg","Edited the student's details successfully");
		}catch(Exception e) {
			logger.error(e.getStackTrace());
			model.addAttribute("eMsg","Error in editing student details! Please contact administrator");
		}
		session.setStudent(new Student());
		modelAndView.setViewName("admin/editStudent");

		return modelAndView;
	}

	@RequestMapping(value="/logout",method = RequestMethod.GET)
	public String logout(HttpServletRequest request){
		HttpSession httpSession = request.getSession();
		httpSession.invalidate();
		return "redirect:/";
	}

	public String getPendingPaymentJson() {
		List <Student>studentList=studentService.findUnPaidStudents();
		List <StudentJson>jsonList = new ArrayList<StudentJson>();
		for(Student s:studentList) {
			StudentJson jsonObj= new StudentJson();
			jsonObj.setName(s.getName());
			jsonObj.setGender(s.getGender());
			jsonObj.setEmail(s.getEmail());
			jsonObj.setNric(s.getNric());
			jsonObj.setHpNo(s.getHpNo());
			jsonObj.setRegistered_year(s.getRegistered_year());
			jsonObj.setHasPaidFees(s.getHasPaidFees());
			jsonObj.setIsNew(s.getIsNew());
			jsonObj.setStudentClass(s.getStudentClass());
			if(s.getPayment()!=null) {
				jsonObj.setPayment(s.getPayment().getAmount_paid());
			}else {
				jsonObj.setPayment(0);
			}
			jsonList.add(jsonObj);
		}

		String json="";
		try {
			json = new Gson().toJson(jsonList);
		}catch(Exception e) {
			logger.error(e.getStackTrace());
		}
		return json;
	}
	public String getAllStudentJson() {
		List <Student>studentList=studentService.listAllStudents();
		List <StudentJson>jsonList = new ArrayList<StudentJson>();
		for(Student s:studentList) {
			StudentJson jsonObj= new StudentJson();
			jsonObj.setName(s.getName());
			jsonObj.setGender(s.getGender());
			jsonObj.setEmail(s.getEmail());
			jsonObj.setNric(s.getNric());
			jsonObj.setHpNo(s.getHpNo());
			jsonObj.setRegistered_year(s.getRegistered_year());
			jsonObj.setHasPaidFees(s.getHasPaidFees());
			jsonObj.setIsNew(s.getIsNew());
			jsonObj.setStudentClass(s.getStudentClass());
			jsonObj.setAddress(s.getAddress());
			if(s.getPayment()!=null) {
				jsonObj.setPayment(s.getPayment().getAmount_paid());
			}else {
				jsonObj.setPayment(0);
			}
			jsonList.add(jsonObj);
		}

		String json="";
		try {
			json = new Gson().toJson(jsonList);
		}catch(Exception e) {
			logger.error(e.getStackTrace());
		}
		System.out.println("json:"+json);
		return json;
	}
}

