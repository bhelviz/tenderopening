<%-- 
    Document   : sendOTP
    Created on : 12 Feb, 2015, 2:50:38 PM
    Author     : 6171486
--%>

<%@page import="java.sql.*, java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:useBean id="con" class="in.bhel.hpvp.Connect" scope="page">
            <jsp:useBean id="sms" class="in.bhel.hpvp.UpdateSMS" scope="page">
                <%
                    //String ipadd = request.getRemoteAddr();
                    //ipadd = "10.5.21.31";
                    //sso.setIPaddr(ipadd);
                    java.util.Date d1 = new java.util.Date();
                    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                    Statement stmt = con.getStmt();
                    //if (sso.checkValidSession()) {
                    //String staffno = sso.getUserId();
                    /*
                     String fin1[] = request.getParameterValues("finuser1");
                     String pur1[] = request.getParameterValues("puruser1");
                     String fin2[] = request.getParameterValues("finuser2");
                     String pur2[] = request.getParameterValues("puruser2");
                     */
                    String query = null;
                    String time[] = request.getParameterValues("bidtime");
                    try {
                        for (int i = 0; i < time.length; i++) {
                            String fin1[] = request.getParameterValues("finuser" + (i + 1));
                            String fin2[] = request.getParameterValues("finuser1" + (i + 1));
                            String pur1[] = request.getParameterValues("puruser" + (i + 1));
                            String pur2[] = request.getParameterValues("puruser1" + (i + 1));
                            //out.println(fin1[0] + fin2[0] + pur1[0] + pur2[0]);
                            if (fin2[0] != null && !fin2[0].equals("") && !fin1[0].equals(fin2[0])) {
                                query = "update tender_emplog set staffno='" + fin1[0] + "' where bidtime=" + time[i] + " and biddate=to_date('" + df.format(d1) + "', 'dd/MM/yyyy') and dept_ind='F'";
                                //out.println(query);
                                stmt.executeUpdate(query);
                                String result = sms.send("noproxy", fin1[0], time[i]);
                                if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy3.bhelhyd.co.in", fin1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy2.bhelhyd.co.in", fin1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy1.bhelhyd.co.in", fin1[0], time[i]);
                                }

                            } else if (fin2[0] == null || fin2[0].equals("")) {
                                query = "insert into tender_emplog values(" + time[i] + ", to_date('" + df.format(d1) + "', 'dd/MM/yyyy'), '" + fin1[0] + "', 'F')";
                                //out.println(query);
                                stmt.execute(query);
                                String result = sms.send("noproxy", fin1[0], time[i]);
                                if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy3.bhelhyd.co.in", fin1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy2.bhelhyd.co.in", fin1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy1.bhelhyd.co.in", fin1[0], time[i]);
                                }
                            }
                            if (pur2[0] != null && !pur2[0].equals("") && !pur1[0].equals(pur2[0])) {
                                query = "update tender_emplog set staffno='" + pur1[0] + "' where bidtime=" + time[i] + " and biddate=to_date('" + df.format(d1) + "', 'dd/MM/yyyy') and dept_ind='P'";
                                //out.println(query);
                                stmt.executeUpdate(query);
                                String result = sms.send("noproxy", pur1[0], time[i]);
                                if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy31.bhelhyd.co.in", pur1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy2.bhelhyd.co.in", pur1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy1.bhelhyd.co.in", pur1[0], time[i]);
                                }
                            } else if (pur2[0] == null || pur2[0].equals("")) {
                                query = "insert into tender_emplog values(" + time[i] + ", to_date('" + df.format(d1) + "', 'dd/MM/yyyy'), '" + pur1[0] + "', 'P')";
                                //out.println(query);
                                stmt.execute(query);
                                String result = sms.send("noproxy", pur1[0], time[i]);
                                if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy3.bhelhyd.co.in", pur1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy2.bhelhyd.co.in", pur1[0], time[i]);
                                } else if (result.contains("HTTP response code: 403") || result.equalsIgnoreCase("ConnExcp")) {
                                    result = "";
                                    result = sms.send("proxy1.bhelhyd.co.in", pur1[0], time[i]);
                                }
                            }
                        }%>
                <script>
                    alert("Details updated successfully.");
                    window.location = "index.jsp";
                </script>
                <%
                } catch (Exception e) {
                    out.println(e.toString());%>
                <script>
                    alert("An error occurred. Please check staff No. and try again.");
                    window.location = "rosterUpdate.jsp";
                </script>
                <%
                    }
                %>
            </jsp:useBean>
        </jsp:useBean>
    </body>
</html>
