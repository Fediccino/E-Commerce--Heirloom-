import matplotlib.pyplot as plt

# Data
brands = [
    "All Things Denim", "Windbreakers", "All Things Denim", "Plaid Skirts",
    "All Things Denim", "Plaid Skirts", "All Things Striped", "Graphic Tees",
    "Plaid Skirts", "Cargo Pants", "Accessories", "Bandana Headbands",
    "Crop Shirts", "Accessories", "Baggy Jeans"
]
categories = [
    "Jeans", "Windbreaker", "Jean Jacket", "Plaid Skirt", "Skirt",
    "Plaid Jacket", "Striped Shirt", "Graphic Tee", "Plaid Sweater",
    "Cargo Pants", "Necklace", "Bandana", "Crop Shirt", "Ring", "Baggy Jeans"
]
values = [227, 224, 214, 190, 189, 179, 167, 154, 146, 144, 142, 138, 134, 127, 99]

# Combine brands and categories for labels
labels = [f"{brand} - {category}" for brand, category in zip(brands, categories)]

# Create the figure and axis
plt.figure(figsize=(10, 8))

# Plot horizontal bar graph
plt.barh(labels, values, color="skyblue", edgecolor="black")

# Add titles and labels
plt.title("Sales by Product and Brand", fontsize=16)
plt.xlabel("Number of Items Sold", fontsize=12)
plt.ylabel("Product and Brand", fontsize=12)

# Add grid for readability
plt.grid(axis="x", linestyle="--", alpha=0.7)

# Reverse the order of labels to match horizontal bar order
plt.gca().invert_yaxis()

# Show the plot
plt.tight_layout()
plt.show()
