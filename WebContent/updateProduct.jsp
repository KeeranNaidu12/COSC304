<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%

    //String userName = (String) session.getAttribute("authenticatedUser");

    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName1");
    String price = request.getParameter("price1");
    String desc = request.getParameter("description1");

    if (productId != null && productName != null && price != null && desc != null) {
        try (Connection con = DriverManager.getConnection(url, uid, pw)) {
                String updateProductsql = "UPDATE product SET productName = ?, productPrice = ?, productDesc = ? WHERE productId = ?";
                try (PreparedStatement stmt = con.prepareStatement(updateProductsql)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, price);
                    stmt.setString(3, desc);
                    stmt.setString(4, productId);
                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<p>Product updated successfully!</p>");
                    } else {
                        out.println("<p>Error: Product update failed. Product ID not found.</p>");
                    }
                }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Error: Customer ID is missing. Please log in.</p>");
    }
%>

