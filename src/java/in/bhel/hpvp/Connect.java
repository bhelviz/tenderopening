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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Connect
{
  Connection conn;
  Statement stmt;
  PreparedStatement pstmt;
  
  public Connect()
    throws ClassNotFoundException, SQLException
  {
    conn = null;
    stmt = null;
    pstmt = null;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    
    conn = DriverManager.getConnection("jdbc:oracle:thin:@10.100.1.238:1521:xe", "csnis", "csnis");
    stmt = conn.createStatement(1004, 1008);
  }
  
  public Statement getStmt()
  {
    return stmt;
  }
  
  public PreparedStatement getPrepStmt(String sSql)
    throws SQLException
  {
    pstmt = conn.prepareStatement(sSql);
    return pstmt;
  }
  
  public void setAutoCommit(boolean b)
    throws SQLException
  {
    conn.setAutoCommit(b);
  }
  
  public void commit()
    throws SQLException
  {
    conn.commit();
  }
  
  public void rollback()
    throws SQLException
  {
    conn.rollback();
  }
  
  public int connectionClose()
    throws SQLException
  {
    conn.close();
    stmt.close();
    return 1;
  }
}