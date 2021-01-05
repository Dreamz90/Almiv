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
		var $regexname = /^[STFG]\d{7}[A-Z]$/;
		$("#myForm").submit(function(event) {

			if (!$("#nric").val().match($regexname)) {
				// there is a mismatch, hence show the error message
				$('#emsg').removeClass('d-none');
				$('#emsg').show();
				event.preventDefault();
			} else {
				// else, do not display message
				$('.emsg').addClass('d-none');
			}

		});

		$("#hpNo").bind("keypress", function(e) {
			var keyCode = e.which ? e.which : e.keyCode

			if (!(keyCode >= 48 && keyCode <= 57)) {
				$(".error").css("display", "inline");
				return false;
			} else {
				$(".error").css("display", "none");
			}
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
					<a href="home"
						class="nav-item nav-link active">REGISTER</a>
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
					<form:form id="myForm" method="post" action="verify" modelAttribute="student">
						<div class="form-row">
							<div class="col form-group">
								<form:label path="name">Full Name (as in NRIC) </form:label>
								<form:input type="text" class="form-control"
									placeholder="Student's Full Name" value="" id="name"
									path="name" required="true" />
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="nric">NRIC No. </form:label>
								<form:input type="text" class="form-control"
									placeholder="Student's NRIC number" maxlength="9" minlength="9" value="" id="nric"
									path="nric" required="true" />
								<form:errors path="nric" cssClass="error" />
								<small id="emsg" class="alert-danger d-none">Please
									enter a valid NRIC/FIN</small>
							</div>
						</div>
						<div class="form-group">
							<div class="form-check">
								<form:radiobutton class="form-check-input" name="gender"
									id="gender1" path="gender" value="M" />
								<form:label path="gender" class="form-check-label" for="gender1">Male</form:label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" name="gender"
									id="gender2" path="gender" value="F" />
								<form:label path="gender" class="form-check-label" for="gender2"> Female </form:label>
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="hpNo">Contact Number</form:label>
								<form:input type="text" maxlength="8" minlength="8" class="form-control"
									placeholder="" value="" id="hpNo" path="hpNo" required="true" />
							</div>
						</div>
						<div class="form-group">
							<label>Email address</label>
							<form:input type="email" class="form-control" placeholder=""
								path="email" />
							<small class="form-text text-muted">We will send the
								receipt to this email.</small>
						</div>
						<div class="form-group">
							<label for="address">Address</label>
							<form:textarea class="form-control" id="address" path="address"
								rows="3" maxlength="90" required="true"></form:textarea>
						</div>
						<div class="form-group">
							<div class="dropdown">
								<label>Student's registration class</label>
								<form:select path="studentClass" class="form-control select-css">
									<form:options items="${classList}" />
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block">
								Submit</button>
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
