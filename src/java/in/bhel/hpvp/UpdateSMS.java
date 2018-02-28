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
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;

public class UpdateSMS
{
  Connection con;
  ResultSet rs;
  Statement stmt;
  String url;
  private java.io.InputStream is;
  
  public UpdateSMS()
  {
    con = null;
    rs = null;
    stmt = null;
    url = null;
  }
  
  public String send(String server, String staffno, String bidtime)
  {
    try
    {
      Class.forName("oracle.jdbc.driver.OracleDriver");
      
      con = java.sql.DriverManager.getConnection("db URL", "username", "password");
      stmt = con.createStatement();
      stmt.setQueryTimeout(240);
      Statement stmt2 = con.createStatement();
      stmt2.setQueryTimeout(20);
      rs = stmt.executeQuery("select * from tender_empmaster where staffno=" + staffno);
      if (rs.next())
      {
        String number = rs.getString(4);
        String email = rs.getString(3);
        Date d1 = new Date();
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String time = df.format(d1).substring(11).replace(":", "");
        String query = "update tender_otp set gen_time = '" + time + "', otp='' where bid_date=to_date('" + df.format(d1).substring(0, 11) + "', 'dd/MM/yyyy') and gen_by='" + staffno + "' and bid_time=" + bidtime;
        if (stmt2.executeUpdate(query) == 0)
          stmt.execute(query);
        ResultSet rs1 = stmt.executeQuery("select * from tender_bidmaster where OTP_GEN_STARTTIME <= " + time + " AND OTP_GEN_ENDTIME >= " + time);
        String msg1 = "Sir/Madam,%20You%20are%20on%20tender%20roster%20duty%20today.%20Kindly%20be%20available%20at%20SDC%20at%20" + bidtime.substring(0, 2) + ":" + bidtime.substring(2, 4) + "hrs";
        



        Properties props = new Properties();
        props.put("mail.smtp.host", "mail.bhel.in");
        Session session1 = Session.getDefaultInstance(props, null);
        Message msg = new javax.mail.internet.MimeMessage(session1);
        
        InternetAddress addressFrom = new InternetAddress("tendadmin@bhel.in");
        msg.setFrom(addressFrom);
        InternetAddress[] addressTo = new InternetAddress[1];
        addressTo[0] = new InternetAddress(email);
        msg.setRecipients(javax.mail.Message.RecipientType.TO, addressTo);
        msg1 = "Sir/Madam, <br/>You are on tender roster duty today. Kindly be available at SDC at " + bidtime.substring(0, 2) + ":" + bidtime.substring(2, 4) + "hrs" + ". For any clarifications please contact SDC.<br/><br/>P.S.: This is a system generated mail. Please do not reply.";
        msg.setSubject("Tender Roster Duty");
        msg.setContent(msg1, "text/html");
        javax.mail.Transport.send(msg);
        return "Success";
      }
    }
    catch (Exception e)
    {
      return e.toString();
    }
    return "final";
  }
}