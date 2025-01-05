import pandas as pd
import matplotlib.pyplot as plt

# Data
data = {
    "Payment Month": [
        "2024-12", "2024-07", "2024-08", "2024-11", "2024-03",
        "2024-10", "2024-05", "2024-06", "2024-09", "2024-01", 
        "2024-04", "2024-02", "2025-01"
    ],
    "Total Sales": [
        12974.09, 11882.95, 11346.62, 11184.28, 11005.50, 
        10813.17, 10174.28, 9780.47, 9680.27, 9598.17, 
        9577.24, 9369.06, 1693.26
    ]
}

# Create DataFrame
df = pd.DataFrame(data)

# Convert 'Payment Month' to datetime
df['Payment Month'] = pd.to_datetime(df['Payment Month'], format='%Y-%m')

# Remove data for the year 2025
df = df[df['Payment Month'].dt.year != 2025]

# Sort by 'Payment Month'
df = df.sort_values('Payment Month')

# Plotting the line graph
plt.figure(figsize=(10, 6))

# Create the line graph
plt.plot(df['Payment Month'], df['Total Sales'], color='purple', marker='o', linestyle='-', markersize=8, linewidth=2, markeredgecolor='black')

# Chart details
plt.title("Total Sales per Payment Month", fontsize=14)
plt.xlabel("Payment Month", fontsize=12)
plt.ylabel("Total Sales ($)", fontsize=12)
plt.xticks(rotation=45, ha='right')
plt.yticks()
plt.grid(True, linestyle='--', alpha=0.7)

# Show the plot
plt.tight_layout()
plt.show()
