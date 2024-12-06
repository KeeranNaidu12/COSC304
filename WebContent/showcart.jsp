<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {
    out.println("<H1>Your shopping cart is empty!</H1>");
    productList = new HashMap<String, ArrayList<Object>>();
} else {
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h1>Your Shopping Cart</h1>");
    out.print("<table border='1'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
    out.println("<th>Price</th><th>Subtotal</th><th>Action</th></tr>");

    double total = 0;
    for (Map.Entry<String, ArrayList<Object>> entry : productList.entrySet()) {
        ArrayList<Object> product = entry.getValue();

        String productId = product.get(0).toString();
        String productName = product.get(1).toString();
        double price = Double.parseDouble(product.get(2).toString());
        int qty = Integer.parseInt(product.get(3).toString());
        double subtotal = qty * price;

        out.print("<tr>");
        out.print("<td>" + productId + "</td>");
        out.print("<td>" + productName + "</td>");

        // Editable quantity cell with a save button
        out.print("<td align='center'>");
        out.print("<form method='post' action='updateCart.jsp' style='display: inline;'>");
        out.print("<input type='hidden' name='productId' value='" + productId + "'>");
        out.print("<input type='number' name='quantity' value='" + qty + "' min='1' style='width: 50px;'>");
        out.print("<button type='submit'>Save</button>");
        out.print("</form>");
        out.print("</td>");

        out.print("<td align='right'>" + currFormat.format(price) + "</td>");
        out.print("<td align='right'>" + currFormat.format(subtotal) + "</td>");

        // Delete button for removing item from cart
        out.print("<td>");
        out.print("<form method='post' action='removeFromCart.jsp' style='display: inline;'>");
        out.print("<input type='hidden' name='productId' value='" + productId + "'>");
        out.print("<button type='submit'>Delete</button>");
        out.print("</form>");
        out.print("</td>");

        out.println("</tr>");
        total += subtotal;
    }

    out.println("<tr><td colspan='5' align='right'><b>Order Total</b></td>"
            + "<td align='right'>" + currFormat.format(total) + "</td></tr>");
    out.println("</table>");

    out.println("<h2><a href='checkout.jsp'>Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
