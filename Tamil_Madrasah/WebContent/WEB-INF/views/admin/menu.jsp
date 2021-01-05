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
		$("#a").click(function(e) {
			$("#MenuForm").submit(); // calls the submit handler
			e.preventDefault(); // Prevents the default behavior of the link
		});
		if (typeof '${error}' != 'undefined' && '${error}' != '') {
			$('#emsg').removeClass('d-none');
			$('#emsg').text('${error}');
			$('#emsg').show();
		}
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
					<a href="menu" class="nav-item nav-link active"> ADMIN MENU</a>

					<!--                 <a href="#" class="nav-item nav-link">About</a> -->
					<!--                 <a href="#" class="nav-item nav-link">Contact</a> -->
				</div>
				<div class="navbar-nav ml-auto">
					<!--                 <a href="#" class="nav-item nav-link">Register</a> -->
					<!-- 				 <a href="/tamil_madarasah_registration/admin" class="nav-item nav-link">Login</a> -->
					<p class="text-white">${name}</p>
				</div>
			</div>
		</div>
	</nav>

	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card">
				<header class="card-header">
					<h4 class="text-center card-title mt-2">Admin Menu</h4>
				</header>
				<article class="card-body">
					<small id="emsg" class="alert-danger d-none"></small>
					<form:form id="loginForm" method="post" action="options"
						modelAttribute="session">
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="pendingPayment">Pending Fees
								Payment</button>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="allStudentList" >List All Students</button>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="editStudent" >Edit Student</button>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="editInnerClass" disabled>Edit Student
								Inner Class level</button>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="resendReceipt" disabled>Resend Receipt Email</button>
						</div>
					</form:form>
				</article>
			</div>
		</div>

		<!-- card-body end .// -->
	</div>
</body>
</html>