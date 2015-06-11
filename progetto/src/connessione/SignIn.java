package connessione;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationBuilder;


public class SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final String CONSUMER_KEY = "lcG8Dlc7n21QShe0PQPD1zhbV";
	private final String CONSUMER_SECRET = "BDiIjRmul86mXaGRPnw4utmU2rHnXPoQCHqbuKqmKnteMd0Kad";
    
	
	
	public SignIn() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		
		StringBuffer callbackSB = request.getRequestURL();
		String callback = callbackSB.toString();
 
		callback = callback.substring(0, callback.lastIndexOf('/'));
		callback = callback + "/Callback";
		
				
		
		ConfigurationBuilder builder = new ConfigurationBuilder();
		builder.setOAuthConsumerKey(CONSUMER_KEY);
		builder.setOAuthConsumerSecret(CONSUMER_SECRET);
		Configuration conf = builder.build();
		
		TwitterFactory fact = new TwitterFactory(conf);
		Twitter twit = fact.getInstance();
		
		RequestToken requestToken = null;
		AccessToken accessToken = null;
		String authUrl = "";
		try {
			requestToken = twit.getOAuthRequestToken(callback);
			authUrl = requestToken.getAuthorizationURL()+"&force_login=true";
						
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("requestToken", requestToken);
		request.getSession().setAttribute("twitter", twit);
		response.sendRedirect(authUrl);
		

	}

}
