<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Remove Item from Cart</title>
</head>
<body>

<%
    // Retrieve the productList from session
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    if (productList != null) {
        String productIdToRemove = request.getParameter("productId");

        if (productIdToRemove != null && !productIdToRemove.isEmpty()) {
            // Remove the product from the cart
            productList.remove(productIdToRemove);
            session.setAttribute("productList", productList);
            out.println("<h3>Item removed from your cart.</h3>");
        }
    }

    // Redirect back to the shopping cart page or display the updated cart
    response.sendRedirect("showcart.jsp"); // Replace with the actual page you want to show
%>

</body>
</html>