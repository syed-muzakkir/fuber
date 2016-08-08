package com.fuber.Service;

import org.springframework.stereotype.Service;

@Service
public class CabService {
	
	 public double distFrom(float lat1, float lng1, float lat2, float lng2) {
		    final int R = 6371; // Radius of the earth

		    Double latDistance = Math.toRadians(lat1 - lat2);
		    Double lonDistance = Math.toRadians(lng1 - lng2);
		    Double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
		            + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
		            * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
		    Double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		    double distance = R * c * 1000; // convert to meters

		    distance = Math.pow(distance, 2);
		    
		    return Math.sqrt(distance);
	}
	 
}
