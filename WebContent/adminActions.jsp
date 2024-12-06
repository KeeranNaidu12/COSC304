<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>
    <style>
        body {
            background-color: teal;
            font-family: Arial, sans-serif;
        }

        .form-container {
            display: flex;
            gap: 20px;
            justify-content: flex-start;
            align-items: flex-start;
        }

        .form-container form {
            background-color: white;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 300px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-container form h3 {
            margin-top: 0;
        }

        .form-container label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-container input,
        .form-container textarea,
        .form-container button {
            width: 100%;
            margin-bottom: 10px;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .form-container button {
            background-color: teal;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: darkcyan;
        }
    </style>
</head>
<body>

<h3>Administrator Actions</h3>
<div class="form-container">
    <form method="post" action="updateProduct.jsp">
        <h3>Update Product</h3>
        <label for="productId">Product ID:</label>
        <input type="text" id="productId" name="productId" required>

        <label for="productName1">Product Name:</label>
        <input type="text" id="productName1" name="productName" required>

        <label for="price1">Price:</label>
        <input type="number" id="price1" name="price" step="0.01" required>

        <label for="description1">Description:</label>
        <textarea id="description1" name="description" rows="4"></textarea>

        <button type="submit">Update Product</button>
    </form>

    <form method="post" action="addProduct.jsp">
        <h3>Add Product</h3>
        <label for="productName2">Product Name:</label>
        <input type="text" id="productName2" name="productName" required>

        <label for="price2">Price:</label>
        <input type="number" id="price2" name="price" step="0.01" required>

        <label for="cat">Category:</label>
        <input type="number" id="cat" name="category" step="0.01" required>

        <label for="description2">Description:</label>
        <textarea id="description2" name="description" rows="4"></textarea>

        <button type="submit">Add Product</button>
    </form>

    <form method="post" action="deleteProduct.jsp">
        <h3>Delete Product</h3>
        <label for="productId2">Product ID:</label>
        <input type="text" id="productId2" name="productId" required>

        <button type="submit">Delete Product</button>
    </form>
</div>

</body>
</html>
