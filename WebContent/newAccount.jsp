<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body>
<body style="background-color: teal;">

</style>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Create a New Account</h3>

<form name="MyForm" method="post" action="verifyNew.jsp" onsubmit="return validateForm();">
    <table style="display:inline">
        <tr>
            <td><div align="right">First Name:</div></td>
            <td><input type="text" name="firstName" maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="right">Last Name:</div></td>
            <td><input type="text" name="lastName" maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="right">Email:</div></td>
            <td><input type="email" name="email" maxlength="50"></td>
        </tr>
        <tr>
            <td><div align="right">Phone Number:</div></td>
            <td><input type="text" name="phonenum" maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="right">Address:</div></td>
            <td><input type="text" name="address" maxlength="50"></td>
        </tr>
        <tr>
            <td><div align="right">City:</div></td>
            <td><input type="text" name="city" maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="right">State:</div></td>
            <td><input type="text" name="state" maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="right">Postal Code:</div></td>
            <td><input type="text" name="postalCode" maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="right">Country:</div></td>
            <td><input type="text" name="country" maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="right">Password:</div></td>
            <td><input type="password" name="password" maxlength="30"></td>
        </tr>
    </table>
    <br/>
    <input type="submit" value="Create Account">
</form>

</body>
</html>
