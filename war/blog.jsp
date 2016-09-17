<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Collections" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="blog1.BlogPost" %>

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

 

<body>
	<!-- Title -->
    <h1>461L Blog - Official blog for members of the Fall 2016 EE461L community</h1>

    <!-- Author -->
    <p class="lead">
    by Kevin Yee and Davin Siu
    </p>

    <!-- Blog Page Image -->
    <p style="text-align:center;"><img src="JAVA_C_CPP.jpg"></p>
    <hr size="6">     
<%
 
    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>


<p>Hello, ${fn:escapeXml(user.nickname)} (<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>)
. Feel free to browse the blog posts below, or <a href="createblog.jsp">create a new post.</a></p>

<%

    } else {

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

    for (BlogPost Post : posts) {
            pageContext.setAttribute("Post_user", Post.getUser());
            pageContext.setAttribute("Post_date", Post.getDate());
            pageContext.setAttribute("Post_title", Post.getTitle());
            pageContext.setAttribute("Post_content", Post.getContent());
            %>
        	<div class="col-xs-12">
        		<h1>${fn:escapeXml(Post_title)}</h1>
        	</div>
        	<div class="col-xs-4">
        		<h4>${fn:escapeXml(Post_user.nickname)}</h4>
        	</div>
        	<div class="col-xs-4 col-xs-offset-4">
        		<h4>${fn:escapeXml(Post_date)}</h4>
        	</div>
        	<div class="col-xs-12">
        		<h2>${fn:escapeXml(Post_content)}</h2>
        	</div>
        <%
    }
}
%>
	</div>
	</div>
</body>

</html>

