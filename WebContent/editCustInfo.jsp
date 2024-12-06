<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%

    String userName = (String) session.getAttribute("authenticatedUser");

    String newAddress = request.getParameter("Address");
    String newPassword = request.getParameter("password");

    if (userName != null && !userName.isEmpty()) {
        try (Connection con = DriverManager.getConnection(url, uid, pw)) {
            if (newAddress != null && !newAddress.isEmpty()) {
                String updateAddressSql = "UPDATE customer SET address = ? WHERE userId = ?";
                try (PreparedStatement stmt = con.prepareStatement(updateAddressSql)) {
                    stmt.setString(1, newAddress);
                    stmt.setString(2, userName);
                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<p>Address updated successfully!</p>");
                    } else {
                        out.println("<p>Error: Address update failed. Customer ID not found.</p>");
                    }
                }
            }

            if (newPassword != null && !newPassword.isEmpty()) {
                String updatePasswordSql = "UPDATE customer SET password = ? WHERE userId = ?";
                try (PreparedStatement stmt = con.prepareStatement(updatePasswordSql)) {
                    stmt.setString(1, newPassword);
                    stmt.setString(2, userName);
                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<p>Password updated successfully!</p>");
                    } else {
                        out.println("<p>Error: Password update failed. Customer ID not found.</p>");
                    }
                }
            }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Error: Customer ID is missing. Please log in.</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Details</title>
</head>
<body style="background-color: teal;">
<h2>Edit Account Details</h2>

<form action="editCustInfo.jsp" method="POST">
    <label for="Address">Address:</label>
    <input type="text" id="Address" name="Address" required />
    <input type="submit" value="Update Address" />
</form>
<br>

<form action="editCustInfo.jsp" method="POST">
    <label for="password">Password:</label>
    <input type="text" id="password" name="password" />
    <input type="submit" value="Update Password" />
</form>
<br>

</body>
</html>
