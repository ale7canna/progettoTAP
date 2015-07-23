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
<%@page isErrorPage="true" %>
<%@page import="twitter4j.RateLimitStatus" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error Page</title>
<link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
<link href="../css/style.css" rel="stylesheet" type="text/css">

<script src="../js/jquery-1.11.3.min.js"></script>

<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/jquery.qtip.min.js"></script>
<link href="../css/jquery.qtip.min.css" rel="stylesheet" type="text/css" />

	
	<%
		Twitter twitter = (Twitter)session.getAttribute("twitter");
		Throwable e = (Throwable)session.getAttribute("exception");
		e.printStackTrace();
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
					</tr>
				</table>
			
			</div>
			
		</div>

		<div class="left" style="width:80vw">
			<h4>
				Sorry, the page is not reachable.</h4> <br>
				<h5>Maybe you have exceed twitter limits. Try to check request availability</h5><br><br>
				<%	if (e != null)
					{
						
						if (e.getMessage() != null)
						{
				%>		
					<h6><%= 	e.getMessage() %></h6>
				<%			
					
						}
						session.removeAttribute("exception");
					}
					
				
					if (twitter == null)
					{
				%>
					Login again to use application	
				<% 		
					}
				
				%>
				
			
		</div>

	</div>

</body>

	<% 		
		String content = "";
		if (twitter != null)
		{
			Map<String ,RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus();
			
			RateLimitStatus status = rateLimitStatus.get("/followers/ids");
			content = "Follower search: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		    
		    status = rateLimitStatus.get("/followers/list");
		    content = content + "Follower list: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		    
			status = rateLimitStatus.get("/users/show/:id");
		    content = content + "User Show: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		    
		    status = rateLimitStatus.get("/users/search");
		    content = content + "User Search: " + String.valueOf(status.getRemaining()) + " Reset time in: " + String.valueOf(status.getSecondsUntilReset()) + "<br>";
		}
		else
		{
			content = "Rieseguire l\\'accesso";
		}
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
	              delay: 1200,
	              effect: function(offset) {
	                  $(this).slideDown(1000); // "this" refers to the tooltip
	              }
	          }
		
			
		});
		
	</script>


</html>