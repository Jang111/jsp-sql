<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.text.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>다원 교육</title>
</head>
<body>
   <%

String userid=(String)session.getAttribute("userid");
String intime = (String)session.getAttribute("intime");
String url = "jdbc:mysql://localhost/";
String dbName = "jangty0";
String driver = "com.mysql.jdbc.Driver";
String username = "jangty0"; 
String userPassword = "tyno1123100";
Connection conn = null;

java.util.Date now = new java.util.Date();
String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
String strDateNew = sdf.format(now) ;
try
{
	Class.forName(driver).newInstance();
	conn = DriverManager.getConnection(url+dbName,username,userPassword);
	Statement st = conn.createStatement();
	String queryString = "UPDATE admin SET outtime='"+strDateNew+"'  where userid= '"+userid+"' and intime= '"+intime+"'";
	out.println(queryString);
	int i = st.executeUpdate(queryString);

	session.invalidate();
	response.sendRedirect("main.jsp");
	
	
	conn.close();
}
catch (Exception e)
{
	e.printStackTrace();
}
%> 
</body>
</html>