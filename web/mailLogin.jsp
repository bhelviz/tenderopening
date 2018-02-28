<%-- 
    Document   : email
    Created on : 10 Feb, 2015, 12:33:37 PM
    Author     : 6171486
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="json.js"></script>
        <script>
            function submitForm(type) {
                //alert("here");
                var name;
                if (type === 1) {
                    name = "technicalbid_hyd";
                } else {
                    name = "pricebid_hyd";
                }
                if (window.XMLHttpRequest)
                {
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                xmlhttp.onreadystatechange = function()
                {
                    //alert("here1"+xmlhttp.readyState+xmlhttp.status);
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {   //out.println(xmlhttp.responseText);
                        var jsonArr = JSON.parse(xmlhttp.responseText);
                        //  alert(jsonArr.str[0].passw);
                        document.getElementById("username").value = name;
                        document.getElementById("password").value = jsonArr.str[0].passw;
                        document.loginForm.submit();
                    }
                }
                xmlhttp.open("POST", "getPass.jsp", false);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("username=" + name);

            }
        </script>
    </head>
    <body onload="submitForm(<%=request.getParameter("t")%>)">
        <form method="post" name="loginForm" action="https://mail.bhel.in/" accept-charset="UTF-8">
            <input type="hidden" name="loginOp" value="login"/>

            <table class="form">

                <tr>
                    <td><input id="username" class="zLoginField" name="username" type="hidden" value=""/></td>
                </tr>
                <tr>
                    <td><input id="password" class="zLoginField" name="password" type="hidden" value="" /></td>
                </tr>
                <input type="button" value="submit" onclick="submitForm()" style="display:none;">
            </table>
            <!--            <frameset>
                            <frame width="0">
            
        </frame>
    </frameset>
            -->
        </form>
    </body>
</html>
