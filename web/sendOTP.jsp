<%-- 
    Document   : sendOTP
    Created on : 12 Feb, 2015, 2:50:38 PM
    Author     : 6171486
--%>

<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
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
        <title>SEND OTP</title>
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
        <%
            if (request.getHeader("Referer").contains("generateOTP.jsp")) {%>
        <jsp:useBean id="ex" class="in.bhel.hpvp.Execute" scope="page">
            <jsp:useBean id="sso" class="in.bhel.hpvp.SSOSession" scope="page">
                <%
                    String ipadd = request.getRemoteAddr();
                    sso.setIPaddr(ipadd);
                    String result = null;

                    if (sso.checkValidSession()) {
                        String staffno = sso.getUserId();
                        try {

                            result = ex.send("noproxy", sso.getUserId(), request.getParameter("bidtime"));
                            if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                result = "";
                                result = ex.send("proxy3.bhelhyd.co.in", sso.getUserId(), request.getParameter("bidtime"));
                            } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                result = "";
                                result = ex.send("proxy2.bhelhyd.co.in", sso.getUserId(), request.getParameter("bidtime"));
                            } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                result = "";
                                result = ex.send("proxy1.bhelhyd.co.in", sso.getUserId(), request.getParameter("bidtime"));
                            }
                            
                            if (result.equals("Success")) {
                %>

                    <h3>OTP sent to your registered email ID.</h3>
                    <a href="index.jsp"> Back </a>
                <%} else {%>
                    Error sending OTP.<%=result%>
                    <a href="index.jsp"> Back </a>

                <%}
                    } catch (Exception e) {
                        out.println("Error");
                    }
                } else {%>
                <script>
					/**************************** Redirect to single signon for login **************************/
                    window.location = "http://intranet.bhelhyd.co.in/CENLOG/index.jsp?redirUrl=<%=request.getRequestURL().toString()%>";
                </script>
                <%
                    }
                %>
            </jsp:useBean>    
        </jsp:useBean>
        <%} else {%>
        <script>
            window.location = "generateOTP.jsp"
        </script>        
        <%}%>
         </div>
    </body>
</html>
