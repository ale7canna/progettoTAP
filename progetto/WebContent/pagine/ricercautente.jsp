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


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%	
		out.println("CIoa");
		Twitter twitter = (Twitter)session.getAttribute("twitter");
	
		Query q = new Query("Giorgio");
		
		QueryResult qr = twitter.search(q);
		List<Status> res = qr.getTweets();
		
		for (Status s:res)
			out.println(s.getText());
		
		
		%>
</body>
</html>