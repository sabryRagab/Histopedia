<%-- 
    Document   : test
    Created on : Jun 22, 2016, 6:18:02 AM
    Author     : sabry
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="testServelet" method="get">
            Event id:<br>
            <input type="text" name="event_id"><br>
            title:<br>
            <input type="text" name="title"><br>
            lat:<br>
            <input type="text" name="lat"><br>
            lng:<br>
            <input type="text" name="lng"><br>
            <input type="submit" value="submit">
          
        </form>
    </body>
</html>
