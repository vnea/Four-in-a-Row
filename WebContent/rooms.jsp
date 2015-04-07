<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="css/bootstrap.css">
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/dataTables.bootstrap.css">
		<script src="js/jquery-1.11.2.js" type=""></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.js"></script>
		<script src="js/rooms.js"></script>
		
		<title>Salons</title>
		<script>
			$(function() {
				 function reposition() {
					var modal = $(this),
					dialog = modal.find('.modal-dialog');
					modal.css('display', 'block');
					// Dividing by two centers the modal exactly, but dividing by three
					// or four works better for larger screens.
					dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
				}
				$('#myModal').on('shown.bs.modal', function () {
					$('.modal:visible').each(reposition);
					$('#myInput').focus();
				});
				 // Reposition when the window is resized
				$(window).on('resize', function() {
					$('.modal:visible').each(reposition);
				});
				// $('#mytable').dataTable();
			});
		</script>
	</head>
	<body>

	<div class="container-fluid">
		<header class="navbar navbar-bright navbar-fixed-top" role="banner" >
			<nav class="navbar navbar-inverse navbar-fixed-top" >
			   <div class="navbar-header">
			      <button type="button" class="navbar-toggle" data-toggle="collapse" 
			         data-target="#navbarContent">
			         <span class="sr-only">Toggle navigation</span>
			         <span class="icon-bar"></span>
			         <span class="icon-bar"></span>
			         <span class="icon-bar"></span>
			      </button>
			      <a class="navbar-brand" href="index.jsp">Puissance 4</a>
			   </div>
			   
		      <div class="collapse navbar-collapse" id="navbarContent">
			      <ul class="nav navbar-nav">
			      	<li><a href="index.jsp">Accueil</a></li>
			         <li class="active"><a href="#">Rooms</a></li>
			         <li><a href="#">Tournois</a></li>
 			         <li><a href="compte.jsp">Mon compte</a></li>
			      </ul>

		        <ul class="nav navbar-nav navbar-right margin-right-5">
		         <li class="dropdown">
		            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		            	<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
		        		Victor <b class="caret"></b>
		            </a>
		            <ul class="dropdown-menu">
		               <li><a href="#">Mon Compte</a></li>
		              <li><a href="#">Mes stats</a></li>
		               <li><a href="#">Déconnexion</a></li>

		            </ul>
		         </li>
		      </ul>
			   </div>
			</nav>
		</header>

		<div class="container fill bg" >
			<div class="row margin-top-hackNavbar">
				<div class="row">
					<div class="col-xs-11 col-xs-offset-1 top-20">
						<h2 style="color:#044483;">Création partie :</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 top-20">
						<form class="form-horizontal" method="POST">
							<div class="form-group">
								<label  class="col-xs-4 control-label">Nom salon :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<input id="room" type="text"  class="form-control" name="room">
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-4 col-xs-offset-4" style="padding-left:0px;">
									<button id="createRoom" class="btn btn-primary" style="margin-left:0px;">Créer une partie</button>
								</div>
							</div>
						</form>
					</div>
				</div>



				<div class="row">
					<div class="col-xs-11 col-xs-offset-1">
						<h2 style="color:#044483;">Salons :</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 top-20">
						<div class="blocTable" style="margin:auto; width:700px;">
						<table class="table table-condensed table-responsive table-hover table-bordered text-center" id="mytable">
					        <thead>
					            <tr>
					                <th>Nom</th>
					                <th>Joueurs</th>
					                <th></th>
					                <th></th>
					            </tr>
					        </thead>
					        <tbody>
 							</tbody>
						</table>
						</div>
					</div>
				</div>
				
				<form action="salon.jsp" method="post" style="display:none;">
					<input type="hidden" name="idGame">
					<input type="hidden" name="p1">
					<input type="hidden" name="p2">
				</form>
			</div>
		</div>
	</div>
	</body>
</html>