package com.almiv.spring.controller;

import java.util.Locale;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.almiv.spring.model.Student;
import com.almiv.spring.service.StudentService;
import com.almiv.spring.util.StudentUtil;

@Controller
@SessionAttributes("student")
public class RegistrationController {
	private static final Log  logger = LogFactory.getLog(RegistrationController.class);

	@Autowired
	StudentService studentService;

	@Autowired
	MessageSource messageSource;

	private static String current_year="";

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {
		System.out.println("Home Page Requested, locale = " + locale);
		current_year=StudentUtil.getCurrentYear();
		model.addAttribute("year",current_year);

		return new ModelAndView("home_reg", "student", new Student());
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView home2(Locale locale, Model model) {
		System.out.println("Home Page2 Requested, locale = " + locale);
		current_year=StudentUtil.getCurrentYear();
		model.addAttribute("year",current_year);

		return new ModelAndView("home_reg", "student", new Student());
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView register( @Validated @ModelAttribute Student student, BindingResult result, ModelMap model, @RequestParam String action) {
		System.out.println("Register Page Requested");
		if(student==null) {
			return new ModelAndView("home_reg", "student", new Student());
		}
		model.addAttribute("classList", StudentUtil.getClassList());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("register");

		if(action.equalsIgnoreCase("edit") && student.getIsNew().equalsIgnoreCase("Y")) {
			return modelAndView;
		}else if(action.equalsIgnoreCase("edit") && student.getIsNew().equalsIgnoreCase("N")) {
			modelAndView.setViewName("reregister");
			return modelAndView;
		}


		if(student.getIsNew().equalsIgnoreCase("Y")) {
			Student stud=new Student();
			stud.setIsNew("Y");
			modelAndView.addObject("student", stud);
		}else {
			Student stud=studentService.findByNric(student.getNric());
			if (stud==null) {
				model.addAttribute("year",current_year);
				model.addAttribute("error","NRIC/FIN does not exist");
				return new ModelAndView("home_reg", "student", new Student());
			}else if(stud.getRegistered_year().equalsIgnoreCase(current_year)) {
				model.addAttribute("year",current_year);
				model.addAttribute("error","Student has already been registered");
				return new ModelAndView("home_reg", "student", new Student());
			}
			stud.setIsNew("N");
			modelAndView.addObject("student", stud);
			modelAndView.setViewName("reregister");
		}
		return modelAndView;

	}

	@RequestMapping(value = "/verify", method = RequestMethod.POST)
	public ModelAndView verify(@Validated @ModelAttribute Student student, BindingResult result, ModelMap model) {
		System.out.println("Verify Page Requested");
		Student stud=studentService.findByNric(student.getNric());
		model.addAttribute("classList", StudentUtil.getClassList());
		if (stud==null&& student.getIsNew().equalsIgnoreCase("Y")) {
			logger.info("New student registration");
			return new ModelAndView("verify_details");

		}else if(stud!=null&& student.getIsNew().equalsIgnoreCase("Y")){
			logger.info("existing student registration");
			stud.setIsNew("N");
			student=stud;
			model.addAttribute("error","Existing NRIC/FIN record found!, kindly verify the details below");
			return new ModelAndView("reregister","student",stud);
		}else {
			return new ModelAndView("verify_details");
		}


	}

	@RequestMapping(value = "/registered", method = RequestMethod.POST)
	public ModelAndView registered(@Validated @ModelAttribute Student student, BindingResult result, ModelMap model) {
		System.out.println("Registered Page Requested");
		ModelAndView modelAndView = new ModelAndView();
		if (result.hasErrors()) {
			modelAndView.setViewName("regFailure");
		}

		if(!studentService.isStudentNricUnique(student.getNric())){
			FieldError nricError =new FieldError("student","nric",messageSource.getMessage("non.unique.nric", new String[]{student.getNric()}, Locale.getDefault()));
			result.addError(nricError);
			modelAndView.setViewName("regFailure");
		}
		try {
			if(student.getIsNew().equalsIgnoreCase("Y")) {
				logger.info("Registering new student for the current year... ");
				logger.info("nric for new student:"+student.getNric());
				studentService.registerNewStudent(student);
			}else {
				logger.info("Registering existing student for the current year... ");
				studentService.registerExistingStudent(student);

			}
			model.addAttribute("sMsg", student.getName()+" has been registered successfully.");
		}catch (Exception e) {
			logger.error(e.getStackTrace());
			model.addAttribute("eMsg", "Error is registering student. Please contact the administrator.");
			}
			modelAndView.setViewName("regSuccess");
			return modelAndView;
		}

	}
