package com.fuber.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.fuber.model.Customer;
import com.fuber.model.Driver;

@Repository
public class UserDao {
	
    @Resource(name="sessionFactory")
    SessionFactory sessionFactory;
    
    public void saveCustomer(Customer customer) {
    	Session session = sessionFactory.openSession();
    	session.beginTransaction();
    	session.saveOrUpdate(customer);
    	session.getTransaction().commit();
    	session.close();
    }
    
    public void saveDriver(Driver driver) {
    	Session session = sessionFactory.openSession();
    	session.beginTransaction();
    	session.saveOrUpdate(driver);
    	session.getTransaction().commit();
    	session.close();
    }
    
    public Customer getCustomer(String userName , String password) {
    	Session session = sessionFactory.openSession();
    	Customer customer = (Customer) session.createQuery(" from Customer where userName= :userName and password = :password")
    							.setParameter("userName", userName)
    								.setParameter("password", password).uniqueResult();
    	session.close();
    	return customer;
    }
    
    public List<Driver> getAllCabs() {
    	Session session = sessionFactory.openSession();
    	List<Driver> driversList = session.createQuery(" from Driver ").list();
    	session.close();
    	return driversList;
    }
    
    public List<Driver> getAllPinkCabs() {
    	Session session = sessionFactory.openSession();
    	List<Driver> driversList = session.createQuery(" from Driver where color=:color")
    									.setParameter("color", "pink").list();
    	session.close();
    	return driversList;
    }
    
    public Customer getCustomerByName(String userName) {
    	Session session = sessionFactory.openSession();
    	Customer customer = (Customer) session.createQuery(" from Customer where userName = :userName")
    							.setParameter("userName", userName).uniqueResult();
    	session.close();
    	return customer;
    }
    
    public Driver getDriverByVechicleNum(String vehicleNumber) {
    	Session session = sessionFactory.openSession();
    	Driver driver = (Driver) session.createQuery(" from Driver where vehicleNumber=:vehicleNumber")
    									.setParameter("vehicleNumber", vehicleNumber).list().get(0);
    	session.close();
    	return driver;
    }
    
    public Driver getDriverByuserName(String userName) {
    	Session session = sessionFactory.openSession();
    	Driver driver = (Driver) session.createQuery(" from Driver where userName=:userName")
    									.setParameter("userName", userName).list().get(0);
    	session.close();
    	return driver;
    }

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

}
