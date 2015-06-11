package connessione;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jgrapht.Graph;
import org.jgrapht.VertexFactory;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.auth.RequestToken;

public class Callback extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public Callback() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		out.println("Ciao CallBack");
		
		String pin = request.getParameter("oauth_verifier");
		RequestToken requestToken = (RequestToken) request.getSession().getAttribute("requestToken");
		Twitter twitter = (Twitter)request.getSession().getAttribute("twitter");
		
		request.getSession().setAttribute("verifier", pin);
		
		twitter4j.auth.AccessToken accessToken  = null;
		try {
			
			accessToken = twitter.getOAuthAccessToken(requestToken, pin);
			twitter.setOAuthAccessToken(accessToken);
			
			
		} catch (TwitterException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		request.setAttribute("twitter", twitter);

		
		long id = accessToken.getUserId();
		try {
			request.getSession().setAttribute("user", twitter.showUser(accessToken.getUserId()));
			response.sendRedirect("pagine/userinfo.jsp");
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			response.sendRedirect("pagine/error.jsp");
			e.printStackTrace();
		}

		
		
	}

}
