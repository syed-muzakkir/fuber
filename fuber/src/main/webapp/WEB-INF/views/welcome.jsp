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
<title>Welcome to Fuber</title>
    <link href="/fuber/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/fuber/resources/css/common.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h2 class="form-signin-heading">Welcome ${userName}</h2>
		<br>
		<h4 class="form-signin-heading text-muted">Cab near to you</h4>
		<div id="driverNearYou" class="text-center">
			 <div class="col-md-2 ">Driver Name : ${nearestCab.userName} </div> 
			 <div class="col-md-2 ">Vehicle No : ${nearestCab.vehicleNumber} </div>
			 <div class="col-md-2 ">Taxi Color : ${nearestCab.color} </div>
			 <br>
			 <div>
			 	<form method="POST">
			 			<a href="/fuber/assignCab?userName=${userName}&vehicleNum=${nearestCab.vehicleNumber}"> Book Cab </a>
			 			<c:if test="${nearestCab.color ne 'pink'}">
			 				| <a href="/fuber/getPinkCab?userName=${userName}">Give Me A Pink Ride</a>
			 			</c:if>
			 	</form>
			 </div>
		</div>
		<br>
		<h4 class="text-muted">List of Cabs</h4>
		<table class="table table-striped table-bordered table-condensed">
		<tr class="danger">
		<td>User Name</td>
		<td>Vehicle Number</td>
		<td>Avaliable</td>
		</tr>
		<c:forEach items="${cabList}" var="allCabs">
			<tr>
    			<td>${allCabs.userName}</td>
    			<td>${allCabs.vehicleNumber}</td>
    			<td>
    				<c:choose>
  						<c:when test="${allCabs.isOccupied == true}">
  							<c:out value="NO"></c:out>
  						</c:when>
						 <c:otherwise>
						 	<c:out value="YES"></c:out>
  						</c:otherwise>
					</c:choose>
    			</td>
  			</tr>
		</c:forEach>
		</table>
		<h4 class="text-muted">List of Pink Cabs</h4>
		<table class="table table-striped table-bordered table-condensed">
		<tr class="danger">
		<td>User Name</td>
		<td>Vehicle Number</td>
		<td>Avaliable</td>
		</tr>
		<c:forEach items="${pinkCabList}" var="pinkCabs">
			<tr>
    			<td>${pinkCabs.userName}</td>
    			<td>${pinkCabs.vehicleNumber}</td>
    			<td>
    				<c:choose>
  						<c:when test="${pinkCabs.isOccupied == true}">
  							<c:out value="NO"></c:out>
  						</c:when>
						 <c:otherwise>
						 	<c:out value="YES"></c:out>
  						</c:otherwise>
					</c:choose>
    			</td>
  			</tr>
		</c:forEach>
		</table>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="/fuber/resources/js/bootstrap.min.js"></script>
</body>
</html>