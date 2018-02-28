<%-- 
    Document   : validateOTP
    Created on : 10 Feb, 2015, 11:00:20 AM
    Author     : 6171486
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK rel="stylesheet" type="text/css" href="css/demo.min.css">
        <link href="css/pradan.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="css/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="css/demo.css">
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
        <title>OTP Validate</title>
    </head>
    <body>
        <div align="center" id="page">
            <div id="logo" align="left">
                <div id="logoleft">
                    <img src="images/HPVP_Logo_v1.3.png" height="64">
                </div>
                <div id="logoright">
                    <font class="boldhead">Tender Roster</font>
                </div>
                <div class="clear"></div>
            </div>

            <div id="topmenu">
                <table border="0" width="100%">
                    <tr>
                        <td align="left">

                        </td>
                    </tr>
                </table>
            </div>
        <jsp:useBean class="in.bhel.hpvp.Connect" id="con"> 
            <%try {
                    String finOTP = request.getParameter("finotp");
                    String purOTP = request.getParameter("purotp");
                    Statement stmt = con.getStmt();
                    java.util.Date d1 = new java.util.Date();
                    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                    String time = df.format(d1).substring(11).replace(":", "");
                    //time = "090101";
                    String query = "";
                    query = "select * from tender_bidmaster where OTP_GEN_STARTTIME <= " + time + " AND OTP_GEN_ENDTIME >= " + time;
                    ResultSet rs1 = stmt.executeQuery(query);
                    if (rs1.next()) {
                        //out.println("1");
                        int bidtime = rs1.getInt("BID_TIME");
                        query = "select * from tender_otp a inner join tender_empmaster b on a.gen_by = b.STAFFNO"
                                + " where a.otp=DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => '" + finOTP + "') and a.bid_date=to_date('" + df.format(d1).substring(0, 11)
                                + "', 'dd/MM/yyyy') and a.bid_time=" + bidtime;
                        //out.println(query);
                        ResultSet rs2 = stmt.executeQuery(query);
                        if (rs2.next() && rs2.getString("DEPT_IND").equals("F")) {
                            query = "select * from tender_otp a inner join tender_empmaster b on a.gen_by = b.STAFFNO"
                                    + " where a.otp=DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => '" + purOTP + "') and a.bid_date=to_date('" + df.format(d1).substring(0, 11)
                                    + "', 'dd/MM/yyyy') and a.bid_time=" + bidtime;
                            ResultSet rs3 = stmt.executeQuery(query);
                            //out.println("2");
                            if (rs3.next() && rs3.getString("DEPT_IND").equals("P")) {
            %>
            <script>
                //alert("OTP validated. Redirecting.");
                window.location = "mailLogin.jsp?t=<%=request.getParameter("type")%>";
            </script>
            <%} else {%>
            <script>
                alert("Invalid OTP. Please try again.");
                window.location = "OTPInput.jsp";
            </script>
            <%}
            } else {%>
            <script>
                alert("Invalid OTP. Please try again.");
                window.location = "OTPInput.jsp";
            </script>
            <%}
            } else {%>
            <script>
                alert("Invalid OTP. Please try again.");
                window.location = "OTPInput.jsp";
            </script>
            <%}
                } catch (Exception e) {
                    out.println("Error occurred");
                }%>
        </jsp:useBean>
        </div>
    </body>
</html>
