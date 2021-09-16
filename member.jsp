<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.util.*"
    import="user.User"
    import="user.UserDAO"
    import="java.sql.*"
    import="java.text.*"
    pageEncoding="UTF-8"%>
<%@ page session = "true" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<style>
h1{
    text-align: center;
}
 
</style>
<meta charset="UTF-8">
<title>회원 정보 조회 페이지</title>
</head>
<body>
<h1>회원 정보 출력</h1>
<table align="center" width="400px" border=0>
  <%
  if(session.getAttribute("userID")!=null && session.getAttribute("userID")!="")
  {
  %>
  <tr>
  <td align="right" width="350"><a href="main.jsp">Main</a></td>
  <td align="right"><a href="logoutAction.jsp">Logout</a></td>
  </tr>
  <%
  }
  else
  {
  %>
  <tr>
  <td align="right" width="350"><a href="main.jsp">Main</a></td>
  <td align="right"><a href="Login.jsp">Login</a></td>
  </tr>
  <%
  }
  %>
</table>
<table width="400px" align="center" border=0> 
  <tr style="background-color:#D9B0D8;">
  <td align="center"><b>ID</b></td>
  <td align="center"><b>UserName</b></td>
  <td align="center"><b>Login</b></td>
  <td align="center"><b>Logout</b></td>
  </tr> 
<%
Connection conn = null;
String url = "jdbc:mysql://localhost/";
String dbName = "jangty0";
String driver = "com.mysql.jdbc.Driver";
String username = "jangty0"; 
String userPassword = "tyno1123100";
String user = "";
try 
{
  Class.forName(driver).newInstance();
  conn = DriverManager.getConnection(url+dbName,username,userPassword);
  Statement st = conn.createStatement();
  Statement st1 = conn.createStatement();
  String queryString = "select * from admin order by userid";
  ResultSet rs = st.executeQuery(queryString);
  ResultSet rs1=null;
  String queryStringuser="";
  SimpleDateFormat sdfDestination=null;
  int count=0;
  String strcolor = "";
  while(rs.next())
  {

  count = count%2;
  if(count==0)
  {
  strcolor = "#D9D9D9";
  }
  else
 {
  strcolor = "#EFEFEF";
  }
  count++;
  queryStringuser = "select * from USER where userID= '"+rs.getString(2)+"'";
  rs1 = st1.executeQuery(queryStringuser);
  while(rs1.next())
  {
  user  = rs1.getString(3);
  }
 String inStr="";
  String outStr="";
  java.util.Date date;
  String intime="";
  String outtime="";
  if((rs.getString(3)!=null && rs.getString(3)!=""))
  {
  inStr = rs.getString(3).toString().substring(0,rs.getString(3).toString().indexOf("."));
  try
 {
 date = new  SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(inStr);
  sdfDestination = new SimpleDateFormat("MMM dd, hh:mm:ss");
  intime = sdfDestination.format(date);
  }
  catch (Exception e)
  {
  e.getMessage();
  }
  }

  if((rs.getString(4)!=null && rs.getString(4)!=""))
  {
  outStr = rs.getString(4).toString().substring(0,rs.getString(3).toString().indexOf("."));
  try
  {
  date = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(outStr);
  sdfDestination = new SimpleDateFormat("MMM dd, HH:mm:ss");
  outtime = sdfDestination.format(date);
  }
  catch (Exception e)
  {
  e.getMessage();
  }
  }
  %>
  <tr style="background-color:<%=strcolor%>;">
   <td align="center"><%=rs.getString(2)%></td>
   <td align="left" style="padding-left:10px;"><%=user%></td>
   <td align="center"><%=intime%></td><td align="center"><%=outtime%></td>
   </tr>
  <%
  }
  conn.close();
} 
catch (Exception e)
{
  e.printStackTrace();
}
%> 

</body>
</html>
