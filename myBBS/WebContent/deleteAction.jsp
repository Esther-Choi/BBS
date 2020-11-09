<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 만든 BbsDAO 클래스 불러옴 -->
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>

<!-- 자바스크립트 문장 작성을 위해 사용 -->
<%@ page import="java.io.PrintWriter"%>

<!-- 넘어오는 모든 데이터를 utf-8로 받음 -->
<%
	request.setCharacterEncoding("UTF-8");
%>

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

	int bbsID = 0;
	// bbsID를 가지고 있을 경우 URL에 파라미터 값으로 넘겨준다.
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	// BbsDAO에서 만든 getBbs 메소드에 해당 게시글의 bbsID를 넘겨주고 게시물 정보를 받아 bbs에 저장한다.
	Bbs bbs = new BbsDAO().getBbs(bbsID);

	// 현재 로그인 된 userID가 게시글 userID와 다르면 수정 불가
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");

	} else {
		/* BbsDAO 객체 생성 */
		BbsDAO bbsDAO = new BbsDAO();

		/* 입력받은 title, userID, content를 write 메소드에 전달하여 데이터베이스에 게시물 내용 삽입*/
		int result = bbsDAO.delete(bbsID);

		if (result == -1) {
			// 응답할 js 코드를 출력할 printWriter 객체 생성 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		// 글 수정에 성공 했을 경우 메인 페이지로
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");

		}
	}
	%>
</body>
</html>