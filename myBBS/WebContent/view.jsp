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
          <table class="table">
            <thead>
              <tr></tr>
            </thead>
            <tbody>
              <tr>
                <td style="width: 20%">글 제목</td>
                <!-- XSS 공격 방지를 위해 replaceAll로 html 문자 치환  -->
                <td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
              </tr>
              <tr>
                <td>작성자</td>
                <td colspan="2"><%=bbs.getUserID() %></td>
              </tr>
              <tr>
                <td>작성일자</td>
                <td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11,13) + ":" + bbs.getBbsDate().substring(14,16) %></td>
              </tr>
              <tr>
                <td>내용</td>
                <!-- 내용 출력(.replace로 html 문자 치환 -->
                <td colspan="2">
                  <div class="content">
         <%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          <div class="btns">
            <div>
              <a href="bbs.jsp" class="btn">목록</a>
              
            </div>
            <div>
            <%
					// userID가 null이 아니고 로그인된 userID가 게시물의 userID라면 수정 가능
					if(userID != null && userID.equals(bbs.getUserID())){
				%>
              <a href="update.jsp?bbsID=<%=bbsID %>" class="btn edit">수정</a>
              <!-- 삭제 confirm 함수 기능 사용 -->
              <a
                onclick="return confirm('정말로 삭제하시겠습니까?')"
                href="deleteAction.jsp?bbsID=<%=bbsID %>"
                class="btn delete"
                >삭제</a
              >
              <% 
					}
				%>
            </div>
            <!--수정, 삭제 페이지로 이동, 매개변수로 게시물 bbsID 전달 -->
          </div>
        </div>
      </div>
</body>
</html>