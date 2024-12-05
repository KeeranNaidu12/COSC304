<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Sithara and Keeran's Grocery</title>
</head>
<body>
<body style="background-color: teal;"">

</style>

<h1>Browse through our available jewelry!</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
	// Create statement
	ResultSet products;
	if(name == null || name.trim().isEmpty()){
		String listAll = "select productId, productName, productPrice from product";
		Statement list = con.createStatement();
		products = list.executeQuery(listAll);
		out.println("<h2>All Products</h2>");
	}
	// Print out the ResultSet
	else {
		String listProduct = "select productId, productName, productPrice from product where productName like ?";
		PreparedStatement pstmt = con.prepareStatement(listProduct);
		String subName = "%"+name+"%";
		pstmt.setString(1, subName);
		out.println("<h2>Products containing '" + name + "'</h2>");
		products = pstmt.executeQuery();
	}
	out.println("<table border='1'><tr><th><h3>Product Name</h3></th><th><h3>Price</h3></th></tr>");
	while(products.next()){
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();String id = products.getString(1);
		String pname = products.getString(2);
		BigDecimal price = products.getBigDecimal(3);

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice
		out.println("<tr>");
		out.println("<td>");
		out.println("<a href=\"addcart.jsp?id=" + id + "&name=" + pname + "&price=" + price + "\">Add To Cart</a>");
		out.println("&nbsp&nbsp");
		out.println("<a href=\"product.jsp?id=" + id + "\">" + pname + "</a>");
		out.println("</td><td>");
		out.println(currFormat.format(price)); // Price
		out.println("</td>");
		out.println("</tr>");

//		out.println("<tr><td><a href=\"addcart.jsp?id=" + id + "&name=" + pname + "&price=" + price + "\">Add To Cart</a>&nbsp;&nbsp;" + pname + "</td>");
//		out.println("<td>" + currFormat.format(price) + "</td></tr>");

	}
	out.println("</table>");

}
catch(Exception e) {
	out.print(e);
}
// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection




// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>