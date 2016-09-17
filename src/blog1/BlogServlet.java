package blog1;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;

import blog1.BlogPost;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class BlogServlet extends HttpServlet {
	static {
        ObjectifyService.register(BlogPost.class);
    }
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        String title = req.getParameter("blogtitle");
        String content = req.getParameter("blogcontent");
       
        BlogPost post;

        post = new BlogPost(user, title, content);
 
        ofy().save().entity(post).now();   // synchronous
       
        resp.sendRedirect("/blog.jsp");
    }
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp){
		
	}
}
