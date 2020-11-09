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
int bbsID = 0;
// bbsID를 가지고 있을 경우 URL에 파라미터 값으로 넘겨준다.
if(request.getParameter("bbsID") != null){
	bbsID = Integer.parseInt(request.getParameter("bbsID"));
}
if(bbsID ==0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
}
// Bbs 타입의 bbs 생성과 동시에 바로 getBbs로 bbsID를 전달해 리턴된 하나의 bbs 게시글 정보를 담는다
Bbs bbs = new BbsDAO().getBbs(bbsID); 
//현재 로그인 된 userID가 게시글 userID와 다르면 수정 불가
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
		
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
          <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
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
                      value="<%= bbs.getBbsTitle() %>"
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

                    ><%= bbs.getBbsContent() %></textarea>
                  </td>
                </tr>
              </tbody>
            </table>
            <input type="submit" class="submit" value="글수정" />
          </form>
        </div>
      </div>
    </div>
</body>
</html>