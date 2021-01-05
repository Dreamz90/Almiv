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
		$(searchForm).prop("hidden", !${Display});
		$(editForm).prop("hidden", ${Display});
		if (typeof "${eMsg}" != 'undefined' && "${eMsg}" != '') {
			$('#eMsg').removeClass('d-none');
			$('#eMsg').text("${eMsg}");
			$('#eMsg').show();
		}
		if (typeof "${sMsg}" != 'undefined' && "${sMsg}" != '') {
			$('#sMsg').removeClass('d-none');
			$('#sMsg').text("${sMsg}");
			$('#sMsg').show();
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
					<a href="menu"
						class="nav-item nav-link active"> ADMIN MENU</a>

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
					<h4 class="text-center card-title mt-2">Edit Student</h4>
				</header>
				<div id="eMsg" class="alert-danger d-none text-center" role="alert">${eMsg}</div>
				<div id="sMsg" class="alert-success d-none text-center" role="alert">${sMsg}</div>
				<article class="card-body">
					
					<form:form id="searchForm" method="post" action="retireveStudent"
						modelAttribute="session">
						<div class="form-group">
							<form:label path="student.nric" for="nric">NRIC/FIN</form:label>
							<form:input type="text" path="student.nric" id="nric"
								class="form-control" value="" />
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="pendingPayment">Retrieve</button>
						</div>
					</form:form>
					<form:form id="editForm" method="post" action="editStudent"
						modelAttribute="session" hidden="true">
						<div class="form-row">
							<div class="col form-group">
								<form:label path="student.name">Student Name</form:label>
								<form:input type="text" class="form-control"
									placeholder="Student's Full Name" value="" id="name"
									path="student.name" />
							</div>
						</div>
						<div class="form-group">
							<div class="form-check">
								<form:radiobutton class="form-check-input" name="gender"
									id="gender1" path="student.gender" value="M" />
								<form:label path="student.gender" class="form-check-label"
									for="gender1">Male</form:label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" name="gender"
									id="gender2" path="student.gender" value="F" />
								<form:label path="student.gender" class="form-check-label"
									for="gender2"> Female </form:label>
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="student.hpNo">Contact Number</form:label>
								<form:input type="text" maxlength="8" minlength="8"
									class="form-control" placeholder="" value="" id="hpNo"
									path="student.hpNo" required="true" />
							</div>
						</div>
						<div class="form-group">
							<label>Email address</label>
							<form:input type="email" class="form-control" placeholder=""
								path="student.email" />
						</div>
						<div class="form-group">
							<label for="address">Address</label>
							<form:textarea class="form-control" id="address"
								path="student.address" rows="3" maxlength="90" required="true"></form:textarea>
						</div>
						<div class="form-group">
							<div class="dropdown">
								<label>Student's registration class</label>
								<form:select path="student.studentClass"
									class="form-control select-css">
									<form:options items="${classList}" />
								</form:select>
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="student.isNew">Is a New Student?(Y/N)</form:label>
								<form:input type="text" maxlength="1" minlength="1"
									class="form-control" placeholder="" value="" id="isNew"
									path="student.isNew" required="true" />
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="student.registered_year">Registered Year</form:label>
								<form:input type="text" maxlength="4" minlength="4"
									class="form-control" placeholder="" value=""
									id="registered_year" path="student.registered_year"
									required="true" />
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="student.hasPaidFees">Has Paid Fees in Full?(Y/N)</form:label>
								<form:input type="text" maxlength="1" minlength="1"
									class="form-control" placeholder="" value="" id="hasPaidFees"
									path="student.hasPaidFees" required="true" />
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								name="action" value="pendingPayment">Edit</button>
						</div>
					</form:form>
				</article>
			</div>
		</div>

		<!-- card-body end .// -->
	</div>
</body>
</html>
