
package blog1;
import java.util.Date;

import com.google.appengine.api.users.User;

import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;

 

 

@Entity

public class BlogPost implements Comparable<BlogPost> {

    @Id Long id;

    User user;
    
    String title; 
    
    String content;

    Date date;

    @SuppressWarnings("unused")
	private BlogPost() {}

    public BlogPost(User user,  String content) {

        this.user = user;

        this.content = content;
        
        //this.title = title;

        date = new Date();

    }

    public User getUser() {

        return user;

    }

    public String getContent() {

        return content;

    }

    @Override

    public int compareTo(BlogPost other) {

        if (date.after(other.date)) {

            return 1;

        } else if (date.before(other.date)) {

            return -1;

        }

        return 0;

    }

}