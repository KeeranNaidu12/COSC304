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
        int IdInt = Integer.parseInt(productId);

        String sql = "select productId, productName, productPrice, productImageURL, productDesc from product where productId = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, productId);
        ResultSet product = pst.executeQuery();
        if (product.next()) {
            // Display product name
            out.print("<h2 style=\"color: black;\">" + product.getString(2) + "</h2>");
            String desc = product.getString(5);
            out.print("<h4 style=\"color: black;\"> " + desc + "</h4>");


            // Display product image
            String[] imgIds = {"1", "2", "3", "4", "5"};
//            String productImageURL = product.getString(4);
//            if (productImageURL != null && !productImageURL.isEmpty())
            int i = 0;
           if(IdInt <= 6){
                String imgID = "img/" + productId + ".jpg";
                out.print("<img src='" + imgID + "' alt='"+ desc + "' style='max-width:200px; max-height:400px;'>");
            }
            out.print("<table><tr>\n" +
                    "<th>Id</th><td>" + product.getString(1) + "</td></tr><tr><th>Price</th><td>" + product.getBigDecimal(3) + "</td></tr>");
            //link to add to cart
            out.println("<tr><td>");
            out.println("<h3><a href=\"addcart.jsp?id=" + productId + "&name=" + product.getString(2) + "&price=" + product.getBigDecimal(3) + "\" style=\"color: black;\">Add To Cart</a></h3>");
            out.println("</td></tr>");
// Link back to the product page to continue shopping
            out.println("<tr><td>");
            out.println("<h3><a href=\"listprod.jsp\" style=\"color: black;\">Continue Shopping</a></h3>");
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

