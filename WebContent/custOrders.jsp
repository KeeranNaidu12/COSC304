<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<html>
<head>
    <title>Your Orders</title>
</head>
<body style="background-color: teal;">

<h1>Order List</h1>

<%
    String username = (String) session.getAttribute("authenticatedUser");
    //Note: Forces loading of SQL Server driver
    try {
        // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " + e);
    }

    try (Connection con = DriverManager.getConnection(url, uid, pw)) {
        String orderQuery = "SELECT o.orderId, o.orderDate, o.customerId, c.firstName, c.lastName, o.totalAmount " +
                "FROM ordersummary as o " +
                "JOIN customer as c ON o.customerId = c.customerId WHERE c.userId = ?";
        String productQuery = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
        PreparedStatement stmt = con.prepareStatement(orderQuery);
        stmt.setString(1, username);

        ResultSet rst = stmt.executeQuery();

        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        out.println("<table border='1'><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th><th>Products</th></tr>");

        while (rst.next()) {
            String orderId = rst.getString(1);
            double totalAmount = rst.getDouble(6);

            out.println("<tr>");
            out.println("<td>" + orderId + "</td>");
            out.println("<td>" + rst.getDate(2) + "</td>");
            out.println("<td>" + rst.getString(3) + "</td>");
            out.println("<td>" + rst.getString(4) + " " + rst.getString(5) + "</td>");
            out.println("<td>" + currFormat.format(totalAmount) + "</td>");

            out.println("<td><table border='1'><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");

            PreparedStatement pstmt = con.prepareStatement(productQuery);
            pstmt.setString(1, orderId);
            ResultSet prst = pstmt.executeQuery();

            while (prst.next()) {
                out.println("<tr>");
                out.println("<td>" + prst.getString(1) + "</td>");
                out.println("<td>" + prst.getInt(2) + "</td>");
                out.println("<td>" + prst.getBigDecimal(3) + "</td>");
                out.println("</tr>");
            }

            out.println("</table></td></tr>");
        }

        out.println("</table>");
    } catch (Exception e) {
        out.print(e);
    }
%>

</body>
</html>
