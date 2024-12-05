<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="static java.lang.Integer.parseInt" %>
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
    // Get product name to search for
// TODO: Retrieve and display info for the product

    try
    {	// Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e)
    {
        out.println("ClassNotFoundException: " +e);
    }

    try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
        String productId = request.getParameter("id");

        String sql = "select productId, productName, productPrice, productImageURL, productDesc from product where productId = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, productId);
        ResultSet product = pst.executeQuery();
        String desc = product.getString(5);
        if (product.next()) {
            // Display product name
            out.print("<h2>" + product.getString(2) + "</h2>");

            out.print("<h3>" + desc + "</h3>");

            // Display product image
            String[] imgIds = {"1", "2", "3", "4", "5"};
//            String productImageURL = product.getString(4);
//            if (productImageURL != null && !productImageURL.isEmpty())
            String imgID = "img/" + productId + ".jpg";
            out.print("<img src='" + imgID + "' alt='"+ desc + "' style='max-width:200px; max-height:400px;'>");
            out.print("<table><tr>\n" +
                    "<th>Id</th><td>" + product.getString(1) + "</td></tr><tr><th>Price</th><td>" + product.getBigDecimal(3) + "</td></tr>");
            //link to add to cart
            out.println("<tr><td>");
            out.println("<h3><a href=\"addcart.jsp?id=" + productId + "&name=" + product.getString(2) + "&price=" + product.getBigDecimal(3) + "\">Add To Cart</a></h3>");
            out.println("</td></tr>");
            //link back to product page to continue shopping
            out.println("<tr><td>");
            out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>");
            out.println("</td></tr></table>");



        } else {
            out.print("<p>Product not found.</p>");
        }
    }
    catch(Exception e) {
        out.print(e);
    }
// TODO: If there is a productImageURL, display using IMG tag

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.

// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>