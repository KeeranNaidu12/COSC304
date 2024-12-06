<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create New Account</title>
</head>
<body style="background-color: teal;">
    <h1>Create New Account</h1>
    <%
    // Retrieve form data
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String password = request.getParameter("password");

    PreparedStatement checkStmt = null;
    PreparedStatement insertStmt = null;
    ResultSet rs = null;

    try {
        // Load SQL Server driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        // Establish connection using details from jdbc.jsp
        try (Connection conn = DriverManager.getConnection(url, uid, pw)) {

            // Check if the email already exists
            String checkQuery = "SELECT email FROM customer WHERE email = ?";
            checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                out.println("<h3>Email already registered. Please use a different email address.</h3>");
            } else {
                // Insert new customer record
                String insertQuery = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, password) " +
                                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, firstName);
                insertStmt.setString(2, lastName);
                insertStmt.setString(3, email);
                insertStmt.setString(4, phonenum);
                insertStmt.setString(5, address);
                insertStmt.setString(6, city);
                insertStmt.setString(7, state);
                insertStmt.setString(8, postalCode);
                insertStmt.setString(9, country);
                insertStmt.setString(10, password); // Use hashing for passwords in production

                int rowsInserted = insertStmt.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<h3>Account created successfully!</h3>");
                } else {
                    out.println("<h3>Error creating account. Please try again.</h3>");
                }
            }
        }
    } catch (Exception e) {
        out.println("<h3>An error occurred: " + e.getMessage() + "</h3>");
        
        // Capture stack trace into a String
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);

        // Output the stack trace as a String
        out.println("<pre>" + sw.toString() + "</pre>");
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (checkStmt != null) try { checkStmt.close(); } catch (Exception e) {}
        if (insertStmt != null) try { insertStmt.close(); } catch (Exception e) {}
    }
    %>
</body>
</html>

