<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 만든 UserDAO 클래스 불러옴 -->  
    <%@ page import="user.UserDAO" %>
    
    <!-- 자바스크립트 문장 작성을 위해 사용 -->
    <%@ page import="java.io.PrintWriter" %>
    
    <!-- 넘어오는 모든 데이터를 utf-8로 받음 -->
    <% request.setCharacterEncoding("UTF-8"); %>
    
    <!-- 자바빈 : 자바 클래스 객체를 jsp에서 사용하기 위해 사용 -->
    <!-- useBean : 자바빈 객체 생성(id:자바빈명 class:사용할클래스명 scope:적용범위 -->
    <jsp:useBean id="user" class="user.User" scope="page"/>
    
    <!-- setProperty : 생성된 자바빈 객체에 프로퍼티 값을 저장하기 위해 사용(name: 빈 이름 property: 프로퍼티명-->
    <jsp:setProperty name="user" property="userID"/> <!-- 폼(login)에서 넘어온 userID 값 저장 -->
    <jsp:setProperty name="user" property="userPassword"/> <!-- userPassword 값 저장 -->
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		/*이미 로그인이 되어있는지 확인*/
	
		// userID 를 담을 변수 초기화
		String userID = null;
	
		// session에 userID가 담겨 있을 경우(null이 아닐 경우)
		if(session.getAttribute("userID") != null){
			// userID 변수에 session에서 가져온 userID 정보를 담는다.
			userID = (String) session.getAttribute("userID");
		}
	
		/* userDAO 객체 생성 */
		UserDAO userDAO = new UserDAO();
	
		/* 로그인 페이지에서 입력받은 값을 userDAO 로그임 함수로 넘겨주고 그 결과값을 담는다 */
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		// 로그인 성공 경우
		if (result ==1){
			
			// 로그인과 동시에 세션에 아이디 정보 저장하기
			//session.setAttribute(String name, Object value);
			session.setAttribute("userID", user.getUserID());
			
			// 응답할 js 코드를 출력할 printWriter 객체 생성 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		// 비밀번호 틀릴 경우
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");			
			script.println("</script>");
			
		} 
		// 아이디가 없을 경우 
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");			
			script.println("</script>");
			
		}
		// 데이터베이스 오류일 경우 
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");			
			script.println("</script>");
			
		}
	%>
</body>
</html>