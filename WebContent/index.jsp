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
			      <a class="navbar-brand" href="index.html">Puissance 4</a>
			   </div>
			   
		      <div class="collapse navbar-collapse" id="navbarContent">
			      <ul class="nav navbar-nav">
			      	<li class="active"><a href="#">Accueil</a></li>
			         <li><a href="#">Rooms</a></li>
			         <li><a href="#">Tournois</a></li>
			         <li><a href="#">Stats</a></li>
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
					<a class="btn btn-primary btn-lg" href="personalise.jsp" role="button">Partie personnalisée </a>
				</div>
			</div>

		</div>
	</div>
	</body>
</html>