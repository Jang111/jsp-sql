package user;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;


import javax.sql.DataSource;
import javax.naming.InitialContext;

 
public class UserDAO {
    
    private Connection conn;          // DB�� �����ϴ� ��ü
   
    private PreparedStatement pstmt;    // 
    private ResultSet rs;                // DB data�� ���� �� �ִ� ��ü  (Ctrl + shift + 'o') -> auto import
    private DataSource dataFactory;
    public UserDAO(){ 
        try {
        	String dbURL = "jdbc:mysql://localhost/jangty0";
            String dbID = "jangty0";
            String dbPassword = "tyno1123100";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals(userPassword))
                    return 1;    // �α��� ����
                else
                    return 0; // ��й�ȣ ����ġ
            }
            return -1; // ID�� ����
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB ����
        
    }
    
    public int join(User user) {
    	String SQL="INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, user.getUserID());
    		pstmt.setString(2, user.getUserPassword());
    		pstmt.setString(3, user.getUserName());
    		pstmt.setString(4, user.getUserGender());
    		pstmt.setString(5, user.getUserEmail());
    		
    		return pstmt.executeUpdate();
    	}catch(Exception e) {
    		e.printStackTrace();
    	}//ȸ������ �Լ�
    	return -1;//������ ���̽� ����
    }
}
