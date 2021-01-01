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
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.1/dist/jquery.validate.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.1/dist/additional-methods.min.js"></script>


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
				var $regexname = /^[STFG]\d{7}[A-Z]$/;
				$("#myForm").submit(function(event) {
					if (!$('#disable_textfield').is(':checked')) {
						if (!$("#textField").val().match($regexname)) {
							// there is a mismatch, hence show the error message
							$('#emsg').removeClass('d-none');
							$('#emsg').text('Please enter a valid NRIC/FIN');
							$('#emsg').show();
							event.preventDefault();
						} else {
							// else, do not display message
							$('.emsg').addClass('d-none');
						}
					}
				});
		$('#disable_textfield').click(function() {
			var isChecked = $("#disable_textfield").val();
			$("#textField").attr("disabled", true);
		});
		$('#enable_textfield').click(function() {
			var isChecked = $("#enable_textfield").val();
			$("#textField").attr("disabled", false);
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
					<h4 class="card-title mt-2">Welcome to Tamil Madarasah
						Registration ${year}</h4>
				</header>
				
				<article class="card-body">
					<form:form name="myForm" id="myForm" method="post"
						action="register" modelAttribute="student">
						<div class="form-group">
							<div class="form-check">
								<form:radiobutton class="form-check-input"
									name="disable_textfield" id="disable_textfield" path="isNew"
									value="Y" />
								<form:label path="isNew" class="form-check-label">New Student</form:label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input"
									name="enable_textfield" id="enable_textfield" path="isNew"
									value="N" checked="checked" />
								<form:label path="isNew" class="form-check-label"> Existing Student </form:label>
							</div>
						</div>
						<div class="form-row">
							<div class="col form-group">
								<form:label path="nric">Enter Student NRIC number</form:label>
								<form:input type="text" class="form-control" placeholder=""
									value="" name="textField" id="textField" path="nric" maxlength="9" minlength="9"
									disabled="false" required="true" />
								<form:errors path="nric" cssClass="error" />
								<small id="emsg" class="alert-danger d-none">Please
									enter a valid NRIC/FIN</small>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block"
								id="submitBtn" name="action" value=" ">Register</button>
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