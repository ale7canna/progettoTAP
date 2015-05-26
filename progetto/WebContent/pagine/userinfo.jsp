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
<title>User Information</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">

	<% 	Twitter twitter = (Twitter)session.getAttribute("twitter");
		AccountSettings as = twitter.getAccountSettings();
		User user = twitter.showUser(as.getScreenName());
		session.setAttribute("myUser", user);
		//IDs ids = twitter.getFollowersIDs(user.getId());
		IDs i = twitter.getFollowersIDs(user.getId());
		PagableResponseList<User> ids = twitter.getFollowersList(user.getId(), -1);
	
	%>


</head>
<body>
	<div class="container">
		<div class="left">
			<div class="center">
				<table>
					<tr>
						<td>
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
						for (User u:ids)
						//long idiesse[] = i.getIDs();
						//for(int k = 0; k < idiesse.length; k ++)
						{	
							//User u = twitter.showUser(idiesse[k]);
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
				</div>
			</form>
		</div> 
		
	</div>
</body>
</html>