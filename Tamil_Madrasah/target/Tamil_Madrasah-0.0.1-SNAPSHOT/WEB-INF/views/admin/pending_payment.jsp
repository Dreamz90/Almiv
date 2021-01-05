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
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
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
	$(document)
			.ready(
					function() {

						var JSON = eval('${json}');
						var table = $('#table_id')
								.DataTable(
										{
											scrollY : true,
											scrollCollapse : true,
											select : true,
											dom : 'Bfrtip',
											buttons : [
													{
														extend : 'excelHtml5',
														exportOptions : {
															columns : [ 0, 1,
																	2, 3, 4, 5,
																	6 ]
														}
													},
													{
														extend : 'pdfHtml5',
														exportOptions : {
															columns : [ 0, 1,
																	2, 3, 4, 5,
																	6 ]
														}
													} ],
											data : JSON,
											columns : [
													{
														data : "isNew"
													},
													{
														data : "nric"
													},
													{
														data : 'name'
													},
													{
														data : 'hpNo'
													},
													{
														data : 'studentClass'
													},
													{
														data : 'email'
													},
													{
														data : 'payment'
													},
													{
														data : null,
														render : function(data,
																type, row) {
															return '<button class="btn btn-info edit_btn" name="payProcessBtn" data-toggle="modal" data-target="#myModal"  id="'+data.nric+'">Make Payment</button>';
														}
													} ]

										});
						table.columns.adjust().draw();
						$('#table_id').on(
								'click',
								'tbody .edit_btn',
								function() {
									var data_row = table.row(
											$(this).closest('tr')).data();
									$("#myModal").modal('show');
									$('#myModal').on(
											'shown.bs.modal',
											function() {
												$('#modalName').val(
														data_row.name);
												$('#modalNric').val(
														data_row.nric);
												$('#modalEmail').val(
														data_row.email);
												$('#modalClass').val(
														data_row.studentClass);
											});
								});
						//		  $('#table_id tbody').on( 'click', 'button', function () {
						//		        var data = table.row( $(this).closest('tr') ).data();
						//		        alert( data[0] );
						//		    } );

						$("#a").click(function(e) {
							$("#MenuForm").submit(); // calls the submit handler
							e.preventDefault(); // Prevents the default behavior of the link
						});
						$('[name=payProcessBtn]').click(
								function(e) {
									$("#payBtn").prop("disabled", false).text(
											"Submit");
								});
						$("#payBtn")
								.click(
										function(e) {
											$(this).prop("disabled", true);
											// add spinner to button
											$(this)
													.html(
															`<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>Processing...`);
											$("#payForm").submit(); // calls the submit handler
											e.preventDefault(); // Prevents the default behavior of the link
										});
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
					<h4 class="card-title mt-2">Students with Pending Payments</h4>
				</header>
				<div id="eMsg" class="alert-danger d-none text-center" role="alert">${eMsg}</div>
				<div id="sMsg" class="alert-success d-none text-center" role="alert">${sMsg}</div>
				<article class="card-body">
					<table id="table_id" class="table table-sm table-bordered display">
						<thead class="thead-light ">
							<tr>
								<th>Type</th>
								<th>NRIC/FIN</th>
								<th>Name</th>
								<th>Contact No</th>
								<th>Student Class</th>
								<th>Email</th>
								<th>Payment</th>
								<th></th>

							</tr>
						</thead>
						<tbody>
							<!-- Iterating over the list sent from Controller -->

							<tr>
								<td>row1</td>
								<td>row2</td>
								<td>row3</td>
							</tr>

						</tbody>
					</table>
					<form:form id="refreshForm" method="post" action="options"
						modelAttribute="session">
						<div class="col-md-4 offset-md-4">
							<button type="submit" name="action" value="pendingPayment"
								class="btn btn-primary btn-block">Refresh</button>
						</div>
					</form:form>
				</article>
			</div>
		</div>

		<div id="myModal" class="modal  fade " role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content ">
					<div class="modal-header">
						<h4 class="modal-title">Payment Menu</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">

						<!-- 						<label>Edit&nbsp;<span id="camp"></span>&nbsp;Campaign -->
						<!-- 						</label> -->

						<form:form method="post" action="processPayment" id="payForm"
							modelAttribute="session">
							<form:input type="text" hidden="true" value="${ID}"
								class="form-control" id="adminID" path="admin.adminID" />
							<form:input type="text" hidden="true" value="${name}"
								class="form-control" id="adminName" path="admin.adminName" />
							<div class="form-group">
								<form:label path="student.nric" for="nric">NRIC/FIN</form:label>
								<form:input type="text" path="student.nric" id="modalNric"
									class="form-control" value="" readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="student.name" for="name">Name</form:label>
								<form:input type="text" path="student.name" id="modalName"
									class="form-control" value="" readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="student.email" for="email">Email</form:label>
								<form:input type="text" path="student.email" id="modalEmail"
									class="form-control" value="" readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="student.studentClass" for="studentClass">Class</form:label>
								<form:input type="text" path="student.studentClass"
									id="modalClass" class="form-control" value="" readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="student.payment.amount_paid" for="type">Payment</form:label>
								<div class="input-group mb-4">
									<div class="input-group-prepend">
										<span class="input-group-text">$</span>
									</div>
									<form:input type="number" class="form-control" value="0"
										min="0" path="student.payment.amount_paid" id="modalAmt"
										aria-label="Amount (to the nearest dollar)" />
									<div class="input-group-append">
										<span class="input-group-text">.00</span>
									</div>
								</div>
							</div>
							<div class="form-group text-center">
								<button type="submit" id="payBtn"
									class="btn btn-primary btn-block">Submit</button>
							</div>
						</form:form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
			<div class="submit-progress hidden">
				<label>Please wait while Processing Payment...</label>
			</div>
			<!-- card-body end .// -->
		</div>
	</div>
</body>
</html>