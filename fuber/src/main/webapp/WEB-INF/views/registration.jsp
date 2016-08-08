<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create an account</title>

    <link href="/fuber/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/fuber/resources/css/common.css" rel="stylesheet">
    <style type="text/css">
    	.none {
 		   display:none;
		}
    </style>
</head>

<body onload="return getLatLong();">

<div class="container form-signin">

    
        <h2 class="form-signin-heading">Create your account</h2>
        <br/>
        <h4 class="form-signin-heading">Select account type :</h4>
        <div id="userType">
        	&nbsp;&nbsp;<input type="radio" name='user' value='Customer' data-id="custLoginFormHide" /> <span>Customer Account</span>
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name='user' value='Driver' data-id="driverLoginFormHide" /> <span>Driver Account</span>
        </div>
		<div id="driverLoginFormHide" class="none">
			<form:form method="POST" modelAttribute="customerForm" action="/fuber/custRegistration">
 				 <input type="hidden" id="latitude" name="latitude" value="" class="addLatitude"/>
 				 <input type="hidden" id="longitude" name="longitude" value="" class="addLongitude"/>
 				<spring:bind path="userName">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="userName" class="form-control" placeholder="Customer Name"></form:input>
						<form:errors path="userName"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="password">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="password" path="password" class="form-control" placeholder="Password"></form:input>
						<form:errors path="password"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="email">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="email" class="form-control" placeholder="E-mail"></form:input>
						<form:errors path="email"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="mobileNumber">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="mobileNumber" class="form-control" placeholder="Mobile Number"></form:input>
						<form:errors path="mobileNumber"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="pickupLocation">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="pickupLocation" class="form-control" placeholder="Pick Up Location"></form:input>
						<form:errors path="pickupLocation"></form:errors>
					</div>
				</spring:bind>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
			</form:form>
		</div>
		<div id = "custLoginFormHide" class="none">
       		<form:form method="POST" modelAttribute="driverForm" action="/fuber/driverRegistration">
 				 <input type="hidden" id="latitude" name="latitude" value="" class="addLatitude"/>
 				 <input type="hidden" id="longitude" name="longitude" value="" class="addLongitude"/>
 				<spring:bind path="userName">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="userName" class="form-control" placeholder="Driver Name"></form:input>
						<form:errors path="userName"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="password">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="password" path="password" class="form-control" placeholder="Password"></form:input>
						<form:errors path="password"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="email">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="email" class="form-control" placeholder="E-mail"></form:input>
						<form:errors path="email"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="mobileNumber">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="mobileNumber" class="form-control" placeholder="Mobile Number"></form:input>
						<form:errors path="mobileNumber"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="vehicleNumber">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="vehicleNumber" class="form-control" placeholder="Vehicle Number"></form:input>
						<form:errors path="vehicleNumber"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="location">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="location" class="form-control" placeholder="Location"></form:input>
						<form:errors path="location"></form:errors>
					</div>
				</spring:bind>
				<spring:bind path="color">
					<div class="form-group ${status.error ? 'has-error' : ''}">
						<form:input type="text" path="color" class="form-control" placeholder="Cab Color"></form:input>
						<form:errors path="color"></form:errors>
					</div>
				</spring:bind>
        		<button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
    		</form:form>
        </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/fuber/resources/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(':radio').change(function (event) {
    	var id = $(this).data('id');
    	$('#' + id).addClass('none').siblings().removeClass('none');
	});

	function getLatLong(){
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(setPosition);
	    } else { 
	        alert("Geolocation is not supported by this browser.");
	    }
	}

	function setPosition(position) {
	    $(".addLatitude").val(position.coords.latitude);
	    $(".addLongitude").val(position.coords.longitude);
	}
</script>
</body>
</html>