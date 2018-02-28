<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
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
        <%try {%>
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
            <br/><br/>
            <jsp:useBean id="conn" class="in.bhel.hpvp.Connect" scope="page">
                <%
                    String ip = request.getRemoteAddr();
                    int count = 0;
                    ResultSet rs1 = null;
                    String query = null;
                    try {
                        java.util.Date d1 = new java.util.Date();
                        Statement stmt1 = conn.getStmt();
						/*********** Application is allowed to be open from specified PCs only *****************/
                        query = "select count(*) from tender_sdc_ip where ip_addr = '" + ip + "'";
                        //out.println(query);
                        rs1 = stmt1.executeQuery(query);
                        rs1.next();
                        count = rs1.getInt(1);
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                    if (count > 0) {%>
                <form name="otp" action="validateOTP.jsp" method="post">
                    <table>
                        <tr><td style="padding: 2px;">Finance User OTP: </td><td style="padding: 2px;"><input name="finotp" type="password" size="6" maxlength="6" /></td></tr>
                        <tr><td style="padding: 2px;">Purchase User OTP: </td><td style="padding: 2px;"><input name="purotp" type="password" size="6" maxlength="6" /></td></tr>
                        <tr><td><input type="hidden" name="type" value="<%=request.getParameter("t")%>" /></td></tr>
                        <tr><td colspan="2" style="text-align: center; padding: 5px;"><input type="button" onclick="submit()" value="Submit"/></td></tr>
                    </table>
                </form>
                <%} else {
                        out.println("You are not authorised to view this page.");
                    }%>
            </jsp:useBean>
        </div>
        <%} catch (Exception e) {
            out.println();
        %><script>
            alert("An error occurred. Redirecting.");
            window.location = "index.jsp";
        </script>
        <%
                }%>
    </body>
</html>
