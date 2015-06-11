<%@page import="twitter4j.TwitterException"%>
<%@page import="twitter4j.PagableResponseList"%>
<%@page import="twitter4j.IDs"%>
<%@page import="twitter4j.User"%>
<%@page import="twitter4j.AccountSettings"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="twitter4j.RateLimitStatus" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="connessione.Utente" %>
<%@page import="connessione.Arco" %>
<%@page errorPage="error.jsp" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Information</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">


<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/jquery.qtip.min.js"></script>
<link href="../css/jquery.qtip.min.css" rel="stylesheet" type="text/css" />


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
		if (userID == null)
			user = (User) session.getAttribute("user");
		else {
			user = twitter.showUser(Long.parseLong(userID));
			session.removeAttribute("listaFollower");
			
		}
			
		session.setAttribute("myUser", user);
		//IDs ids = twitter.getFollowersIDs(user.getId());
		IDs listaIDs = twitter.getFollowersIDs(user.getId(), -1); // Dopo twitter.showUser();
		
		ArrayList<Utente> listaUtenti = new ArrayList<Utente>();
		ArrayList<Arco> listaArchi = new ArrayList<Arco>();
		ArrayList<User> listaFollower = new ArrayList<User>();
	
	%>
	
	<script>
		function inviaFollower() {
			var checked = document.querySelectorAll('input[type="checkbox"]:checked');
			if (checked.length > 0)			
				formFollower.submit();
			else
				alert("Check at least one follower please");
			
		}
	
	</script>


</head>
<body>
	<div class="container">
		<div class="up">
			<div class="center" style="width:100%; height:100%">
				<table style="margin: auto">
					<tr>
						<td style="padding: 0 1vw"><a href="/progetto/"><img src="../resources/home.png" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="/progetto/pagine/userinfo.jsp"><img src="../resources/profile.jpg" title="Go to profile information" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="#"><img id="limitButton" src="../resources/limit.png" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="https://www.twitter.com/logout">
							<img src="../resources/logout.png" width="30px"></a></td>
					</tr>
				</table>
			
			</div>
			
		</div>
			<div class="left">
			<div class="center">
				<table style="margin: auto">
					<tr>
						<td>
							<% 	Utente utente = new Utente();
								utente.id = user.getId();
								utente.url = user.getBiggerProfileImageURL();
								utente.userName = user.getName();
								utente.link = "http://twitter.com/" + user.getScreenName();
								aggiungiUtente(listaUtenti, utente);
							%>
							<img src="<%= user.getOriginalProfileImageURL()  %>" width="256px" height="256px">
						</td>
						<td>
							<table>
								<tr>
									<td>
										<ul>
											<li><a target="_blank" href="http://www.twitter.com/<%=user.getScreenName()%>"><img width="40px" title="Go to your twitter profile" src="../resources/twitter.png"></a>
											<li><a href="#"><%= user.getName() %></a></li>
											<li><a href="#"><%= user.getScreenName() %></a></li>
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
					<h2 style=" margin:0 10px">Select followers to analyze.</h2>
					<h4 style=" margin:0 10px"> (Max 15 according to twitter's limit)</h4>
					<h5 style=" margin:0 10px 15px 10px">Remember that profiles that are protected can not be checked! </h5>
						<table align="center">
							<tr>
								<td>
									<a href="#" class="button" onclick="inviaFollower()">Submit</a>
								</td>
							</tr>
						</table>
					<div id="userList" class="shadow">
						
						<table class="users" align="center">
						<%	
							int k = 0;
							for(long id: listaIDs.getIDs())
							{	
								User u = twitter.showUser(id);
								
								
								if (k % 2 == 0)
									
									out.println("<tr>");
									
									
									
									if(u.isProtected()==true){
										%>
										
								<td ><input type="checkbox" disabled="disabled" id="<%= u.getId() %>" name="follower" value="<%= u.getId() %>"></td>		
								<td><img src="<%= u.getProfileImageURL() %>" ></td>
								<td> <p class="pNomeUtente" style="display: block"> <%=u.getName()%> </p></td>		
								<%	}
									else{
									%>
									
								<td ><input type="checkbox" id="<%= u.getId() %>" name="follower" value="<%= u.getId() %>"></td>
								<td onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));"><img src="<%= u.getProfileImageURL() %>" ></td>
								
								<td class="nomeUtente" onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));">
									<p class="pNomeUtente" style="display: block">
										<%=u.getName()%>
									</p>
								</td>
								
						
						<%		
									} 									
								
						
								if (k % 2 == 1)
									out.println("</tr>");
								k++;		
								
								listaFollower.add(u);
								
								Utente utente2 = new Utente();
								utente2.id = u.getId();
								utente2.url = u.getBiggerProfileImageURL();
								utente2.userName = u.getName();
								utente2.link = "http://twitter.com/" + u.getScreenName();
							
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

						
						<% 	session.setAttribute("listaUtenti", listaUtenti);
							session.setAttribute("listaArchi", listaArchi);
							session.setAttribute("listaFollower", listaFollower);
						%>
					</form>
				</div>
			</div>
		</div> 
		
	</div>
</body>
			
			<% 		String content = "";
			Map<String ,RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus();
			
			RateLimitStatus status = rateLimitStatus.get("/followers/ids");
			content = "Follower search: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		    
		    status = rateLimitStatus.get("/followers/list");
		    content = content + "Follower list: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		    
			status = rateLimitStatus.get("/users/show/:id");
		    content = content + "User Show: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		    
		    status = rateLimitStatus.get("/users/search");
		    content = content + "User Search: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		%>
	<script type="text/javascript">
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
	              delay: 2000
	          }
		
			
		});
	</script>


	
</html>