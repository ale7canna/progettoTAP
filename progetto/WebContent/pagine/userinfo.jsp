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

	<% 	
		Twitter twitter = (Twitter)session.getAttribute("twitter");
		AccountSettings as = twitter.getAccountSettings();
		User user = twitter.showUser(as.getScreenName());
		session.setAttribute("myUser", user);
		//IDs ids = twitter.getFollowersIDs(user.getId());
		IDs listaIDs = twitter.getFollowersIDs(user.getId(), -1); // Dopo twitter.showUser();
		PagableResponseList<User> ids = twitter.getFollowersList(user.getId(), -1);
		
		ArrayList<Utente> listaUtenti = new ArrayList<Utente>();
		ArrayList<Arco> listaArchi = new ArrayList<Arco>();
	
	%>


</head>
<body>
	<div class="container">
		<div class="left">
			<div class="center">
				<table>
					<tr>
						<td>
							<% 	Utente utente = new Utente();
								utente.id = user.getId();
								utente.url = user.getBiggerProfileImageURL();
								if (!listaUtenti.contains(utente))
									listaUtenti.add(utente);
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
											<li><a href="#"><%= user.getFriendsCount() %></a></li>
											<li><a href="#"><%= user.getFollowersCount() %></a></li>
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
			<form name="formFollower" method="get" action="follower.jsp">
				<div id="userList">
					<table class="users" align="center">
					<%	
						int k = 0;
						//for (User u:ids)
						//long idiesse[] = i.getIDs();
						for(long id: listaIDs.getIDs())
						{	
							User u = twitter.showUser(id);
							if (k % 2 == 0)
								out.println("<tr>");
					%>
						
							<td><input type="checkbox" name="follower" value="<%= u.getId() %>"></td>
							<td><img src="<%= u.getProfileImageURL() %>"></td>
							<td class="nomeUtente"><span><%=u.getName()%></span></td>
					
					<%		
							if (k % 2 == 1)
								out.println("</tr>");
							k++;		
							
							
							Utente utente2 = new Utente();
							utente2.id = u.getId();
							utente2.url = u.getBiggerProfileImageURL();
						
							if (!listaUtenti.contains(utente2))
								listaUtenti.add(utente2);
							
							Arco a = new Arco();
							a.idSource = utente.id;
							a.idTarget = utente2.id;
							
							if (!listaArchi.contains(a))
								listaArchi.add(a);
						
							
						}
					%>
					</table>
					<table align="center">
						<tr>
							<td>
								<a class="aqua-button" onclick="formFollower.submit()">
									<span class="shine"></span>
									<span class="glow"></span>
									Invia tuoi Follower
								</a>
							</td>
						</tr>
					</table>
					<% 	session.setAttribute("listaUtenti", listaUtenti);
						session.setAttribute("listaArchi", listaArchi);
					%>
				</div>
			</form>
		</div> 
		
	</div>
</body>
</html>