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
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;

public class Execute
{
  java.sql.Connection con;
  ResultSet rs;
  Statement stmt;
  String url;
  private java.io.InputStream is;
  
  public Execute()
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
      
      con = java.sql.DriverManager.getConnection("jdbc:oracle:thin:@10.100.1.238:1521:xe", "csnis", "csnis");
      
      stmt = con.createStatement();
      stmt.setQueryTimeout(240);
      Statement stmt2 = con.createStatement();
      stmt2.setQueryTimeout(20);
      rs = stmt.executeQuery("select * from tender_empmaster where staffno=" + staffno);
      java.util.Random randomGenerator = new java.util.Random();
      int OTP = randomGenerator.nextInt(1000000);
      String password = String.format("%06d", new Object[] {
        Integer.valueOf(OTP) });
      
      if (rs.next())
      {
        String number = rs.getString(4);
        String email = rs.getString(3);
        email = email.replace("bhelhyd.co.in", "bhel.in");
        email = email.replace("BHELHYD.CO.IN", "BHEL.IN");
        java.util.Date d1 = new java.util.Date();
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String time = df.format(d1).substring(11).replace(":", "");
        String query = "update tender_otp set gen_time = '" + time + "', otp=DBMS_OBFUSCATION_TOOLKIT.MD5(input_string =>'" + password + "') where bid_date=to_date('" + df.format(d1).substring(0, 11) + "', 'dd/MM/yyyy') and gen_by='" + staffno + "' and bid_time=" + bidtime;
        if (stmt2.executeUpdate(query) == 0)
        {
          query = "insert into tender_otp values (to_date('" + df.format(d1).substring(0, 11) + "', 'dd/MM/yyyy'), " + bidtime + ", '" + staffno + "', " + time + ", DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => '" + OTP + "'))";
          stmt.execute(query);
        }
        ResultSet rs1 = stmt.executeQuery("select * from tender_bidmaster where OTP_GEN_STARTTIME <= " + time + " AND OTP_GEN_ENDTIME >= " + time);
        String msg1 = "Your%20OTP%20to%20access%20tender%20mailbox%20on%20" + df.format(d1).substring(0, 10) + "%20at%20" + bidtime.substring(0, 2) + ":" + bidtime.substring(2, 4) + "%20hrs%20is:%20" + password;
        


        boolean debug = false;
        
        Properties props = System.getProperties();
        int smtpPort = 25;
        props.put("mail.smtp.host", "10.5.5.76");
        props.put("mail.smtp.port", "" + smtpPort);
        props.put("mail.smtp.auth", "false");
        javax.mail.Session session1 = javax.mail.Session.getInstance(props);
        session1.setDebug(debug);
        Message msg = new javax.mail.internet.MimeMessage(session1);
        InternetAddress addressFrom = new InternetAddress("tender_admin@bhel.in");
        InternetAddress[] addressTo = new InternetAddress[1];
        addressTo[0] = new InternetAddress(email);
        msg.setFrom(addressFrom);
        msg.addRecipient(javax.mail.Message.RecipientType.TO, addressTo[0]);
        msg.setSubject("Mailbox access OTP");
        MimeMultipart multipart = new MimeMultipart("related");
        javax.mail.BodyPart messageBodyPart = new javax.mail.internet.MimeBodyPart();
        msg1 = "Your OTP to access tender mailbox on " + df.format(d1).substring(0, 10) + " at " + time.substring(0, 2) + ":" + time.substring(2, 4) + " hrs is: " + password;
        messageBodyPart.setContent(msg1, "text/html");
        multipart.addBodyPart(messageBodyPart);
        msg.setContent(multipart);
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