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
            <jsp:useBean id="sso" class="in.bhel.hpvp.SSOSession" scope="page">
                <%
                    String ipadd = request.getRemoteHost();
                    String temp = "";
                    sso.setIPaddr(ipadd);
                    //out.println(request.getHeader("Referer"));
                    %>
            <%
                    if (sso.checkValidSession()) {
                        String staffno = sso.getUserId();

                %>
                <jsp:useBean id="conn" class="in.bhel.hpvp.Connect" scope="page">
                    <%  
                        Statement stmt1 = conn.getStmt();
                        ResultSet rs1 = null, rs2 = null, rs3 = null;
                        String query = null;
                        try {
                            java.util.Date d1 = new java.util.Date();
                            SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            String time = df.format(d1).substring(11).replace(":", "");
                            //time = "090101";
                            stmt1 = conn.getStmt();
                            query = "select * from tender_bidmaster where OTP_GEN_STARTTIME <= " + time + " AND OTP_GEN_ENDTIME >= " + time;
                            //out.println(query);
                            rs1 = stmt1.executeQuery(query);
                            if (rs1.next()) {
                                String bidtime = rs1.getString(2);
                                query = "select * from TENDER_EMPLOG where STAFFNO = '" + staffno + "' and biddate = to_date('" + df.format(d1).substring(0, 10) + "', 'dd/MM/yyyy') and bidtime=" + bidtime;
                                //out.println(query);
                                rs2 = stmt1.executeQuery(query);
                                if (rs2.next()) {
                                    query = "select BID_DATE, BID_TIME, GEN_BY from tender_otp where bid_time = " + bidtime + " and bid_date = to_date('" + df.format(d1).substring(0, 10) + "', 'dd/MM/yyyy') and gen_by = '" + staffno + "'";
                                    //out.println(query);
                                    rs3 = stmt1.executeQuery(query);
                                    //out.println("123");
                                    if (rs3.next()) {
                                        out.println("You have already generated OTP. You can regenerate OTP.");
                    %>
                    <form name="frm1" action="sendOTP.jsp" method="post">
                        <br/>
                        <table style="border: 1px solid #D3D3D3; padding-top: 10px; padding-bottom: 10px; padding-left: 30px; padding-right: 30px;">
                            <tr style="padding-top: 20px;">
                                <td style="padding: 2px;" colspan="2" ><input type="submit" value="Re-Generate OTP"/>
                                    <input type="hidden" value="<%=bidtime%>" name="bidtime"/><input name="mode" id="mode" type="hidden" /></td>
                            </tr>
                        </table>
                    </form>
                    <%
                    } else {
                    %>
                    <form name="frm1" action="sendOTP.jsp" method="post">
                        <br/>
                        <table style="border: 1px solid #D3D3D3; padding-top: 10px; padding-bottom: 10px; padding-left: 30px; padding-right: 30px;">
                            <tr style="padding-top: 20px;">
                                <td style="padding: 2px;" colspan="2" ><input type="submit" value="Generate OTP"/>
                                    <input type="hidden" value="<%=bidtime%>" name="bidtime"/><input name="mode" id="mode" type="hidden" /></td>
                            </tr>
                        </table>
                    </form>
                    <%
                                    }
                                } else {
                                    out.println("You are not on Tender roster for next tender opening");
                                }
                            } else {
                                out.println("OTP cannot be generated now.");
                            }
                        } catch (Exception e) {
                            out.println(e);
                        }
                    %>
                </jsp:useBean>
                <%} else {
                %>
                <script>
                    window.location = "http://10.100.1.45/sson/index.jsp?redirurl=<%=request.getRequestURL().toString()%>";
                </script>
                <%
                    }%>
            </jsp:useBean>
        </div>
        <%} catch (Exception e) {
            out.println(e);
        %>
        <%
            }%>
    </body>
</html>
