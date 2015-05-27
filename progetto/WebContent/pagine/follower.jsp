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
	<script src="../js/jquery-1.11.3.min.js"></script>
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

		
	
	</script>




	<% 	Twitter twitter = (Twitter)session.getAttribute("twitter");
		User myUser = (User)session.getAttribute("myUser");	
	
		String id[] = request.getParameterValues("follower");
		
		
		User followers[] = new User[id.length];
		
		int k = 0;
		for (String s: id){
			followers[k++] = twitter.showUser(Long.parseLong(s));
		}		
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
</body>
</html>