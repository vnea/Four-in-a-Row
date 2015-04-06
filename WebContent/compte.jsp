<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="css/bootstrap.css">
		<link rel="stylesheet" href="css/style.css">
		<script src="js/jquery-1.11.2.js" type=""></script>
		<script src="js/bootstrap.min.js"></script>
		<title>Mon compte</title>
		<script>
			$(function() {

				$("#linkInscription").click(function(){
					$('#myModal2').modal();
				});


				$("#aForm").submit(function(){
				  return false;
				});

				$("#btnValidate").click(function(){
					$("#formPassword").submit();
				});

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

				$('#myModal2').on('shown.bs.modal', function () {
					$('.modal:visible').each(reposition);
					$('#myInput').focus();
				});

				 // Reposition when the window is resized
				$(window).on('resize', function() {
					$('.modal:visible').each(reposition);
				});
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
			         <li><a href="rooms.jsp">Rooms</a></li>
			         <li><a href="#">Tournois</a></li>
			         <li class="active"><a href="compte.jsp">Mon compte</a></li>
			      </ul>

		        <ul class="nav navbar-nav navbar-right margin-right-5">
		         <li class="dropdown">
		            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		            	<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
		            	 <b class="caret"></b>
		            </a>
		            <ul class="dropdown-menu">
		               <li><a href="#" id="linkConnection">Connexion</a></li>
		              <li><a href="#" id="linkInscription">S'inscrire</a></li>

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
						<h2 style="color:#044483;">Mes informations :</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 top-20">
						<form id="aForm" class="form-horizontal">
							<div class="form-group">
								<label  class="col-xs-4 control-label">Pseudo :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="pseudo" name="pseudo" type="text">VitoZer</label>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-4 col-xs-offset-3" style="padding-left:0px;">
									<button id="btnShowModal" class="btn btn-primary" style="margin-left:0px;" data-toggle="modal" data-target="#myModal"> Changez de mot de passe</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<!--Parties solo -->
				<div class="row">
					<div class="col-xs-11 col-xs-offset-1 top-20">
						<h2 style="color:#044483;">Parties en solo :</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 top-20">
						<form class="form-horizontal" method="POST">
							<div class="form-group">
								<label  class="col-xs-4 control-label">Parties jouées :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="nbPJ" name="nbPJ" type="text">6</label>
								</div>
							</div>

							<div class="form-group">
								<label  class="col-xs-4 control-label">Parties gagnées :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="nbPG" name="nbPG" type="text">5</label>
								</div>
							</div>

							<div class="form-group">
								<label  class="col-xs-4 control-label">Parties perdues :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="nbPP" name=""nbPP"" type="text">1</label>
								</div>
							</div>
						</form>
					</div>
				</div>

				<!-- Parties en ligne -->
				<div class="row">
					<div class="col-xs-11 col-xs-offset-1 top-20">
						<h2 style="color:#044483;">Parties en ligne :</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 top-20">
						<form class="form-horizontal" method="POST">
							<div class="form-group">
								<label  class="col-xs-4 control-label">Parties jouées :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="nbPJO" name="nbPJO" type="text">6</label>
								</div>
							</div>

							<div class="form-group">
								<label  class="col-xs-4 control-label">Parties gagnées :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="nbPGO" name="nbPGO" type="text">5</label>
								</div>
							</div>

							<div class="form-group">
								<label  class="col-xs-4 control-label">Parties perdues :</label>
								<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
									<label id="nbPPO" name="nbPPO" type="text">1</label>
								</div>
							</div>
						</form>
					</div>
				</div>

			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Modification mot de passe</h4>
			      </div>
			      <div class="modal-body">
			       	<form id="formPassword" class="form-horizontal" method="POST" action="servlet">
						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="password">Ancien mot de passe :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"  class="form-control" id="password" name="password">
						    	</div>
						  </div>
  						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="newPassword">Nouveau mot de passe :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="newPassword"  class="form-control" id="newPassword" name="newPassword">
						    	</div>
						  </div>

						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="confirmPassword">Confirmation :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="confirmPassword"  class="form-control" id="confirmPassword" name="confirmPassword">
						    	</div>
						  </div>
						</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Retour</button>
			        <button id="btnValidate" type="button" class="btn btn-primary">Validez</button>
			      </div>
			    </div>
			  </div>
			</div>

			<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Création compte</h4>
			      </div>
			      <div class="modal-body">
			       	<form id="formPassword" class="form-horizontal" method="POST" action="servlet">
						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="password">Pseudo :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"  class="form-control" id="password" name="password">
						    	</div>
						  </div>
  						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="newPassword">Mot de passe :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"   class="form-control" id="newPassword" name="newPassword">
						    	</div>
						  </div>

						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="confirmPassword">Confirmation :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"  class="form-control" id="confirmPassword" name="confirmPassword">
						    	</div>
						  </div>
						</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Retour</button>
			        <button id="btnValidate" type="button" class="btn btn-primary">Valider</button>
			      </div>
			    </div>
			  </div>
			</div>


			</div>
		</div>
	</div>
	</body>
</html>