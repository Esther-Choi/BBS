<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 만든 BbsDAO 클래스 불러옴 -->
<%@ page import="bbs.BbsDAO"%>

<!-- 자바스크립트 문장 작성을 위해 사용 -->
<%@ page import="java.io.PrintWriter"%>

<!-- 넘어오는 모든 데이터를 utf-8로 받음 -->
<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 자바빈 : 자바 클래스 객체를 jsp에서 사용하기 위해 사용 -->
<!-- useBean : 자바빈 객체 생성(id:자바빈명 class:사용할클래스명 scope:적용범위 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />

<!-- setProperty : 생성된 자바빈 객체에 프로퍼티 값을 저장하기 위해 사용(name: 빈 이름 property: 프로퍼티명-->
<jsp:setProperty name="bbs" property="bbsTitle" />

<!-- 폼(join)에서 넘어온 bbsContent 값 저장 -->
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		/*로그인이 되어있는지 확인*/

	// userID 를 담을 변수 초기화
	String userID = null;

	// session에 userID가 담겨 있을 경우(null이 아닐 경우)
	if (session.getAttribute("userID") != null) {
		// userID 변수에 session에서 가져온 userID 정보를 담는다.
		userID = (String) session.getAttribute("userID");
	}

	// userID가 null일 경우(로그인 되어있지 않은 경우)
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용 가능합니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");

		// 로그인 되어있는 경우
	} else {

		// 만약 입력값을 입력하지 않고 제출했을 경우
		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");

			// 성공적으로 제출 했을 경우
		} else {
			/* BbsDAO 객체 생성 */
			BbsDAO bbsDAO = new BbsDAO();

			/* 입력받은 title, userID, content를 write 메소드에 전달하여 데이터베이스에 게시물 내용 삽입*/
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());

			// 입력한 아이디가 이미 존재할 경우 (-1 = 데이터베이스 오류이기 때문에 primary key인 아이디가 겹칠경우다)
			if (result == -1) {
				// 응답할 js 코드를 출력할 printWriter 객체 생성 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			// 회원 가입에 성공 했을 경우 메인 페이지로
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");

			}
		}
	}

	%>
</body>
</html>