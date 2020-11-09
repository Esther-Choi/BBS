<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- js 문법 사용 할 수 있도록 printWriter import  -->
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<script
      src="https://kit.fontawesome.com/3087aeb32d.js"
      rossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="css/view.css" />
    <link rel="stylesheet" href="css/update.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&family=Sunflower:wght@300&family=Nanum+Gothic&family=Titillium+Web:wght@200&display=swap"
      rel="stylesheet"
    />
<title>Post</title>
</head>
<body>
<%
String userID = null;
// session에 userID값이 존재 할 경우 userID 변수에 값 담아주기
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
%>
<nav class="navbar">
      <div class="logo">
        <i class="fas fa-link"></i>
        <a class="navbar-menu" href="main.jsp">CONNECT US</a>
      </div>
      <a class="menu" href="bbs.jsp">Main</a>
      <a class="menu" href="bbs.jsp">Community</a>
      <a class="menu" href="bbs.jsp">My Page</a>
    </nav>
    <div class="body">
      <div class="container">
        <div class="row">
          <form method="post" action="writeAction.jsp">
            <table class="table table-striped">
              <thead>
                <tr></tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <input
                      type="text"
                      class="form-control"
                      placeholder="글 제목"
                      name="bbsTitle"
                      maxlength="50"
                    />
                  </td>
                </tr>
                <tr>
                  <td>
                    <textarea
                      class="form-control"
                      placeholder="글 내용"
                      name="bbsContent"
                      maxlength="2048"
                    ></textarea>
                  </td>
                </tr>
              </tbody>
            </table>
            <input type="submit" class="submit" value="글쓰기" />
          </form>
        </div>
      </div>
    </div>
</body>
</html>