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
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
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
		if(typeof '${error}' != 'undefined' && '${error}' != ''){
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
					<a href="home" class="nav-item nav-link active">REGISTER</a>
					<!--                 <a href="#" class="nav-item nav-link">Services</a> -->
					<!--                 <a href="#" class="nav-item nav-link">About</a> -->
					<!--                 <a href="#" class="nav-item nav-link">Contact</a> -->
				</div>
				<div class="navbar-nav ml-auto">
					<a href="admin" class="nav-item nav-link">Login</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="row justify-content-center">
		<div class="col-md-12">
			<div class="card">
				<header class="card-header">
					<h4 class="card-title mt-2">Admin Login</h4>
				</header>
				<article class="card-body">
					<small id="emsg" class="text-center alert-danger d-none">'${error}'
					</small>
					<form:form id="loginForm" method="get" action="menu"
						modelAttribute="session">
						<div class="form-row">
							<div class="col form-group">
								<form:label path="admin.adminID">Adminstrator ID </form:label>
								<form:input type="text" class="form-control"
									placeholder="Admin ID" value="" id="adminID"
									path="admin.adminID" />
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block">
								Login</button>
						</div>
					</form:form>
				</article>
			</div>
		</div>

		<!-- card-body end .// -->
	</div>
</body>
</html>