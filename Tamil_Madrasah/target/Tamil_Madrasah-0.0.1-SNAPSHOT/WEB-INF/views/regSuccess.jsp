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
				<div id="eMsg" class="alert-danger d-none text-center" role="alert">${eMsg}</div>
				<div id="sMsg" class="alert-success d-none text-center" role="alert">${sMsg}</div>
				</header>
				<article class="card-body">
					<form:form method="get" action="home" modelAttribute="student">
						<div class="form-group">
							<button type="submit" name="action" value="add" class="btn btn-primary btn-block">
								Register Another Student</button>
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
