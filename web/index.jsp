<%-- 
    Document   : index
    Created on : 31 Dec, 2014, 12:13:48 PM
    Author     : 6171486
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<link rel="stylesheet" href="css/bootstrap.min.css">
        <LINK rel="stylesheet" type="text/css" href="css/demo.min.css">
        <link href="css/pradan.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="css/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="css/demo.css">
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
        <title>Tender Roster</title>
    </head>
    <body>
        <div align="center" id="page">
            <div id="logo" align="left">
                <div id="logoleft">
                    <img src="images/HPVP_Logo_v1.3.png" height="64">
                </div>
                <div id="logoright" valign="middle">
                    <font class="boldhead">Tender Roster</font>
                </div>
                <div class="clear"></div>
            </div>
            <jsp:useBean id="conn" class="in.bhel.hpvp.Connect" scope="page">
                <%
                    String ip = request.getRemoteAddr();
                    int count = 0;
                    ResultSet rs1 = null;
                    String query = null;
                    try {
                        java.util.Date d1 = new java.util.Date();
                        Statement stmt1 = conn.getStmt();
                        query = "select count(*) from tender_sdc_ip where ip_addr = '" + ip + "'";
                        //out.println(query);
                        rs1 = stmt1.executeQuery(query);
                        rs1.next();
                        count = rs1.getInt(1);
                        //out.println(ip);
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                %>
                <div id="topmenu">
                    <table border="0" width="100%">
                        <tr>
                            <td align="right">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
                <br/>
				<ul class="nav nav-pills nav-stacked">
					<li><a href="generateOTP.jsp">Generate OTP</a></li>
					<%if (count > 0) {%>
					<li><a href="rosterUpdate.jsp">Update Tender Roster</a></li>
					<li><a href="OTPInput.jsp?t=1">Login to Technical bid Mailbox</a></li>
					<li><a href="OTPInput.jsp?t=2">Login to Price bid Mailbox</a></li>
					<%}%>
				</ul>                 
            </jsp:useBean>
        </div>
    </body>
</html>
