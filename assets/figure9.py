import pandas as pd
import plotly.express as px

# Data
data = {
    "Category": [
        "All Things Denim", "Windbreakers", "All Things Denim", "Plaid Skirts", 
        "All Things Denim", "Plaid Skirts", "All Things Striped", "Graphic Tees", 
        "Plaid Skirts", "Cargo Pants", "Accessories", "Bandana Headbands", 
        "Crop Shirts", "Accessories", "Baggy Jeans"
    ],
    "Product Type": [
        "Jeans", "Windbreaker", "Jean Jacket", "Plaid Skirt", "Skirt", "Plaid Jacket", 
        "Striped Shirt", "Graphic Tee", "Plaid Sweater", "Cargo Pants", "Necklace", 
        "Bandana", "Crop Shirt", "Ring", "Baggy Jeans"
    ],
    "Total Quantity Sold": [
        227, 224, 214, 190, 189, 179, 167, 154, 146, 144, 142, 138, 134, 127, 99
    ]
}

# Create DataFrame
df = pd.DataFrame(data)

# Create interactive horizontal bar chart for Product Type vs Total Quantity Sold
fig1 = px.bar(df, y="Product Type", x="Total Quantity Sold", 
              orientation='h', color="Product Type", 
              title="Product Type vs Total Quantity Sold",
              labels={"Total Quantity Sold": "Total Quantity Sold", "Product Type": "Product Type"})

# Create interactive horizontal bar chart for Category vs Total Quantity Sold
fig2 = px.bar(df, y="Category", x="Total Quantity Sold", 
              orientation='h', color="Category", 
              title="Category vs Total Quantity Sold",
              labels={"Total Quantity Sold": "Total Quantity Sold", "Category": "Category"})

# Show the charts
fig1.show()
fig2.show()
