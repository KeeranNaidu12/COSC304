<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%

    //String userName = (String) session.getAttribute("authenticatedUser");

    String productName = request.getParameter("productName2");
    String price = request.getParameter("price2");
    String desc = request.getParameter("description2");
    String cat = request.getParameter("cat");

    if (productName != null && price != null && desc != null && cat!= null) {
        try (Connection con = DriverManager.getConnection(url, uid, pw)) {
            String updateProductsql = "INSERT product(productName, categoryId, productDesc, productPrice) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(updateProductsql)) {
                stmt.setString(1, productName);
                stmt.setString(2, cat);
                stmt.setString(3, price);
                stmt.setString(4, desc);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>Product added successfully!</p>");
                } else {
                    out.println("<p>Error: Product add failed.</p>");
                }
            }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Error: Customer ID is missing. Please log in.</p>");
    }
%>

