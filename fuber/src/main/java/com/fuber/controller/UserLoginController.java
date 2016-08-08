package com.fuber.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fuber.Service.CabService;
import com.fuber.dao.UserDao;
import com.fuber.model.Customer;
import com.fuber.model.Driver;

@Controller
public class UserLoginController {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CabService cabService;
	
    @RequestMapping(value = "/" ,method=RequestMethod.GET)
    public String login(Model model) {
        return "login";
    }
    
    @RequestMapping(value="/login",method={RequestMethod.POST,RequestMethod.GET})
    public String welcome(Model model,HttpServletRequest request ,HttpServletResponse response) {
    	String userName = request.getParameter("username");
    	String password = request.getParameter("password");
    	Customer customer = userDao.getCustomer(userName, password);
    	if (customer == null) {
    		model.addAttribute("message","UserName or Password is invalid");
    		return "login";
    	}
    	List<Driver> cabList = userDao.getAllCabs();
    	List<Driver> pinkCabList = userDao.getAllPinkCabs();
    	
    	Map<Double,Driver> CabDistMap = new HashMap<Double,Driver>();
    	for(Driver cab : cabList) {
    		double distance = 0.0;
    		if(!cab.getIsOccupied()) {
    			distance = cabService.distFrom(Float.parseFloat(customer.getLatitude()), Float.parseFloat(customer.getLongitude()),
    					Float.parseFloat(cab.getLatitude()), Float.parseFloat(cab.getLongitude()));
    			CabDistMap.put(distance,cab);
    		}
    	}
    	Driver nearestCab = null;
    	if(CabDistMap.size() > 0) {
    		nearestCab = CabDistMap.get(Collections.min(CabDistMap.keySet()));
    	}
    	model.addAttribute("userName", userName);
    	model.addAttribute("cabList", cabList);
    	model.addAttribute("nearestCab", nearestCab);
    	model.addAttribute("pinkCabList", pinkCabList);
    	return "welcome";
    }

	@RequestMapping(method=RequestMethod.GET , value="/registration")
	public String registration(Model model) {
		model.addAttribute("customerForm", new Customer());
		model.addAttribute("driverForm", new Driver());
		return "registration";
	}
	
	@RequestMapping(method=RequestMethod.POST , value="/custRegistration")
	public String registerCustomer(@ModelAttribute("customerForm") Customer custForm, BindingResult bindingResult, Model model, @RequestParam("latitude") String latitude, @RequestParam("longitude") String longitude  , RedirectAttributes redirectAttributes) {
		custForm.setLatitude(latitude);
		custForm.setLongitude(longitude);
		userDao.saveCustomer(custForm);
		redirectAttributes.addAttribute("userName",custForm.getUserName());
		redirectAttributes.addAttribute("login","Login");
		return "redirect:/notify";
	}
	
	@RequestMapping(method=RequestMethod.POST , value="/driverRegistration")
	public String registerDriver(@ModelAttribute("driverForm") Driver driverForm, BindingResult bindingResult, Model model, @RequestParam("latitude") String latitude, @RequestParam("longitude") String longitude , RedirectAttributes redirectAttributes) {
		driverForm.setLatitude(latitude);
		driverForm.setLongitude(longitude);
		driverForm.setIsOccupied(Boolean.FALSE);
		userDao.saveDriver(driverForm);
		redirectAttributes.addAttribute("userName",driverForm.getUserName());
		redirectAttributes.addAttribute("login","");
		return "redirect:/notify";
	}
	
	@RequestMapping(value="/notify")
	public String notify(@RequestParam("userName") String userName,@RequestParam("login") String login,Model model) {
		model.addAttribute("login", login);
		model.addAttribute("userName", userName);
		return "notification";
	}

}
