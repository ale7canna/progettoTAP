<%@page import="twitter4j.RateLimitStatus"%>
<%@page import="twitter4j.TwitterException"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page import="twitter4j.PagableResponseList"%>
<%@page import="twitter4j.IDs"%>
<%@page import="twitter4j.User"%>
<%@page import="twitter4j.AccountSettings"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="connessione.Utente" %>
<%@page import="connessione.Arco" %>
<%@page errorPage="error.jsp" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Follower graph</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
	

<script src="../js/grafop.js"></script>
<script src="../js/script.js"></script>	


<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/cytoscape.min.js"></script>
<script src="../js/jquery.qtip.min.js"></script>
<link href="../css/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
<script src="../js/cytoscape-qtip.js"></script>
	
	
	
	
	
	<script>
		$(document).ready(function() {
			
			$('.toggle').click(function(){		
					
					espandibleDiv = $(this).closest(".followersfloor").find(".espandibile"); 
    				espandibleDiv.toggle();
    				if (espandibleDiv.is(":visible"))
        				$(this).attr("src", "../resources/minus.png")
        			else 
        				$(this).attr("src", "../resources/plus.png")
				});			

			aggiungi();
		});
		

	</script>
	
	
	




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
		
		public boolean isInFollower(long id, String[] ids)
		{
			for (String s: ids)
			{
					if (id == Long.parseLong(s))
						return true;
			}
			return false;
		}
	%>
	<%
	
	
		Twitter twitter = (Twitter)session.getAttribute("twitter");
		User myUser = (User)session.getAttribute("user");	
	
		String idsRequest[] = request.getParameterValues("follower");
			
		
		ArrayList<Utente> listaFollowerUtenti = (ArrayList<Utente>)session.getAttribute("listaUtenti");
		ArrayList<Arco> listaArchi = (ArrayList<Arco>)session.getAttribute("listaArchi");
		
		ArrayList<Utente> listaUtenti = new ArrayList<Utente>();
		
		ArrayList<User> listaFollower = (ArrayList<User>)session.getAttribute("listaFollower");
		
		for (Utente myFol: listaFollowerUtenti)
			aggiungiUtente(listaUtenti, myFol);
		
		
		
		
	%>
	
</head>
<body>
	<div class="container">
		<div class="up">
			<div class="center" style="width:100%; height:100%">
				<table style="margin: auto">
					<tr>
						<td style="padding: 0 1vw"><a href="/progetto/"><img src="../resources/home.png" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="/progetto/pagine/userinfo.jsp"><img src="../resources/profile.jpg" title="Go to last profile information" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="#"><img id="limitButton" src="../resources/limit.png" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="https://www.twitter.com/logout">
							<img src="../resources/logout.png" width="30px"></a></td>
					</tr>
				</table>
			
			</div>
			
		</div>
	
		<div class="left" style="vertical-align: baseline;">
	
			<div class="followersfloor" style="height: 86vh; overflow-y: auto">
				<!-- INIZIO UTENTE AUTENTICATO -->
				<table>
						<tr>
							<td>
								<a href="#"><img class="toggle" src="../resources/minus.png" width="20px"></a>
							</td>
							<td> 
								<img src="<%= myUser.getProfileImageURL()%>">
							</td>
							<td class="userName">
								<a target="_blank" href="http://twitter.com/<%=myUser.getScreenName()%>"><%= myUser.getName() %></a>
							</td>
							<td class="userFollowersCountSentence">
								User followers count:
							</td>
							<td class="userFollowersCount">
							 	<%=myUser.getFollowersCount() %>
							</td>
							<% 
								/*Utente utente = new Utente();
								utente.id = myUser.getId();
								utente.url = myUser.getBiggerProfileImageURL();
								aggiungiUtente(listaUtenti, utente);*/
							 %>
						</tr>
				</table>
				<!-- FINE UTENTE AUTENTICATO -->
				
				
				<div class="espandibile">
					
					<!-- INIZIO FOLLOWER UTENTE AUTENTICATO -->		
					<%	
						for(User u:listaFollower){					
					%>		
							<div class="followersfloor">
								<table style="padding-left: 50px">
									<tr>
									
										<% if (isInFollower(u.getId(), idsRequest)){
											
										%>
										<td style="padding-left: -20px">
											<a href="#"><img class="toggle" src="../resources/minus.png" width="20px"></a>
										</td>
										
										<% }
										else {
											%>
											<td style="padding-left: -20px">
											<a href="#"><img class="toggle" src="../resources/minus.png" style="opacity: 0" width="20px"></a>
										</td>
										<%
										}
										%>
										<td style="margin-left:25px"> 
											<img src="<%= u.getProfileImageURL()%>">
										</td>
										<td class="userName">
											<a target="_blank" href="http://twitter.com/<%=u.getScreenName()%>"><%= u.getName() %></a>
										</td>
										<td class="userFollowersCountSentence">
											User followers count:
										</td>
										<td class="userFollowersCount">
							 				<%=u.getFollowersCount() %>
										</td>
									</tr>
									<% 
										Utente utente2 = new Utente();
										utente2.id = u.getId();
										utente2.url = u.getBiggerProfileImageURL();
										utente2.userName = u.getName();
										utente2.link = "http://twitter.com/" + u.getScreenName();
										/*
										if (!listaUtenti.contains(utente2))
											listaUtenti.add(utente2);
										
										Arco a = new Arco();
										a.idSource = utente.id;
										a.idTarget = utente2.id;
										
										if (!listaArchi.contains(a))
											listaArchi.add(a);*/
									 %>
								</table>
					<!-- FINE FOLLOWER UTENTE AUTENTICATO -->			
								<div class="espandibile">
														
									<%		
										if (isInFollower(u.getId(), idsRequest))
										{
											PagableResponseList<User> innerFollowers = twitter.getFollowersList(u.getId(), -1);
											
											for(User user:innerFollowers){
									%>				
												<!-- INIZIO FOLLOWER di FOLLOWER -->									
														<div class="followersfloor">
															<table style="padding-left: 120px">
																<tr>
																	<td> 
																		<img src="<%= user.getProfileImageURL()%>">
																	</td>
																	<td class="userName">
																		<a target="_blank" href="http://twitter.com/<%=user.getScreenName()%>"> <%= user.getName() %></a>
																	</td>
																	<td class="userFollowersCountSentence">
																		User followers count:
																	</td>
																	<td class="userFollowersCount">
														 				<%=user.getFollowersCount() %>
																	</td>
																</tr>
															</table>
															<% 
																Utente utente3 = new Utente();
																utente3.id = user.getId();
																utente3.url = user.getBiggerProfileImageURL();
																utente3.userName = user.getName();
																utente3.link = "http://twitter.com/" + user.getScreenName();
									
																aggiungiUtente(listaUtenti, utente3);
																
																Arco a1 = new Arco();
																a1.idSource = utente2.id;
																a1.idTarget = utente3.id;
																
																aggiungiArco(listaArchi, a1);
															 %>
												<!-- FINE FOLLOWER di FOLLOWER -->
														</div>																				
									<% 	
											}
										}
									%>
							
								</div>
							</div>
							
							
					<% 	
						}
					%>
					
				</div>
			</div>
	
		</div>
		
		<div class="right" style="vertical-align: middle;">
			<a href="#" class="button" onclick="mostraGrafo()">Click to see the graph</a>
			
		</div>
	
	</div>

	<div class="overlayHidden" id="cy">
	</div>
	
	<div class="overlayHiddenButton">
		<a href="#" class="button" style="margin: 0;" onclick="mostraGrafo()">Hide</a>
	</div>
	

	
	
	<script>
	var mostrato = false;
	
	function mostraGrafo()
	{
		if (mostrato == false) {
//			$("#cy").css("display", "block");
			$('.container').removeClass('container').addClass('containerblur');
			$('.overlayHidden').removeClass('overlayHidden').addClass('overlay');
			$('.overlayHiddenButton').removeClass('overlayHiddenButton').addClass('overlayButton');
			
			setTimeout(function() {
				ridimensionaGrafo();	
			}, 300);
			
			mostrato = true;
			
		}
		else {
			$('.containerblur').removeClass('containerblur').addClass('container');
			$('.overlay').removeClass('overlay').addClass('overlayHidden');
			$('.overlayButton').removeClass('overlayButton').addClass('overlayHiddenButton');
			mostrato = false;
			
		}
		
	}

	
	function aggiungi(){ 
			disegnaGrafo();
			<% 	for(Utente u: listaUtenti) {
					
			%>
					addNodeToGraph('<%= String.valueOf(u.id) %>', '<%= u.url %>', '<%= u.userName.replace("'", "\\'") %>', '<%= u.link%>');
			<%
				}
			%>
			
			<% 	for(Arco a: listaArchi) {
				
				%>
						addEdge('<%= String.valueOf(a.idSource) %>', '<%= String.valueOf(a.idTarget)%>');
				<%
					}
				%>
			aggiornaLayout();

	}
	
	
		<% 	String content = "";
			Map<String ,RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus();
			RateLimitStatus status = rateLimitStatus.get("/followers/ids");
			    /*System.out.println("Endpoint: " + endpoint);
			    System.out.println(" Limit: " + status.getLimit());
			    System.out.println(" Remaining: " + status.getRemaining());
			    System.out.println(" ResetTimeInSeconds: " + status.getResetTimeInSeconds());
			    System.out.println(" SecondsUntilReset: " + status.getSecondsUntilReset());*/
			    
			    content = "Follower search: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
			    
			    status = rateLimitStatus.get("/followers/list");
			    content = content + "Follower list: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
			    
				status = rateLimitStatus.get("/users/show/:id");
			    content = content + "User Show: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
			    
			    status = rateLimitStatus.get("/users/search");
			    content = content + "User Search: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
			    /*
			content = "";
			for (String s: rateLimitStatus.keySet())
			{
				status = rateLimitStatus.get(s);
				content = content + "<br><br>" + "EndPoint: " + s + "<br>";
				content = content + "Limit: " + String.valueOf(status.getLimit()) + " ";
				content = content + "Reman: " + String.valueOf(status.getRemaining()) + " ";
			}
			   */ 			
		
		%>
	
		$("#limitButton").qtip({
			content: '<%=content %>',
			
			position: {
			    my: 'top center',
			    at: 'bottom center'
			  },
			  style: {
			    classes: 'qtip-bootstrap myQtip',
			    
			    tip: {
			      width: 16,
			      height: 8
			    }
			  },
			  show: 'click',
			  hide: {
	              fixed: true,
	              delay: 1300
	          }
		
			
		});
	
	</script>	

</body>
</html>