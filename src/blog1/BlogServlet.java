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
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//[START simple_includes]
import java.io.IOException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
//[END simple_includes]

//[START multipart_includes]
import java.io.InputStream;
import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import javax.activation.DataHandler;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
//[END multipart_includes]

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class BlogServlet extends HttpServlet {
	static {
        ObjectifyService.register(BlogPost.class);
        ObjectifyService.register(SubscribedUser.class);
    }
	
	/*
	 * Cron job- pull posts from last 24 hrs and send email
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		List<SubscribedUser> subscribed_users = ObjectifyService.ofy().load().type(SubscribedUser.class).list(); //load subscribed users
		List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list(); //load all blog posts
		Collections.sort(posts);
		ListIterator<BlogPost> litr = posts.listIterator();
		boolean lastRecentPostFound = false;
		Date currentDate = new Date();
		List<BlogPost> recent_posts = new ArrayList<BlogPost>();
		while(litr.hasNext() && !lastRecentPostFound){ //find all posts from within last 24 hours
			BlogPost currentPost = litr.next();
			if(currentDate.getTime() - currentPost.date.getTime() > 86400000){ // 24 hours = 86400000
				lastRecentPostFound = true;
			}else{
				recent_posts.add(currentPost);
			}
		}
		
		//form message
		try{
			Multipart mp = new MimeMultipart();
			MimeBodyPart htmlPart = new MimeBodyPart();
			String htmlBody = "Hello subscriber,\nHere is your daily digest of blogs"
							+ " that have been posted within the past 24 hours.\n\n<HR>";
			for(BlogPost blog: recent_posts){
				htmlBody += "<HR><b>" + blog.getTitle() + "</b><i>Posted by " + blog.getUser() + " on" + blog.getDate() + "</i>"
						  + "<p>" + blog.getContent() + "</p>";
			}
		
			htmlPart.setContent(htmlBody, "text/html");
			mp.addBodyPart(htmlPart);
			if(recent_posts.size() > 0){
				for(SubscribedUser usr: subscribed_users){
					sendMail(usr, mp);
				}
			}
		}catch (MessagingException e) {
		      System.out.println("Failed to form message");
		}
	}
	
	private void sendMail(SubscribedUser user, Multipart msg) {
	    Properties props = new Properties();
	    Session session = Session.getDefaultInstance(props, null);

	    try {
	      Message message = new MimeMessage(session);
	      message.setFrom(new InternetAddress("admin@kevindavin-blog.appspotmail.com", "Kevin and Davin bot"));
	      message.addRecipient(Message.RecipientType.TO,
	                       new InternetAddress(user.getUser().getEmail(), "Mr. Subscriber"));
	      message.setSubject("Your Daily Digest of Blogs");
	      message.setContent(msg);

	      Transport.send(message);

	    } catch (AddressException e) {
	      // ...
	    } catch (MessagingException e) {
	      // ...
	    } catch (UnsupportedEncodingException e) {
	      // ...
	    }
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
}
