<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Retrieve session and product list
    HashMap<String, ArrayList<Object>> productList = 
        (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    if (productList != null) {
        String productId = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        if (productId != null && quantityStr != null && productList.containsKey(productId)) {
            try {
                int quantity = Integer.parseInt(quantityStr);
                if (quantity > 0) {
                    ArrayList<Object> product = productList.get(productId);
                    product.set(3, quantity); // Update quantity
                    productList.put(productId, product); // Update the product list
                    session.setAttribute("productList", productList);
                }
            } catch (NumberFormatException e) {
                // Handle invalid quantity
                out.println("Invalid quantity provided for product: " + productId);
            }
        }
    }

    // Redirect back to the shopping cart
    response.sendRedirect("showcart.jsp");
%>