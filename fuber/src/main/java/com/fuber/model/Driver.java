package com.fuber.model;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue(value="CAB")
public class Driver extends User {
	
	@Column(name="VEHICLE_NUM")
	private String vehicleNumber;
	
	@Column(name="LOCATION")
	private String location;
	
	@Column(name="COLOR")
	private String color;
	
	@Column(name="IS_OCCUPIED")
	private Boolean isOccupied;
	
	public String getVehicleNumber() {
		return vehicleNumber;
	}
	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public Boolean getIsOccupied() {
		return isOccupied;
	}
	public void setIsOccupied(Boolean isOccupied) {
		this.isOccupied = isOccupied;
	}

}
