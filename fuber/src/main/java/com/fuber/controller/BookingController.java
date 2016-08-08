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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fuber.Service.CabService;
import com.fuber.dao.UserDao;
import com.fuber.model.Customer;
import com.fuber.model.Driver;

@Controller
public class BookingController {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CabService cabService;

	@RequestMapping(value="/assignCab")
	public String assignCab (@RequestParam("userName") String userName,@RequestParam("vehicleNum") String vehicleNum,Model model) {
		Driver driver = userDao.getDriverByVechicleNum(vehicleNum);
		driver.setIsOccupied(Boolean.TRUE);
		userDao.saveDriver(driver);
		model.addAttribute("userName", userName);
		model.addAttribute("cabDetails", driver);
		model.addAttribute("driverName", driver.getUserName());
		return "assignCab";
	}
	
	@RequestMapping(value="/getPinkCab")
	public String getPinkCab (@RequestParam("userName") String userName,Model model) {
		List<Driver> pinkCabList = userDao.getAllPinkCabs();
		Customer customer = userDao.getCustomerByName(userName);
    	Map<Double,Driver> CabDistMap = new HashMap<Double,Driver>();
    	for(Driver cab : pinkCabList) {
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
    	model.addAttribute("cabDetails", nearestCab);
    	model.addAttribute("driverName", nearestCab.getUserName());
		return "assignCab";
	}
	
	@RequestMapping(value="/stopRide",method=RequestMethod.POST)
	public String stopRide (@RequestParam("userName") String userName,Model model,HttpServletRequest request,HttpServletResponse response) {
    	String driverName = request.getParameter("driverName");
    	String latitude = request.getParameter("latitude");
    	String longitude = request.getParameter("longitude");
    	Driver driver = userDao.getDriverByuserName(driverName);
    	driver.setIsOccupied(Boolean.FALSE);
    	driver.setLatitude(latitude);
    	driver.setLongitude(longitude);
    	userDao.saveDriver(driver);
    	Customer customer = userDao.getCustomerByName(userName);
    	customer.setLatitude(latitude);
    	customer.setLongitude(longitude);
    	userDao.saveCustomer(customer);
		return "rideEnded";
	}
}
