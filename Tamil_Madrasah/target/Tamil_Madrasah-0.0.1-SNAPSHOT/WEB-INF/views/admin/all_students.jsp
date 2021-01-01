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
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/datatable.css"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs4/jq-3.3.1/jszip-2.5.0/dt-1.10.20/b-1.6.1/b-colvis-1.6.1/b-flash-1.6.1/b-html5-1.6.1/b-print-1.6.1/cr-1.5.2/fc-3.3.0/fh-3.1.6/kt-2.5.1/r-2.2.3/rg-1.1.1/rr-1.2.6/sc-2.0.1/sp-1.0.1/sl-1.3.1/datatables.min.css" />

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs4/jq-3.3.1/jszip-2.5.0/dt-1.10.20/b-1.6.1/b-colvis-1.6.1/b-flash-1.6.1/b-html5-1.6.1/b-print-1.6.1/cr-1.5.2/fc-3.3.0/fh-3.1.6/kt-2.5.1/r-2.2.3/rg-1.1.1/rr-1.2.6/sc-2.0.1/sp-1.0.1/sl-1.3.1/datatables.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {

		var JSON = eval('${json}');
		var table = $('#student_table').DataTable({
			scrollY : true,
			scrollCollapse : true,
			aaSorting : [],
			select : true,
			dom : 'Bfrtip',
			buttons : [ {
				extend : 'excelHtml5',
				exportOptions : {
					columns : [ 0, 1, 2, 3, 4, 5, 6, , 7 ]
				}
			}, {
				extend : 'pdfHtml5',
				exportOptions : {
					columns : [ 0, 1, 2, 3, 4, 5, 6, 7 ]
				}
			} ],
			data : JSON,
			columns : [ {
				data : "isNew"
			}, {
				data : "nric"
			}, {
				data : 'name'
			}, {
				data : 'gender'
			}, {
				data : 'studentClass'
			}, {
				data : 'hpNo'
			}, {
				data : 'email'
			}, {
				data : 'address'
			} ]

		});
		table.columns.adjust().draw();

		$("#a").click(function(e) {
			$("#MenuForm").submit(); // calls the submit handler
			e.preventDefault(); // Prevents the default behavior of the link
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
					<a href="home" class="nav-item nav-link active">REGISTER</a> <a
						href="menu" class="nav-item nav-link active"> ADMIN MENU</a>

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
		<div class="col-md-12">
			<div class="card">
				<header class="card-header">
					<h4 class="card-title mt-2">Registered Student List</h4>
				</header>
				<article class="card-body">
					<table id="student_table"
						class="table table-sm table-bordered display">
						<thead class="thead-light ">
							<tr>
								<th>Type</th>
								<th>NRIC/FIN</th>
								<th>Name</th>
								<th>Gender</th>
								<th>Student Class</th>
								<th>Contact No</th>
								<th>Email</th>
								<th>Address</th>

							</tr>
						</thead>
						<tbody>
							<!-- Iterating over the list sent from Controller -->

							<tr class="text-center">
								<td>row1</td>
								<td>row2</td>
								<td>row3</td>
							</tr>
							<tr></tr>
							<tr></tr>
							<tr class="text-center"></tr>
						</tbody>
					</table>
					<form:form id="refreshForm" method="post" action="options"
						modelAttribute="session">
						<div class="col-md-4 offset-md-4">
							<button type="submit" name="action" value="allStudentList"
								class="btn btn-primary btn-block">Refresh</button>
						</div>
					</form:form>
				</article>
			</div>
		</div>

		<!-- card-body end .// -->
	</div>
</body>
</html>