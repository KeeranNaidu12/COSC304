<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body style="background-color: teal;">

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
		String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid from customer where userid = ? ";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, userName);
		ResultSet rs = pst.executeQuery();
		if(userName == null){
			out.println("Error: You are not logged in. You must be logged in to access this page. ");
			out.println("<h2 align=\"center\"><a href=\"login.jsp\">Login</a></h2>");
		}
		else{
			if (rs.next()) {
				String customerId = rs.getString(1);
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				String email = rs.getString(4);
				String phoneNum = rs.getString(5);
				String address = rs.getString(6);
				String city = rs.getString(7);
				String state = rs.getString(8);
				String postalCode = rs.getString(9);
				String country = rs.getString(10);
				String userId = rs.getString(11);


				out.println("<h2>Customer Profile</h2>");
				out.println("<table border = 1>");

				out.println("<tr><th>Id</th><td>" + customerId + "</td></tr>");
				out.println("<tr><th>First Name</th><td>" + firstName + "</td></tr>");
				out.println("<tr><th>Last Name</th><td>" + lastName + "</td></tr>");
				out.println("<tr><th>Email</th><td>" + email + "</td></tr>");
				out.println("<tr><th>Phone</th><td>" + phoneNum + "</td></tr>");
				out.println("<tr><th>Address</th><td>" + address + "</td></tr>");
				out.println("<tr><th>City</th><td>" + city + "</td></tr>");
				out.println("<tr><th>State</th><td>" + state + "</td></tr>");
				out.println("<tr><th>Postal Code</th><td>" + postalCode + "</td></tr>");
				out.println("<tr><th>Country</th><td>" + country + "</td></tr>");
				out.println("<tr><th>User ID</th><td>" + userId + "</td></tr>");

				out.println("</table>");
			} else {
				out.println("No profile found for the logged-in user.");
			}
		}



	}
	catch(Exception e){
		out.println(e);
	}
// Make sure to close connection
%>

</body>
</html>

