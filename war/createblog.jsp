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



   

    <!-- Custom CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

  
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>


</head>

                <h1>Create a new Blog Post</h1>
                
  <form action="/sign" method="post">
  	<div class="form-group">
    	<label for="blogtitle">Title</label>
    	<input type="text" class="form-control" name="blogtitle" placeholder="Enter title">
  	</div>
  	
    	<label for="blogcontent">Content</label>
    	<textarea class="form-control" rows="20" name="blogcontent" placeholder="Enter blog content here"></textarea>
  		
  	<button type="submit" class="btn btn-default">Submit Post</button>
  	<a class="btn btn-default" href="blog.jsp">Cancel</a>
  </form>
 