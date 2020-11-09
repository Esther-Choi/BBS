<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community</title>
<script
      src="https://kit.fontawesome.com/3087aeb32d.js"
      rossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="css/bbs.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&family=Sunflower:wght@300&family=Nanum+Gothic&family=Titillium+Web:wght@200&display=swap"
      rel="stylesheet"
    />
</head>
<body>
<%
	String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
int pageNumber = 1;
if(request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
%>
<nav class="navbar">
      <div class="logo">
        <i class="fas fa-link"></i>
        <a class="navbar-menu" href="main.jsp">CONNECT US</a>
      </div>
      <a class="menu" href="main.jsp">Main</a>
      <a class="menu" href="bbs.jsp">Community</a>
      <a class="menu" href="mypage.jsp">My Page</a>
    </nav>
    <div class="body">
      <div class="container">
        <div class="row">
          <table class="table">
            <thead>
              <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
              </tr>
            </thead>
            <tbody>
            <%
            	BbsDAO bbsDAO = new BbsDAO();
            ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
            for(int i = 0; i < list.size(); i++){
            	
            %>
            
              <tr>
                <td><%= list.get(i).getBbsID() %></td>
                <!-- 제목은 클릭하면 게시물로 이동하기 위해 view.jsp로 링크 걸어주고 해당 게시물의 bbsID를 파라미터로 전달 -->
                <td><a class="title" href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
                <td><%= list.get(i).getUserID() %></td>
				<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11,13) + ":" + list.get(i).getBbsDate().substring(14,16) %></td>
              </tr>
              <%
            }
              %>
            </tbody>
          </table>
        </div>
        <div class="btns">
          <%
				// 페이지 번호가 1이 아니면, 즉 첫번째 페이지가 아닐 경우 이전 버튼 생성
				if(pageNumber != 1){					
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn prev">이전</a>
			<%
				// nextPage메소드에 현재페이지번호+1 전달 시 true가 리턴되면 다음페이지가 존재한다는 의미이므로 다음 버튼 생성
				}if(bbsDAO.nextPage(pageNumber+1)){	
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn next">다음</a>
			<%
				}			
			%>
          <a href="write.jsp" class="write">글쓰기</a>
        </div>
      </div>
    </div>

</body>
</html>