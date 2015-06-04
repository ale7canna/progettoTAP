<%@page import="twitter4j.QueryResult"%>
<%@page import="twitter4j.Query"%>
<%@page import="java.util.Enumeration"%>
<%@page import="twitter4j.PagableResponseList"%>
<%@page import="twitter4j.IDs"%>
<%@page import="twitter4j.User"%>
<%@page import="twitter4j.AccountSettings"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="twitter4j.Status"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="connessione.Utente" %>
<%@page import="connessione.Arco" %>
<%@page errorPage="error.jsp" %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ricerca utente</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
	
	<%
		List<User> result = (List<User>)session.getAttribute("userResult");
	%>
	
</head>
<body>
	<div class="container">
		<div class="up">
			<div class="center" style="width:100%; height:100%">
			<a href="/progetto/"><img src="../resources/home.png" width="30px"></a>
			</div>
			
		</div>
		<div class="left">
			<div style="height:100%; width: 100%">
				
					
				<span style="display: table-cell; width:100vw; height: 13vh; vertical-align: bottom; text-align: center"><h2>Risultati della ricerca utente</h2></span>

				<a href="#" class="button" onclick="formSearch.submit()">Visualizza</a>
				<div class="shadow" style="overflow-y: auto; height: 75vh;width:  90%;margin: auto;">
					<form method="GET" name="formSearch" action="userinfo.jsp" style=" width:100%; height:100%">
						
						<table class="users" align="center">
						<%	
							for (User u : result) {
						%>
								<tr>
									<td>
										<input type="radio" name="userID" value="<%= u.getId() %>">		
									</td>
									<td>
										<img src="<%= u.getProfileImageURL() %>" >
									</td>
									<td>
										<p class="nomeUtente"><%= u.getName() %> </p>
									</td>
									<td>Follower count <%= u.getFollowersCount() %></td>
								</tr>
								
								
						<%
							}
							
						%>
							
						</table>						
					</form>	
				</div>
			</div>	
		</div>

		<div class="right">
		
			<div>
				<h1>Ciao Search</h1>
				<form method="POST" name="formRicerca" action ="/progetto/Application">
					<input type="text" name="userSearch">
					<a href="#" class="button" onclick="formRicerca.submit()">Cerca</a>
				</form>
			</div>
		
		</div>
	</div>

</body>
</html>