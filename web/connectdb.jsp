
<%@page import="java.sql.*" %>

<%

    Connection connection;
    Statement statement;
    String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root&useUnicode=true&characterEncoding=UTF-8";
    Class.forName("com.mysql.jdbc.Driver");
    connection = DriverManager.getConnection(sourceURL);
    statement = connection.createStatement();
%>