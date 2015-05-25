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
	<% 	Twitter twitter = (Twitter)session.getAttribute("twitter");
		AccountSettings as = twitter.getAccountSettings();
		User user = twitter.showUser(as.getScreenName());
	%>


</head>
<body>
	<div>
		<%= user.getName() %>
		<%= user.getLocation() %>
		<%= user.getFriendsCount() %>
		<%= user.getFollowersCount() %>
		<img src="<%= user.getOriginalProfileImageURL()  %>" width="256px" height="256px">
		
	</div>
</body>
</html>