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

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"bobby".equals(userName)) {
        out.println("<h2 align=\"center\">Access Denied</h2>");
        out.println("<p align=\"center\">You do not have permission to view this page.</p>");
        return;
    }
%>

<%
    try {
        getConnection();

        //Sales data
        String salesSql = "SELECT FORMAT(orderDate, 'yyyy-MM-dd') as date, SUM(totalAmount) AS total FROM ordersummary GROUP BY FORMAT(orderDate, 'yyyy-MM-dd') ORDER BY FORMAT(orderDate, 'yyyy-MM-dd') ASC";
        Statement salesStmt = con.createStatement();
        ResultSet salesResults = salesStmt.executeQuery(salesSql);

        out.println("<h2>Administrator Sales Report by Day</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");
        while (salesResults.next()) {
            out.println("<tr>");
            out.println("<td>" + salesResults.getDate("date") + "</td>");
            out.println("<td>" + salesResults.getFloat("total") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");

        //customer data
        String customerSql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer";
        PreparedStatement customerStmt = con.prepareStatement(customerSql);
        ResultSet customerResults = customerStmt.executeQuery();

        out.println("<h2>Customer Profiles</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>Customer ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>User ID</th></tr>");
        while (customerResults.next()) {
            out.println("<tr>");
            out.println("<td>" + customerResults.getString("customerId") + "</td>");
            out.println("<td>" + customerResults.getString("firstName") + "</td>");
            out.println("<td>" + customerResults.getString("lastName") + "</td>");
            out.println("<td>" + customerResults.getString("email") + "</td>");
            out.println("<td>" + customerResults.getString("phonenum") + "</td>");
            out.println("<td>" + customerResults.getString("address") + "</td>");
            out.println("<td>" + customerResults.getString("city") + "</td>");
            out.println("<td>" + customerResults.getString("state") + "</td>");
            out.println("<td>" + customerResults.getString("postalCode") + "</td>");
            out.println("<td>" + customerResults.getString("country") + "</td>");
            out.println("<td>" + customerResults.getString("userid") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        closeConnection();
    }
%>

</body>
</html>
