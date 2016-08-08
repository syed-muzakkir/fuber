<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cab Started</title>
    <link href="/fuber/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/fuber/resources/css/common.css" rel="stylesheet">
</head>
<body onload="return getLatLong();">
	<div class="container">
		<h2 class="form-signin-heading">Welcome ${userName}</h2>
		<br>
		<c:if test="${cabDetails ne '' }">
			 <div class="col-md-2 ">Driver Name : ${cabDetails.userName} </div> 
			 <div class="col-md-2 ">Vehicle No : ${cabDetails.vehicleNumber} </div>
			 <div class="col-md-2 ">Taxi Color : ${cabDetails.color} </div>
			 <br/>
		</c:if>
		<form:form action="/fuber/stopRide?userName=${userName}" method="POST">
			<input type="hidden" id="latitude" name="latitude" value=""/>
 			<input type="hidden" id="longitude" name="longitude" value=""/>
 			<input type="hidden" id="driverName" name="driverName" value="${driverName}"/>
			<button class="btn btn-sm btn-primary " type="submit" >End Ride</button>
		</form:form>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="/fuber/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function getLatLong() {
		    if (navigator.geolocation) {
		        navigator.geolocation.getCurrentPosition(setPosition);
		    } else { 
		        alert("Geolocation is not supported by this browser.");
		    }
		}

		function setPosition(position) {
		    $("#latitude").val(position.coords.latitude);
		    $("#longitude").val(position.coords.longitude);
		}
	</script>
</body>
</html>