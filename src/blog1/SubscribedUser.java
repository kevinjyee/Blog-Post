package blog1;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity

public class SubscribedUser {
	@Id String id;
	User user;
	
	@SuppressWarnings("unused")
	private SubscribedUser(){}
	
	public SubscribedUser(User user){
		this.user = user;
		this.id = user.getUserId();
	}
	
	public String getId(){
		return this.id;
	}
	
	public User getUser(){
		return this.user;
	}
}