<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="blog1.SubscribedUser" %>

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
	<%UserService userService = UserServiceFactory.getUserService();
        if(userService.getCurrentUser() == null){
        	%><p>You must be signed in to perform this action.</p><a class="btn btn-default" href="blog.jsp">Return to home page</a><%
        }else{
        SubscribedUser user = new SubscribedUser(userService.getCurrentUser());
        ObjectifyService.register(SubscribedUser.class);
		ObjectifyService.ofy().delete().type(SubscribedUser.class).id(user.getId()).now();
	%>
	<p>You have cancelled your subscription to our mailing list. You will no longer receive daily email updates about recent blog posts.</p>
    <a class="btn btn-default" href="blog.jsp">Return to home page</a>
    	<%}%>
</body>