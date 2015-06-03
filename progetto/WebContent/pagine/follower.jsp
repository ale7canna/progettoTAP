<%@page import="twitter4j.TwitterException"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<title>Insert title here</title>
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
			//$("#cy").css("display", "none");
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
	%>
	<%
	
	
		Twitter twitter = (Twitter)session.getAttribute("twitter");
		User myUser = (User)session.getAttribute("myUser");	
	
		String id[] = request.getParameterValues("follower");
			
		User followers[] = new User[id.length];
		
		int k = 0;
		for (String s: id)
		{
			followers[k++] = twitter.showUser(Long.parseLong(s));
		}		
		
		ArrayList<Utente> listaFollowerUtenti = (ArrayList<Utente>)session.getAttribute("listaUtenti");
		ArrayList<Arco> listaArchi = (ArrayList<Arco>)session.getAttribute("listaArchi");
		
		ArrayList<Utente> listaUtenti = new ArrayList<Utente>();
		
		for (Utente myFol: listaFollowerUtenti)
			aggiungiUtente(listaUtenti, myFol);
		
		
		
		
	%>
	
</head>
<body>
	<div class="container">
		<div class="left" style="vertical-align: baseline;">
	
			<div class="followersfloor" style="height: 90vh; overflow-y: auto">
				<!-- INIZIO UTENTE AUTENTICATO -->
				<table>
						<tr>
							<td>
								<img class="toggle" src="../resources/minus.png" width="20px">
							</td>
							<td> 
								<img src="<%= myUser.getProfileImageURL()%>">
							</td>
							<td class="userName">
								<a href="userinfo.jsp?userID=<%=myUser.getId()%>"><%= myUser.getName() %></a>
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
						for(User u:followers){					
					%>		
							<div class="followersfloor">
								<table style="padding-left: 50px">
									<tr>
										<td>
											<img class="toggle" src="../resources/minus.png" width="20px">
										</td>
										<td> 
											<img src="<%= u.getProfileImageURL()%>">
										</td>
										<td class="userName">
											<a href="userinfo.jsp?userID=<%= u.getId()%>"><%= u.getName() %></a>
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
																	<a href="userinfo.jsp?userID=<%=user.getId()%>"><%= user.getName() %></a>
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
			<a href="#" class="button" onclick="mostraGrafo()">Mostra il grafo</a>
			
		</div>
	</div>

	<div class="overlayHidden" id="cy">
	</div>
	
	<div class="overlayHidden" style="position:absolute; top: 5vh; left: 10vw">
		<a href="#" class="button" onclick="mostraGrafo()">Chiudi</a>
	</div>
	

	
	
	<script>
	var mostrato = false;
	
	function mostraGrafo()
	{
		if (mostrato == false) {
//			$("#cy").css("display", "block");
			$('.container').removeClass('container').addClass('containerblur');
			$('.overlayHidden').removeClass('overlayHidden').addClass('overlay');
			
			setTimeout(function() {
				ridimensionaGrafo();	
			}, 300);
			
			mostrato = true;
			
		}
		else {
			$('.containerblur').removeClass('containerblur').addClass('container');
			$('.overlay').removeClass('overlay').addClass('overlayHidden');
			mostrato = false;
			
		}
		
	}

	
	function aggiungi(){ 
			disegnaGrafo();
			<% 	for(Utente u: listaUtenti) {
					
			%>
					addNodeToGraph('<%= String.valueOf(u.id) %>', '<%= u.url %>');
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
	
	</script>		

</body>
</html>