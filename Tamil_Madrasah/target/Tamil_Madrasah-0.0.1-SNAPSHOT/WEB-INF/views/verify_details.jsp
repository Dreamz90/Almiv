<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
 		$("#studentForm :input:not(:button)").prop("disabled", true);
		$("#editBtn").click(function() {
			$("#studentForm :input:not(:button)").prop("disabled", false);
			$("#studentForm").attr('action', 'register');
		});
		$("#submitBtn").click(function() {
			$("#studentForm :input:not(:button)").prop("disabled", false);
		});
	});
</script>
</head>
<body>
	<nav class="navbar navbar-expand-md navbar-dark bg-dark mb-3">
		<div class="container-fluid">
			<a href="#" class="navbar-brand mr-3">ALMIV</a>
			<button type="button" class="navbar-toggler" data-toggle="collapse"
				data-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<div class="navbar-nav">
					<a href="home" class="nav-item nav-link active">REGISTER</a>
					<!--                 <a href="#" class="nav-item nav-link">Services</a> -->
					<!--                 <a href="#" class="nav-item nav-link">About</a> -->
					<!--                 <a href="#" class="nav-item nav-link">Contact</a> -->
				</div>
				<!--             <div class="navbar-nav ml-auto"> -->
				<!--                 <a href="#" class="nav-item nav-link">Register</a> -->
				<!--                 <a href="#" class="nav-item nav-link">Login</a> -->
				<!--             </div> -->
			</div>
		</div>
	</nav>
	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card">
				<header class="card-header">
					<h4 class="card-title mt-2">Enter The Student Details</h4>
				</header>
				<article class="card-body">
					<form:form method="post" action="registered" modelAttribute="student"
						id="studentForm" name="">
						<div class="form-row">
							<div class="col form-group">
								<form:label path="name">Full Name (as in NRIC) </form:label>
								<form:input type="text" readonly="true" class="form-control"
									placeholder="Student's Full Name" value="" id="name"
									path="name" />
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="nric">NRIC No. </form:label>
								<form:input type="text" class="form-control"
									placeholder="Student's NRIC number" readonly="true" value="" id="nric"
									path="nric" />
							</div>
						</div>
						<div class="form-group">
							<div class="form-check">
								<form:radiobutton class="form-check-input" name="gender" readonly="true"
									id="gender1" path="gender" value="M" />
								<form:label path="gender" class="form-check-label" for="gender1">Male</form:label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" name="gender" readonly="true"
									id="gender2" path="gender" value="F" />
								<form:label path="gender" class="form-check-label" for="gender2"> Female </form:label>
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="hpNo">Contact Number</form:label>
								<form:input type="text" maxlength="8" class="form-control" readonly="true"
									placeholder="" value="" id="hpNo" path="hpNo"
									onkeypress="return isNumberKey(event)" />
							</div>
						</div>
						<div class="form-group">
							<label>Email address</label>
							<form:input type="email" class="form-control" placeholder="" readonly="true"
								path="email" id="email" />
							<small class="form-text text-muted">We will send the
								receipt to this email.</small>
						</div>
						<div class="form-group">
							<label for="address">Address</label>
							<form:textarea class="form-control" id="address" path="address" readonly="true"
								rows="3" required="true"></form:textarea>
						</div>
						<div class="form-group">
							<div class="dropdown">
								<label>Student's registration class</label>
								<form:select path="studentClass" class="select-css" id="studentClass" readonly="true"> 
									<form:options items="${classList}" class="dropdown-menu" />
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-secondary btn-block mr-1"
								id="editBtn" name="action" value="edit">Edit</button>
							<button type="submit" class="btn btn-primary btn-block"
								id="submitBtn" name="action" value="register">Register</button>
						</div>
						<!-- 						<small class="text-muted">By clicking the 'Sign Up' -->
						<!-- 							button, you confirm that you accept our <br> Terms of use -->
						<!-- 							and Privacy Policy. -->
						<!-- 						</small> -->
					</form:form>
				</article>
			</div>
		</div>

		<!-- card-body end .// -->
	</div>
</body>
</html>
