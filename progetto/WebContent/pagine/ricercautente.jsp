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
<%@page import="twitter4j.RateLimitStatus" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User search</title>
<link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
<link href="../css/style.css" rel="stylesheet" type="text/css">

<script src="../js/jquery-1.11.3.min.js"></script>

<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/jquery.qtip.min.js"></script>
<link href="../css/jquery.qtip.min.css" rel="stylesheet" type="text/css" />

<script>
	function inviaUtente() {
			var checked = document.querySelectorAll('input[type="radio"]:checked');
			if (checked.length > 0)			
				formSearch.submit();
			else
				alert("Check one user please");
			
		}
	
	
	function isInputEmpty()
	{
		if (document.forms["formRicerca"]["userSearch"].value == "" || document.forms["formRicerca"]["userSearch"].value == null)
			return true;
		else
			return false;
	}

	function inviaRicerca()
	{
		if (isInputEmpty()) {
			alert("Please insert a valid name");
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function buttonSearchPressed()
	{
		if (isInputEmpty()) {
			alert("Please insert a valid name");
		}
		else {
			formRicerca.submit();
		}
			
	}
</script>
	
	
	<%
		List<User> result = (List<User>)session.getAttribute("userResult");
		Twitter twitter = (Twitter)session.getAttribute("twitter");
	%>
	
</head>
<body>
	<div class="container">
		
		<div class="up">
			<div class="center" style="width:100%; height:100%">
				<table style="margin: auto">
					<tr>
						<td style="padding: 0 1vw"><a href="/progetto/"><img src="../resources/home.png" width="30px"></a></td>
						<td style="padding: 0 1vw"><a href="#"><img id="limitButton" src="../resources/limit.png" width="30px"></a></td>
					</tr>
				</table>
			
			</div>
			
		</div>


		<div class="left">
			<div style="height:100%; width: 100%">
				
					
				<span style="display: table-cell; width:100vw; height: 13vh; vertical-align: bottom; text-align: center">
					<h2>Search user result</h2>
				</span>

				<a href="#" class="button" onclick="inviaUtente()">Show user</a>
				<div class="shadow" style="overflow-y: auto; height: 68vh;width:  90%;margin: auto;">
					<form method="GET" name="formSearch" action="userinfo.jsp" style=" width:100%; height:90%">
						
						<table class="users" align="center">
						<%	
							for (User u : result) {
						%>
								<tr>
									<td>
										<input id="<%= u.getId() %>" type="radio" name="userID" value="<%= u.getId() %>">		
									</td>
									<td onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));">
										<img src="<%= u.getProfileImageURL() %>" >
									</td>
									<td class="userName" onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));">
										<p class="nomeUtente"><%= u.getName() %> </p>
									</td>
									<td class="userFollowersCountSentence" onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));">
										Follower count
									</td>
									<td class="userFollowersCount" onclick="$('#<%= u.getId() %>').prop('checked', !$('#<%= u.getId() %>').prop('checked'));">
										<%= u.getFollowersCount() %>
									</td>
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
				<p>Enter name to search for profiles</p>
				<form method="POST" name="formRicerca" action ="/progetto/AppOnlySignIn" onsubmit="return inviaRicerca()">
					<input type="text" name="userSearch">
					<a href="#" class="button" onclick="buttonSearchPressed()">Search</a>
				</form>
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