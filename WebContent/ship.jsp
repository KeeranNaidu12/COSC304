<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
	<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

	<%
try{
	getConnection();
	// TODO: Get order id

		String orderId = request.getParameter("orderId");
		int getOrderId = Integer.parseInt(orderId);
		String idQuery = "SELECT orderId FROM ordersummary WHERE orderId = ?";
		PreparedStatement id = con.prepareStatement(idQuery);
		id.setInt(1,getOrderId);
		ResultSet idResults = id.executeQuery();
		boolean isValid = true;

	// TODO: Check if valid order id in database
	if(idResults.next()){
		isValid = true;
	}else{
		out.println("<h2>This Order Id is not valid!!!");
	}
	// TODO: Start a transaction (turn-off auto-commit)

	con.setAutoCommit(false);

	// TODO: Retrieve all items in order with given id
	if(isValid == true){
		String getItems = "SELECT orderproduct.productId,orderproduct.quantity,productInventory.quantity FROM orderproduct JOIN productInventory ON orderproduct.productId = productInventory.productId WHERE orderId = ?";
		PreparedStatement items = con.prepareStatement(getItems);
		items.setInt(1,getOrderId);
		ResultSet itemResults = items.executeQuery();
		boolean isValid2 = true;


		while(itemResults.next()){
			if(itemResults.getInt(3)-itemResults.getInt(2) < 0){
				out.println("<h2>Your shipment isn't done! There's insufficient inventory for product id: " + itemResults.getInt(1) + "</h2>");
				isValid2 = false;
				con.rollback();
				break;
			}
			else{
				out.println("<h2> Ordered Product: " + itemResults.getInt(1) + " Quantity: " + itemResults.getInt(2) + " Previous Inventory: " + itemResults.getInt(3) + " New Inventory: " + (itemResults.getInt(3) - itemResults.getInt(2)));
				String inventory = "UPDATE productInventory SET quantity = ? WHERE productId = ?";
				PreparedStatement newInventory = con.prepareStatement(inventory);
				newInventory.setInt(1,(itemResults.getInt(3)-itemResults.getInt(2)));
				newInventory.setInt(2,itemResults.getInt(1));
				newInventory.executeUpdate();
			}
		}

		if(isValid2 == true){
			String orderDate = request.getParameter("orderDate");
			String insertShip = "INSERT INTO shipment(shipmentDate,warehouseId) VALUES(?,1)";
			PreparedStatement shipment = con.prepareStatement(insertShip);
			shipment.setString(1,orderDate);
			shipment.executeUpdate();
			out.println("<h2> The process of the shipment was successful!");
		}
	}
	con.commit();
	con.setAutoCommit(true);

	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.

	// TODO: Auto-commit should be turned back on
	}catch(Exception e){
		out.println(e);
	}finally{
		closeConnection();
	}

%>

<h2><a href="index.jsp">Back to Main Page</a></h2>

<body>
</html>