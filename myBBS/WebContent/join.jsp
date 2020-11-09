<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<script
      src="https://kit.fontawesome.com/3087aeb32d.js"
      rossorigin="anonymous"
    ></script>
<link rel="stylesheet" href="css/join.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&family=Secular+One&display=swap"
      rel="stylesheet"
    />
<title>CONNECT US</title>
</head>
<body>
<%
	String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
%>
	
    <section class="signup">
        <form method="post" action="joinAction.jsp">
          <div class="container">
            <div class="icon">
              <i class="far fa-user"></i>
              <input
                type="text"
                class="login-input"
                placeholder="Username"
                name="userID"
              />
            </div>
            <hr align="left" />
            <div class="icon">
              <i class="fas fa-unlock-alt"></i>
              <input
                type="text"
                class="login-input"
                placeholder="Password"
                name="userPassword"
              />
            </div>
            <hr align="left" />
            <div class="gender">
                <div class="btn-group" data-toggle="buttons">
                    <label>
                        <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
                    </label>
                    <label class="btn btn-primary cative">
                        <input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
                    </label>
                </div>
            </div>
            <div class="icon">
                <i class="fas fa-signature"></i>
                <input
                type="text"
                class="login-input"
                placeholder="Nickname"
                name="userName"
              />
            </div>
            <hr align="left" />
            <div class="icon">
                <i class="far fa-envelope"></i>
                <input
                type="text"
                class="login-input"
                placeholder="Email"
                name="userEmail"
              />
            </div>
            <hr align="left" />
            <div class="sign-login">
              <input type="submit" class="submit-btn" value="SIGN UP" />
            </div>
          </div>
        </form>
      </section>
</body>
</html>