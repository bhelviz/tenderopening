<%-- 
    Document   : getPass
    Created on : 10 Feb, 2015, 12:39:37 PM
    Author     : 6171486
--%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="text/html" language="java" import="org.json.*" errorPage="" session="true"%>
<jsp:useBean id="validation" class="in.bhel.hpvp.Password" scope="page">

    <%try {
            if (request.getHeader("Referer") != null && request.getHeader("Referer").contains("mailLogin.jsp")) {
                String username = request.getParameter("username");
                JSONArray ja = new JSONArray();
                JSONObject jo = new JSONObject();
                JSONObject mainObj = new JSONObject();
                jo.put("passw", validation.getPassword(username));
                ja.add(jo);
                mainObj.put("str", ja);
                out.print(mainObj);
            }
        } catch (Exception e) {
		out.println(e.toString());
        }
    %>
</jsp:useBean>