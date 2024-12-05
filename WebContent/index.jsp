
<!DOCTYPE html>
<html>
<head>
    <title>Tara Kee Jhumke</title>
    <style>
        body {
            background-color: teal;
            font-family: Arial, sans-serif;
            margin: 0;
        }
        nav {
            background-color: white;
            overflow: hidden;
            display: flex;
            justify-content: center;
            padding: 10px 0;
        }
        nav a {
            margin: 30px;
            color: black;
            text-decoration: none;
            padding: 14px 20px;
            display: inline-block;
            text-align: center;
        }
        nav a:hover {
            background-color: rgb(220, 220, 220);
        }
        .logo {
            text-align:start;
            margin: -10px;

        }

        .welcome {
          display: flex;
          align-items: center;
          padding: 30px;
        }

        .welcometext{
          align-items: center;
          margin-left: 120px;
          border-style: solid;
          border-color: dark-teal;
          background-color: teal;
          font-size: 50px;
          color: black;
          display: flex;
          align-items: center;
          padding: 10px;
        }

		.welcome > h3{
          border-style: solid;
          font-size: 50px;
          color: black;
          display: flex;
          padding: 10px;

        }

        body > h2{
          font-size: 50px;
          color: black;
          display: flex;
          align-items: center;
          padding: 10px;
          margin-left: 25%;
          margin-top: -20px;
        }

        .welcome > img{
                border-color: white;
                width: 68%;
        }

        .checkProducts {
          align-items: center;
          margin-left: 430px;
          border-style: solid;
          border-color: dark-teal;
          background-color: teal;
          font-size: 25px;
          color: black;
          display: inline-block;
          align-items: center;
          padding: 5px 10px;
        }

    </style>
</head>
<body style="background-image:url('img/main.jpg');">

    <nav>
        <div class="logo">
                <h1><img align=right img src="img/logo.png" alt="Logo"></h1>
            </div>
        <a href="listorder.jsp">List All Orders</a>
        <a href="customer.jsp">Customer Info</a>
        <a href="admin.jsp">Administrators</a>
        <a href="logout.jsp">Log Out</a>
    </nav>

    <div class="welcome">
    <div class="welcometext">
	<%
	String userName = (String) session.getAttribute("authenticatedUser");
    String Name = "";
	if (userName != null)
		out.println("<h3> Welcome to Tara Kee Jhumke, "+ userName+" !</h3>");
		else
		response.sendRedirect("login.jsp");
	%>
    </div>
    
    </div>

    <div class="checkProducts">
    <h2><a href="listprod.jsp">Browse through our jewelry!</a></h2>
    </div>

</body>
</html>

