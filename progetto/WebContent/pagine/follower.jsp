<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.PagableResponseList"%>
<%@page import="twitter4j.IDs"%>
<%@page import="twitter4j.User"%>
<%@page import="twitter4j.AccountSettings"%>
<%@page import="twitter4j.Twitter"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
	

<script src="../js/grafop.js"></script>	
<script src="script.js"></script>



<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="http://cytoscape.github.io/cytoscape.js/api/cytoscape.js-latest/cytoscape.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.rawgit.com/cytoscape/cytoscape.js-qtip/2.1.0/cytoscape-qtip.js"></script>
	
	
	
	
	
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
	
		});

		function chiama(){
			addNodeToGraph('ciao', 'http://pbs.twimg.com/profile_images/538427649610506240/j-p9SF3y_normal.jpeg');
			addEdge('marzo', 'ciao');
		}
	</script>
	
	
	




	<% 	
		class Utente 
		{
			long id;
			String url;
		}
	
		class Arco
		{
			long idSource;
			long idTarget;
		}
	
		
		Twitter twitter = (Twitter)session.getAttribute("twitter");
		User myUser = (User)session.getAttribute("myUser");	
	
		String id[] = request.getParameterValues("follower");
		
		User followers[] = new User[id.length];
		
		int k = 0;
		for (String s: id){
			followers[k++] = twitter.showUser(Long.parseLong(s));
		}		
		
		ArrayList<Utente> listaUtenti = new ArrayList<Utente>();
		ArrayList<Arco> listaArchi = new ArrayList<Arco>();
		
		
		
	%>
	
</head>
<body>

	<div class="left" style="vertical-align: baseline;">

		<div class="followersfloor">
			<table>
					<tr>
						<td>
							<img class="toggle" src="../resources/minus.png" width="20px">
						</td>
						<td> 
							<img src="<%= myUser.getProfileImageURL()%>">
						</td>
						<td class="userName">
							<%= myUser.getName() %>
						</td>
						<td class="userFollowersCountSentence">
							User followers count:
						</td>
						<td class="userFollowersCount">
						 	<%=myUser.getFollowersCount() %>
						</td>
						<% 
							Utente utente = new Utente();
							utente.id = myUser.getId();
							utente.url = myUser.getBiggerProfileImageURL();

							listaUtenti.add(utente);
						 %>
					</tr>
			</table>
			<div class="espandibile">
				
				
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
										<%= u.getName() %>
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
		
									listaUtenti.add(utente2);
									
									Arco a = new Arco();
									a.idSource = utente.id;
									a.idTarget = utente2.id;
									
									listaArchi.add(a);
								 %>
							</table>
							<div class="espandibile">
													
								<%							
									PagableResponseList<User> innerFollowers = twitter.getFollowersList(u.getId(), -1);
									for(User user:innerFollowers){
								%>													
												<div class="followersfloor">
													<table style="padding-left: 120px">
														<tr>
															<td> 
																<img src="<%= user.getProfileImageURL()%>">
															</td>
															<td class="userName">
																<%= user.getName() %>
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
							
														listaUtenti.add(utente3);
														
														Arco a1 = new Arco();
														a1.idSource = utente2.id;
														a1.idTarget = utente3.id;
														
														listaArchi.add(a1);
													 %>
													<div class="espandibile">
														
													</div>
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
	
	<div class="right" style="vertical-align: top;">
		<a class="aqua-button" onclick="mostraGrafo()">
									<span class="shine"></span>
									<span class="glow"></span>
									Mostra il grafo
		</a>
		
	</div>
	<div class="overlay" id="cy">
	</div>
	<% for (Utente u: listaUtenti)
	{
		%>
		<%= u.id %>
		<%
	}
		%>
		
		<br>
	<% 	for(Arco a: listaArchi) {
			
			%>
					<%= String.valueOf(a.idSource) %> <%= String.valueOf(a.idTarget)%> <br>
			<%
				}
	%>
	
	
		<script>
	var disegnato = false;

	function mostraGrafo()
	{
		toggleGrafo();
		if (disegnato == false){
			aggiungi();
			disegnato = true;				
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