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
		
		
		<script type="text/javascript" src="js/salon.js"></script>
		<%
			String idGame = request.getParameter("idGame");
		%>
		<title>Salon - <% out.print(idGame); %></title>
	</head>
	<body>
	<%
	String pseudo = (String)session.getAttribute("pseudo");
	Integer idUser = (Integer)session.getAttribute("idUser");
	%>
	 <input type="hidden" name="pseudo" value="<% out.print(pseudo);%>"> 
	 <input type="hidden" name="idUser" value="<% out.print(idUser);%>">
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
			         <li><a href="compte.jsp">Mon compte</a></li>
			      </ul>

		        <ul class="nav navbar-nav navbar-right margin-right-5">
		         <li class="dropdown">
		            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		            	<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
		            	
		        		<%if(pseudo != null){ out.print(pseudo);%>
		        		<%}else{ %>
		        		Invité
		        		<%} %>
		        		 <b class="caret"></b>
		            </a>
		            <ul class="dropdown-menu">
		            <%if(pseudo != null){%>
		               <li><a href="#">Mon Compte</a></li>
		              <li><a href="#">Mes stats</a></li>
		               <li><a href="#" id="logout">Déconnexion</a></li>
					<%}
		            else{%>
		               <li><a href="#" id="linkConnection">Connexion</a></li>
		              <li><a href="#" id="linkInscription">S'inscrire</a></li>
		              <%} %>
		            </ul>
		         </li>
		      </ul>
			   </div>
			</nav>
		</header>

		<div class="container fill bg" >
			<div class="row margin-top-hackNavbar">
				<div class="col-xs-2" >
					<div class="row text-center margin-top-hackNavbar">
						<div class="col-xs-12">
							<img src="img/user3.png" class="img-responsive image-center" alt="Responsive image" >
						</div>
						<div class="col-xs-12 top-20">
							<img src="img/red.png" class="img-responsive image-center" alt="Responsive image" width="50px;">
						</div>
					</div>
					<%
						String p1 = request.getParameter("p1");
					%>
					<div class="row text-center">
						<h3 id="p1" style="color:#04478A; font-weight: bold;"><% out.print(p1); %></h3>
					</div>
				</div>

				<div class="col-xs-8" >
					<div class="row text-center margin-top-hackNavbar">
						<div class="col-xs-12">
							<canvas id="mainCanvas" width="750" height="700">
								Not compatible.
							</canvas>
						</div>
					</div>
					 
				</div>

				<% String p2 = request.getParameter("p2"); %>


				<div id="p2Div" class="col-xs-2 hidden" >
					<div class="row text-center margin-top-hackNavbar">
						<div class="col-xs-12">
							<img src="img/user3.png" class="img-responsive image-center" alt="Responsive image" >
						</div>
						<div class="col-xs-12 top-20">
							<img src="img/yellow.png" class="img-responsive image-center" alt="Responsive image" width="50px;">
						</div>
					</div>
					<div class="row text-center">
						<h3 id="p2" style="color:#04478A; font-weight: bold;"><% out.print(p2); %></h3>
					</div>
				</div>

				
				<%
				if (p1 != null && !p1.equals(""))
				{
				%>
				<button id="launchGame" class="btn btn-primary disabled" style="margin-left:0px;">Commencer</button>
				<%
				}
				%>
			</div>
			<form id="formLogOut" action="Connection" method="GET" style="display:none;">
				<input type="text" name="logout" value="true">
			</form>
		</div>
	</div>
	</body>
</html>