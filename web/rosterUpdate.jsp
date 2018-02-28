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
            <jsp:useBean class="in.bhel.hpvp.Connect" id="con">
                <jsp:useBean id="conn" class="in.bhel.hpvp.Connect" scope="page">
                    <%String ip = request.getRemoteAddr();
                        //ip = "10.5.21.31";
                        int count = 0, ctr = 0;
                        boolean flag = false;
                        ResultSet rs = null;
                        String query = null;
                        try {
                            java.util.Date d1 = new java.util.Date();
                            Statement stmt1 = conn.getStmt();
							/*********** Application is allowed to be open from specified PCs only *****************/
                            query = "select count(*) from tender_sdc_ip where ip_addr = '" + ip + "'";
                            //out.println(query);
                            rs = stmt1.executeQuery(query);
                            rs.next();
                            count = rs.getInt(1);
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                        if (count > 0) {
                            Statement stmt = conn.getStmt();
                            query = "select * from tender_bidmaster";
                            ResultSet rs1 = stmt.executeQuery(query);
                            java.util.Date d1 = new java.util.Date();

                            SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                            out.println("Tender Roster update for " + df.format(d1));
                    %>
                    <jsp:useBean id="conn1" class="in.bhel.hpvp.Connect" scope="page">

                        <form name="otp" action="saveRoster.jsp" method="post">
                            <table class="dataTable">
                                <tr><td class="dataTableBorder">Bid Time</td>
                                    <td class="dataTableBorder">Finance Staff No.</td>
                                    <td class="dataTableBorder">Purchase Staff No.</td>
                                </tr>
                                <%while (rs1.next()) {%>
                                <%
                                    flag = false;
                                    ctr++;
                                    Statement stmt2 = conn1.getStmt();
                                    query = "select * from tender_emplog where bidtime = '" + rs1.getString("BID_TIME") + "' and biddate = to_date('" + df.format(d1) + "', 'dd/MM/yyyy') order by dept_ind";
                                    //out.println(query);
                                    ResultSet rs2 = stmt2.executeQuery(query);
                                %>
                                <tr class="dataTableBorder">
                                    <td class="dataTableBorder"><input type="hidden" name="bidtime" value="<%=rs1.getString("BID_TIME")%>"/><%=rs1.getString("BID_TIME").substring(0, 2) + ":" + rs1.getString("BID_TIME").substring(2, 4) + " Hrs"%></td>
                                    <td class="dataTableBorder">
                                        <%
                                            if (rs2.next()) {
                                                flag = true;
                                                if (rs2.getString("dept_ind").equals("F")) {
                                                    flag = false;
                                        %>
                                        <input type="text" name="finuser<%=ctr%>" size="7" maxlength="7" value="<%=rs2.getString("staffno")%>"/>
                                        <input type="hidden" name="finuser1<%=ctr%>" value="<%=rs2.getString("staffno")%>" /><br/>
                                        <%
                                        } else {%>
                                        <input type="text" name="finuser<%=ctr%>" size="7" maxlength="7" />
                                        <input type="hidden" name="finuser1<%=ctr%>" /><br/>
                                        <%}
                                        } else {%>
                                        <input type="text" name="finuser<%=ctr%>" size="7" maxlength="7" />
                                        <input type="hidden" name="finuser1<%=ctr%>" /><br/>
                                        <%}%>
                                    </td>
                                    <td class="dataTableBorder">
                                        <%
                                            if (flag || rs2.next()) {
                                        %>
                                        <input name="puruser<%=ctr%>" type="text" size="7" maxlength="7" value="<%=rs2.getString("staffno")%>"/>
                                        <input name="puruser1<%=ctr%>" type="hidden" value="<%=rs2.getString("staffno")%>"/><br/>
                                        <%
                                        } else {%>
                                        <input name="puruser<%=ctr%>" type="text" size="7" maxlength="7" />
                                        <input name="puruser1<%=ctr%>" type="hidden"/>
                                        <%}%>
                                    </td>
                                </tr>
                                <%}%>
                                <tr><td colspan="3" style="text-align: center; padding: 5px;"><input type="button" onclick="submit()" value="Submit"/></td></tr>
                            </table>
                        </form>
                    </jsp:useBean>
                    <%
                        } else {
                            out.println("You are not authorised to view this page.");
                        }
                    %>
                </jsp:useBean>            
            </jsp:useBean>
        </div>
        <%
            } catch (Exception e) {
                out.println("error" + e.toString());
            }%>
    </body>
</html>
