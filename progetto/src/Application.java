

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationBuilder;


public class Application extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	private final String CONSUMER_KEY = "lcG8Dlc7n21QShe0PQPD1zhbV";
	private final String CONSUMER_SECRET = "BDiIjRmul86mXaGRPnw4utmU2rHnXPoQCHqbuKqmKnteMd0Kad";
	private final String ACCESS_TOKEN = "1070757523-UCAx3sNj2Ltpy89LMkkzAz0Man5T6bBsRRAbjBG";
	private final String ACCESS_TOKEN_SECRET = "ydLwPkZbF5RqNssmr9GsbTCGEPKJx3wKdLcf8KMiQdfq0";
    
	

	
    public Application() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		
		StringBuffer callbackSB = request.getRequestURL();
		String callback = callbackSB.toString();
 
		callback = callback.substring(0, callback.lastIndexOf('/'));
		callback = callback + "/pagine/ricercautente.jsp";
		
		ConfigurationBuilder builder = new ConfigurationBuilder();
		builder.setOAuthConsumerKey(CONSUMER_KEY);
		builder.setOAuthConsumerSecret(CONSUMER_SECRET);
		builder.setOAuthAccessToken(ACCESS_TOKEN);
		builder.setOAuthAccessTokenSecret(ACCESS_TOKEN_SECRET);
		
		
		Configuration conf = builder.build();
		
		TwitterFactory fact = new TwitterFactory(conf);
		
		Twitter twit = fact.getInstance();
		
		String userSearch = request.getParameter("userSearch");
		
		List<User> userResult = null;
		try {
			userResult = twit.searchUsers(userSearch, 2);
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("twitter", twit);
		request.getSession().setAttribute("userResult", userResult);
		
		response.sendRedirect(callback);
		
		
		
	}

}
