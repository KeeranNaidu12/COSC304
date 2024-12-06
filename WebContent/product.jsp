<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="static java.lang.Integer.parseInt" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Tara Kee Jhumke</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: teal;">

<%@ include file="header.jsp" %>

<%
    try {
        // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " + e);
    }

    try (Connection con = DriverManager.getConnection(url, uid, pw);) {
        String productId = request.getParameter("id");


        String sql = "select productId, productName, productPrice, productImageURL, productDesc from product where productId = ?";
        String reviewQuery = "select productId, avg(reviewRating) as averageRating from review where productId = ? GROUP BY productId";
        PreparedStatement pst = con.prepareStatement(sql);
        PreparedStatement pst2 = con.prepareStatement(reviewQuery);
        pst.setString(1, productId);
        pst2.setString(1, productId);

        ResultSet product = pst.executeQuery();
        ResultSet review = pst2.executeQuery();

        BigDecimal prodReview = null;

        // If there is a review for that product
        if (review.next()) {
            prodReview = review.getBigDecimal(2);
        }

        if (product.next()) {
            // Display product name
            out.print("<h2 style=\"color: black;\">" + product.getString(2) + "</h2>");
            String desc = product.getString(5);
            out.print("<h4 style=\"color: black;\"> " + desc + "</h4>");

            // Display product image
                String imgID = "img/" + productId + ".jpg";
                out.print("<img src='" + imgID + "' alt='" + desc + "' style='max-width:200px; max-height:400px;'>");


            // Display product details
            out.print("<table><tr>\n" +
                    "<th>Id</th><td>" + product.getString(1) + "</td></tr><tr><th>Price</th><td>" + product.getBigDecimal(3) + "</td></tr>");

            // Display rating if it exists
            if (prodReview != null) {
                out.print("<tr><th>Rating</th><td>" + prodReview + "</td></tr>");
            }

            // Add links
            out.println("<tr><td>");
            out.println("<h3><a href=\"addcart.jsp?id=" + productId + "&name=" + product.getString(2) + "&price=" + product.getBigDecimal(3) + "\" style=\"color: black;\">Add To Cart</a></h3>");
            out.println("</td></tr>");

            out.println("<tr><td>");
            out.println("<h3><a href=\"listprod.jsp\" style=\"color: black;\">Continue Shopping</a></h3>");
            out.println("</td></tr></table>");

        } else {
            out.print("<p>Product not found.</p>");
        }
    } catch (Exception e) {
        out.print(e);
    }
%>

</body>
</html>
