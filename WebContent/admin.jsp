<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>
</head>
<body style="background-color: teal;">

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp"%>

<%
    String userName = (String) session.getAttribute("authenticatedUser");

%>


<%
    // TODO: Write SQL query that prints out total order amount by day
    try{
        getConnection();
        String sql = "SELECT FORMAT(orderDate,'yyyy-MM-dd') as date, SUM(totalAmount) AS total FROM ordersummary GROUP BY FORMAT(orderDate,'yyyy-MM-dd') ORDER BY FORMAT(orderDate,'yyyy-MM-dd') ASC";
        Statement sales = con.createStatement();
        ResultSet salesResults = sales.executeQuery(sql);
        if(userName == null){
            out.println("<h2 align=\"center\"><a href=\"login.jsp\">Login<a/></h2>");
        }
        out.println("<h2>Administrator Sales Report by Day</h2>");
        out.println("<table border='1'><tr><th>Order Date</th><th>Total Order Amount</th></tr>");

        while(salesResults.next()){
            out.println("<tr>");
            out.println("<td>" + salesResults.getDate("date") + "</td>");
            out.println("<td>" + salesResults.getFloat("total") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    }catch(SQLException e){
        out.println(e);
    }finally{
        closeConnection();
    }
%>



</body>
</html>