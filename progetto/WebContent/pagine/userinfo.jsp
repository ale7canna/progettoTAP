<%@page import="twitter4j.PagableResponseList"%>
<%@page import="twitter4j.IDs"%>
<%@page import="twitter4j.User"%>
<%@page import="twitter4j.AccountSettings"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="connessione.Utente" %>
<%@page import="connessione.Arco" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Information</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.11.3.min.js"></script>

	<%! 	
		
		public void aggiungiUtente(ArrayList<Utente> lista, Utente user)
		{
			for(Utente u: lista) {
				if (u.id == user.id)
					return;
			}
			lista.add(user);
		}
	
		public void aggiungiArco(ArrayList<Arco> lista, Arco arco)
		{
			for(Arco a: lista) {
				if ( (a.idSource == arco.idSource) && (a.idTarget == arco.idTarget) )
					return;
			}
			lista.add(arco);
		}
	%>
	
	<% 	
		Twitter twitter = (Twitter)session.getAttribute("twitter");
		
		String userID = request.getParameter("userID");
		User user = null;
		if (userID != null)
			user = twitter.showUser(Long.parseLong(userID));
		else {
				
			user = twitter.showUser((long)session.getAttribute("userID"));
			
		}
			
		session.setAttribute("myUser", user);
		//IDs ids = twitter.getFollowersIDs(user.getId());
		IDs listaIDs = twitter.getFollowersIDs(user.getId(), -1); // Dopo twitter.showUser();
		
		ArrayList<Utente> listaUtenti = new ArrayList<Utente>();
		ArrayList<Arco> listaArchi = new ArrayList<Arco>();
	
	%>


</head>
<body>
	<div class="container">
		<div class="left">
			<div class="center">
				<table style="margin: auto">
					<tr>
						<td>
							<% 	Utente utente = new Utente();
								utente.id = user.getId();
								utente.url = user.getBiggerProfileImageURL();
								aggiungiUtente(listaUtenti, utente);
							%>
							<img src="<%= user.getOriginalProfileImageURL()  %>" width="256px" height="256px">
						</td>
						<td>
							<table>
								<tr>
									<td>
										<ul>
											<li><a href="#"><%= user.getName() %></a></li>
											<li><a href="#"><%= user.getLocation() %></a></li>										
											<li><a href="#">Following count <%= user.getFriendsCount() %></a></li>
											<li><a href="#">Follower count <%= user.getFollowersCount() %></a></li>
										</ul>
									</td>
								</tr>
							</table>
						</td>
				
				
					</tr>
				</table>
			</div>
		</div>
		<div class="right">
			<div class="center">
				<form name="formFollower" method="get" action="follower.jsp">
					<div id="userList" class="shadow">
						<h2>Selezionare i profili da analizare</h2>
						<table class="users" align="center">
						<%	
							int k = 0;
							for(long id: listaIDs.getIDs())
							{	
								User u = twitter.showUser(id);
								if (k % 2 == 0)
									out.println("<tr>");
						%>
							
								<td><input type="checkbox" id="<%= u.getId() %>" name="follower" value="<%= u.getId() %>"></td>
								<td><img src="<%= u.getProfileImageURL() %>" onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));"></td>
								
								<td class="nomeUtente">
									<p class="pNomeUtente" style="display: block">
										<%=u.getName()%>
									</p>
								</td>
								
						
						<%		
								if (k % 2 == 1)
									out.println("</tr>");
								k++;		
								
								
								Utente utente2 = new Utente();
								utente2.id = u.getId();
								utente2.url = u.getBiggerProfileImageURL();
							
								aggiungiUtente(listaUtenti, utente2);
								
								Arco a = new Arco();
								a.idSource = utente.id;
								a.idTarget = utente2.id;
								
								aggiungiArco(listaArchi, a);
								
								if (k > 160)
									break;
								
							}
						%>
						</table>
						</div>

						<table align="center">
							<tr>
								<td>
									<a href="#" class="button" onclick="formFollower.submit()">Invia</a>
								</td>
							</tr>
						</table>
						<% 	session.setAttribute("listaUtenti", listaUtenti);
							session.setAttribute("listaArchi", listaArchi);
						%>
					</form>
				</div>
			</div>
		</div> 
		
	</div>
</body>
</html>