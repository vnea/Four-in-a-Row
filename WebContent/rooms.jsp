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
		<script src="js/jquery.validationEngine-fr.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/rooms.js"></script>
		
		<title>Salons</title>
		<script>
			$(function() {

				$("#formInscription").validationEngine('attach');
				$("#formConnection").validationEngine('attach');
				
				
				$("#linkInscription").click(function(){
					$('#modalInscription').modal();
				});
				
				$("#linkConnection").click(function(){
					$('#modalConnection').modal();
				});
				
				
				
				$("#logout").click(function(){
					$("#formLogOut").submit();
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
				
				$('#modalInscription').on('shown.bs.modal', function () {
					$('.modal:visible').each(reposition);
					$('#myInput').focus();
				});
				
				$('#modalConnection').on('shown.bs.modal', function () {
					$('.modal:visible').each(reposition);
					$('#myInput').focus();
				});
				
				$('#modalError').on('shown.bs.modal', function () {
					$('.modal:visible').each(reposition);
					$('#myInput').focus();
				});
				
				 // Reposition when the window is resized
				$(window).on('resize', function() {
					$('.modal:visible').each(reposition);
				});
				 
				$("#btnInscription").click(function(){
					$("#formInscription").submit();
				});
				
				$("#btnConnection").click(function(){
					$("#formConnection").submit();
				});
				
				
			});

		</script>
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
			         <li class="active"><a href="rooms.jsp">Rooms</a></li>
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
			
						<!-- MODALE D'INSCRIPTION -->
			<div class="modal fade" id="modalInscription" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Création compte</h4>
			      </div>
			      <div class="modal-body">
			       	<form id="formInscription" class="form-horizontal" method="POST" action="Connection">
						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="pseudo">Pseudo :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="pseudo"  class="form-control validate[required]" id="pseudo" name="pseudo">
						    	</div>
						  </div>
  						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="newPassword">Mot de passe :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"   class="form-control validate[required]" id="password" name="password">
						    	</div>
						  </div>

						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="confirmPassword">Confirmation :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"  class="form-control validate[required, equals[password]]" id="confirmPassword" name="confirmPassword">
						    	</div>
						  </div>
						</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Retour</button>
			        <button id="btnInscription" type="button" class="btn btn-primary">Valider</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<!-- MODAL DE CONNEXION -->
			<div class="modal fade" id="modalConnection" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Connexion</h4>
			      </div>
			      <div class="modal-body">
			       	<form id="formConnection" class="form-horizontal" method="POST" action="Connection">
						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="pseudo">Pseudo :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="pseudo"  class="form-control validate[required]" name="pseudo">
						    	</div>
						  </div>
  						  <div class="form-group">
						    <label  class="col-xs-5 control-label" for="password">Mot de passe :</label>
						    	<div class="col-xs-5" style="margin-right: 2px; padding: 0px; margin-top:8px;">
					    			<input type="password"  class="form-control validate[required]" name="password">
						    	</div>
						  </div>
						</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Retour</button>
			        <button id="btnConnection" type="button" class="btn btn-primary">Valider</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<%Boolean error = (Boolean)session.getAttribute("error");
			if(error != null && error){ 
				String typeError = (String)session.getAttribute("typeError");
				String msgError = (String)session.getAttribute("msgError");
				String modal = (String)session.getAttribute("modal");%>
			<!-- MODAL ERREUR -->
			<div class="modal fade" id="modalError" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel"><%out.print(typeError);%></h4>
			      </div>
			      <div class="modal-body">
			      		<%out.print(msgError);%>
			      </div>
			      <div class="modal-footer">

			        <button id="btnOkError" type="button" class="btn btn-primary">Ok</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<%
				StringBuilder sb = new StringBuilder();
			
				sb.append("<script>$('#modalError').modal(); $('#btnOkError').click(function(){$('#modalError').modal('hide');");
				if(modal == "connexion")
					sb.append("$('#modalConnection').modal();");
				else
					sb.append("$('#modalInscription').modal();");
				sb.append("});");
				sb.append("$('#modalError').on('shown.bs.modal', function () {$('.modal:visible').each(reposition);$('#myInput').focus();});");
				sb.append("</script>");
				
				out.print(sb.toString());
				session.invalidate();

			} 
			%>		
			
			<form id="formLogOut" action="Connection" method="GET" style="display:none;">
				<input type="text" name="logout" value="true">
			</form>
		</div>
	</div>
	</body>
</html>