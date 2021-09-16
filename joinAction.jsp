<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="java.sql.*,java.util.*,java.text.*,java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
<body>
    <%
    String userID=null;
	  
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID!=null){
		PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('이미 로그인되어있습니다.')");
    	script.println("location.href='main.jsp'");    // 이전 페이지로 사용자를 보냄
    	script.println("</script>");
	}
    	if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null
    	|| user.getUserGender()==null || user.getUserEmail()==null){
    		PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력되지 않은 사항이 있습니다.')");
            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
            script.println("</script>");
    	}else{
    		UserDAO userDAO = new UserDAO();
            int result = userDAO.join(user);
    		if (result ==-1){
    			PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 존재하는 ID입니다.')");
                script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                script.println("</script>");
            }
            else {
            	session.setAttribute("userID",user.getUserID());
                //   PrintWriter outter = response.getWriter();
              // 	outter.println("<script>");
               //	outter.println("location.href = 'main.jsp'");//원래 main.jsp였음
                //	outter.println("</script>");
               	  
               	  String uid = request.getParameter("userID");
               	  String password = request.getParameter("userPassword");
               	
               		
               		Connection conn = null;
               		PreparedStatement pstmt = null;
               		String url = "jdbc:mysql://localhost/";
               		String dbName = "jangty0";
               		String driver = "com.mysql.jdbc.Driver";
               		String usename = "jangty0"; 
               		String userPassword = "tyno1123100";
       				
               		  java.util.Date now = new java.util.Date();
               		  String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
               		  SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
               		  
               	    String strDateNew = sdf.format(now) ;


               	    try {
               	      Class.forName(driver).newInstance();
               	      conn = DriverManager.getConnection(url+dbName,usename,userPassword);
               		 
               		  String SQL = "SELECT * FROM USER WHERE userID='"+uid+"'and userPassword='"+password+"'"; 
               		  pstmt = conn.prepareStatement(SQL);
               		//  pstmt.setString(1,uid);
               		//  pstmt.setString(2,password);
               		  ResultSet rs = pstmt.executeQuery(SQL);
               		 
               		   if(rs.next())
               			{
               			   
               				session.setAttribute("userid",uid);
               				session.setAttribute("userName",user.getUserName());
               			    session.setAttribute("intime",strDateNew);

               			    String queryString = "INSERT INTO admin set userid='"+uid+ "', intime= '"+strDateNew+"'";
               			    pstmt = conn.prepareStatement(queryString);
               			 //   pstmt.setString(1,uid);
                     		 //   pstmt.setString(2,strDateNew);
               				int i = pstmt.executeUpdate(queryString);
               				if(i>0)
               				{
               					response.sendRedirect("main.jsp");
               				}

               			}
               	        conn.close();
               	      
               	    } catch (Exception e) {
               	      e.printStackTrace();
             		}
              //  PrintWriter script = response.getWriter();
               // script.println("<script>");
               // script.println("location.href= 'main.jsp'");   // 이전 페이지로 사용자를 보냄
               // script.println("</script>");
            }
    	}
    %>
 
</body>
</html>