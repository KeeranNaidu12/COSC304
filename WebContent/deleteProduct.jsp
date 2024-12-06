<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%

    //String userName = (String) session.getAttribute("authenticatedUser");

    String productId = request.getParameter("productId1");

    if (productId != null) {
        try (Connection con = DriverManager.getConnection(url, uid, pw)) {
            String updateProductsql = "delete product WHERE productId = ?";
            try (PreparedStatement stmt = con.prepareStatement(updateProductsql)) {
                stmt.setString(1, productId);
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    out.println("<p>Product deleted successfully!</p>");
                } else {
                    out.println("<p>Error: Product delete failed. Product ID not found.</p>");
                }
            }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Error: Customer ID is missing. Please log in.</p>");
    }
%>

