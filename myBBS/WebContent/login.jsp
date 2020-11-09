<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<script
      src="https://kit.fontawesome.com/3087aeb32d.js"
      rossorigin="anonymous"
    ></script>
<link rel="stylesheet" href="css/style.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&family=Secular+One&display=swap"
      rel="stylesheet"
    />
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<section class="signup">
      <form method="post" action="loginAction.jsp">
        <div class="container">
          <h1 class="get-started">Get Started</h1>
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
          <div class="sign-login">
            <a href="join.jsp">SIGN UP</a>
            <input type="submit" class="submit-btn" value="SIGN IN" />
          </div>
        </div>
      </form>
    </section>
    <section class="design">
      <div class="container">
        <h2>WELCOME TO</h2>
        <i class="fas fa-link"></i>
        <h1>CONNECT US</h1>
        <span>The art of communication is the language of leadership.</span>
        <span class="name">BY ESTHER CHOI</span>
      </div>
    </section>
</body>
</html>