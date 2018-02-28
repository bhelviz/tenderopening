/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package in.bhel.hpvp;

/**
 *
 * @author 6207537
 */
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;








public class SSOSession
{
  public SSOSession() {}
  
  public void setIPaddr(String ipaddr)
    throws ClassNotFoundException, SQLException
  {
    Connection conn_central_login = null;
    Statement stmt_central_login = null;
    ResultSet rs_central_login = null;
    
    Class.forName("com.mysql.jdbc.Driver");
    



    conn_central_login = DriverManager.getConnection("jdbc:mysql://10.100.1.45:3306/hpvp1", "csnis", "csnis");
    stmt_central_login = conn_central_login.createStatement(1004, 1008);
    rs_central_login = stmt_central_login.executeQuery("SELECT a.STAFFNO,b.NAME from SSON_LOGON_DATA a left outer join TELEDIR b on a.STAFFNO = b.STAFFNO where a.LOGON_IP = '" + ipaddr + "'" + " and a.LOGON_TIME < NOW() and a.LOGOUT_TIME > NOW()" + " and IFNULL(a.LOGOUT_FLAG,'-') = '-'");
    System.out.println("SELECT a.STAFFNO,b.NAME from SSON_LOGON_DATA a left outer join TELEDIR b on a.STAFFNO = b.STAFFNO where a.LOGON_IP = '" + ipaddr + "'" + " and a.LOGON_TIME < NOW() and a.LOGOUT_TIME > NOW()" + " and IFNULL(a.LOGOUT_FLAG,'-') = '-'");
    System.out.println(ipaddr);
    if (rs_central_login.next())
    {
      returnString[0] = "Y";
      returnString[1] = rs_central_login.getString("STAFFNO");
      returnString[2] = rs_central_login.getString("NAME");
    }
    if (rs_central_login != null) {
      try
      {
        rs_central_login.close();
      }
      catch (SQLException localSQLException) {}
    }
    if (stmt_central_login != null) {
      try
      {
        stmt_central_login.close();
      }
      catch (SQLException localSQLException1) {}
    }
    if (conn_central_login != null) {
      try
      {
        conn_central_login.close();
      }
      catch (SQLException localSQLException2) {}
    }
    if (rs_central_login != null) {
      try
      {
        rs_central_login.close();
      }
      catch (SQLException localSQLException3) {}
    }
    if (stmt_central_login != null) {
      try
      {
        stmt_central_login.close();
      }
      catch (SQLException localSQLException4) {}
    }
    if (conn_central_login != null) {
      try
      {
        conn_central_login.close();
      }
      catch (SQLException localSQLException5) {}
    }
    
    if (rs_central_login != null) {
      try
      {
        rs_central_login.close();
      } catch (SQLException localSQLException6) {}
    }
    if (stmt_central_login != null) {
      try
      {
        stmt_central_login.close();
      } catch (SQLException localSQLException7) {}
    }
    if (conn_central_login != null) {
      try
      {
        conn_central_login.close();
      }
      catch (SQLException localSQLException8) {}
    }
  }
  

  public boolean checkValidSession()
  {
    return returnString[0].equals("Y");
  }
  
  public String getUserId()
  {
    return returnString[1];
  }
  
  public String getUserName()
  {
    return returnString[2];
  }
  
  private String[] returnString = { "N", "", "" };
}