
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

        .welcome > h1{
          font-size: 50px;
          color: black;
          display: flex;
          align-items: center;
          padding: 10px;
        }

		.welcome > h3{
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

        .welcome img{
                border-style: solid;
                border-color: white;
                width: 68%;
                display: block;
        }

    </style>
</head>
<body style="background-color: teal;">

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
	<%
	String userName = (String) session.getAttribute("authenticatedUser");
    String Name = "";
	if (userName != null)
		out.println("<h3> Welcome to Tara Kee Jhumke, "+ userName+" !</h3>");
		else
		response.sendRedirect("login.jsp");;
	%>
        <h1><img align=left img src="img/welcome.png"></h1>  

    </div>
    <h2><a href="listprod.jsp">Browse through our jewelry!</a></h2>

</body>
</html>

