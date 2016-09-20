<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Collections" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="blog1.BlogPost" %>

<%@ page import="blog1.SubscribedUser" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/blog-post.css" rel="stylesheet">
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
            
</head>

 <!-- Page Header -->
    <!-- Set your background image for this header on the line below. -->
    <header class="intro-header" style="background-image: url('img/edit3.jpg')">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="site-heading">
                        <h1>Kevin and Davin's Space</h1>
                        <hr class="small">
                        <span class="subheading">A blog created by nerds for nerds</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

 

<body>
  
<%
 
    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>


<p>Hello, ${fn:escapeXml(user.nickname)} (<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>)
. Feel free to browse the blog posts below, or <a href="createblog.jsp">create a new post.</a></p>
<%
	boolean subscribed = false;
	ObjectifyService.register(SubscribedUser.class);
	List<SubscribedUser> subusrs = ObjectifyService.ofy().load().type(SubscribedUser.class).list();
	for(SubscribedUser subusr: subusrs){
		if(subusr.getId() == user.getUserId()){
			subscribed = true;
		}
	}
	if(!subscribed){
		%><p>Click <a href="/subscribe.jsp">here</a> to receive daily updates on recent blog posts via email!</p>
<%	
	}else{
%>		  <p>You are currently subscribed to our mailing list. Click <a href="/unsubscribe.jsp">here</a> if you wish to stop 
		  	receiving emails.
		  </p>
<%
    }}else{
%>

<p>Hello. Feel free to browse the blog posts below, but you must

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>

to create a new post.</p>

		<%}%>
	<!-- Blog Post Content Column -->
    <div class="blog-container">
	<div class="row"><!--Blog Content Column-->
<%
ObjectifyService.register(BlogPost.class);
List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();
Collections.sort(posts);
if (posts.isEmpty()) {
    %>
    <div class="col-xs-12"><p>No posts here :(</p></div>
    <%
} else {

    for(int i =0; i < posts.size(); i++)
    {
            pageContext.setAttribute("Post_user", posts.get(i).getUser());
            pageContext.setAttribute("Post_date", posts.get(i).getDate());
            pageContext.setAttribute("Post_title",posts.get(i).getTitle());
            pageContext.setAttribute("Post_content",posts.get(i).getContent());
            %>
        <%-- Main Content --%>
        
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <div class="post-preview">
                    
                        <h2 class="post-title">
                            ${fn:escapeXml(Post_title)}
                        </h2>
                      		${fn:escapeXml(Post_content)}
                    </a>
                    <p class="post-meta">Posted by <a href="#">${fn:escapeXml(Post_user)}</a> on ${fn:escapeXml(Post_date)}</p>
                </div>
            
               <%
    }
}
%>
                
                <br>
                <br>
                <!-- Pager -->
                <ul class="pager">
                    <li class="next">
                        <a href="blog.jsp">See Less;</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <hr>


	</div>
	</div>
</body>

</html>

