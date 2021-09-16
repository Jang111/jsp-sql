<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/custom.css">
<title>회원 조회(검색)</title>
</head>
<body>
<% 
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
		
	}
	if(userID==null){
		PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이 페이지는 관리자만 접속할 수 있습니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
	}

%>
<%
	if(userID.equals("jangty")||userID.equals("1111")){
%>
	<form method="post" action="member.jsp">
		<input type="submit" value="조회하기">
	</form>
<%
	}else{
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이 페이지는 관리자만 접속할 수 있습니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
	}
%>
</body>
</html>
