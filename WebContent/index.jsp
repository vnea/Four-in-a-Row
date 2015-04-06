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
		<title>Accueil</title>
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
			      	<li class="active"><a href="#">Accueil</a></li>
			         <li><a href="rooms.jsp">Rooms</a></li>
			         <li><a href="#">Tournois</a></li>
			         <li><a href="compte.jsp">Mon compte</a></li>
			      </ul>

		        <ul class="nav navbar-nav navbar-right margin-right-5">
		         <li class="dropdown">
		            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		            	<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
		        		VictorOuConnexion <b class="caret"></b>
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
				<div class="col-xs-12" >
					<div class="row text-center margin-top-hackNavbar">
						<div class="col-xs-12">
							<img src="img/user3.png" class="img-responsive image-center" alt="Responsive image" >
						</div>
						<div class="col-xs-12">
							<h2>Bonjour !</h2>
						</div>
					</div>
					
				</div>
			</div>
			<div class="row text-center top-20">
				<div class="col-xs-12">
					<a class="btn btn-primary btn-lg" href="salon.jsp" role="button">Partie rapide </a>
				</div>
			</div>

			<div class="row text-center top-20">
				<div class="col-xs-12">
					<!--<a class="btn btn-primary btn-lg"  href="personnalise.html" role="button">Partie personnalisée </a>-->
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
					  Partie personnalisée
					</button>

				</div>
			</div>


			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Paramètres de la partie</h4>
			      </div>
			      <div class="modal-body">
			       	<form class="form-horizontal" method="POST" action="servlet">
						  <div class="form-group">


						    <label class="col-xs-4 control-label" >Choix du pion :</label>
						    <div class="col-xs-2" style="margin-right: 2px; padding: 0px; margin-top:8px;">
			    				<input id="inputRed" type="radio" checked="" value="red" name="pion">
						    </div>
						    <div class="col-xs-2" style="margin-left:-80px; margin-top:8px;">
						    	<label for="inputRed">
						    		<img src="img/red.png" id="imgRed" class="img-responsive" alt="Jeton rouge" width="25px;">
						    	</label>
						    </div>

						    <div class="col-xs-2" style="margin-right: 2px; padding: 0px; margin-left:-20px; margin-top:8px;">
			    				<input id="inputYellow" type="radio" checked="" value="yellow" name="pion">
						    </div>
						    <div class="col-xs-2" style="margin-left:-80px; margin-top:8px;">
						    	<label for="inputYellow">
						    		<img src="img/yellow.png" id="imgYellow" class="img-responsive" alt="Jeton jaune" width="25px;">
						    	</label>
						    </div>

						  </div>
						  <div class="form-group">
						    <label  class="col-xs-4 control-label">Qui commence ?</label>
						    	<div class="col-xs-2" style="margin-right: 2px; padding: 0px; margin-top:8px;">
						    		
					    			<input type="radio" id="j1" name="j1" value="moi" checked>
					    			<label for="j1"> Moi</label>
						    	</div>
						    	<div class="col-xs-3" style="margin-right: 2px; padding: 0px; margin-top:8px;">
						    		<input type="radio" id="ia" name="j1" value="ia"> 
						    		<label for="ia"> Ordinateur</label>
						    	</div>
						  </div>
						</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Retour</button>
			        <button type="button" class="btn btn-primary">C'est parti !</button>
			      </div>
			    </div>
			  </div>
			</div>

		</div>
	</div>
	</body>
</html>