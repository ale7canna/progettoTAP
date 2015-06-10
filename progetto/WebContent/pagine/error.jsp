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
<link href="../css/style.css" rel="stylesheet" type="text/css">

<script src="../js/jquery-1.11.3.min.js"></script>

<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/jquery.qtip.min.js"></script>
<link href="../css/jquery.qtip.min.css" rel="stylesheet" type="text/css" />

	
	<%
		session.setAttribute("exception", exception);
		response.sendRedirect("errorPage.jsp");
	%>
	
</head>
<body>
	
</body>

</html>