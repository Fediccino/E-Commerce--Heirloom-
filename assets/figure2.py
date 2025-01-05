import matplotlib.pyplot as plt
import pandas as pd

# Data
data = {
    "Department": ["Finance", "HR", "Marketing", "IT", "Sales"],
    "Total Salary": [299273.35, 146095.84, 120730.56, 85365.28, 35365.28]
}

# Create DataFrame
df = pd.DataFrame(data)

# Plotting
plt.figure(figsize=(8, 8))

# Plot the pie chart
colors = ['purple', 'pink', 'blue', 'orange', 'green']
plt.pie(df['Total Salary'], labels=df['Department'], autopct='%1.1f%%', colors=colors, startangle=140, wedgeprops={'edgecolor': 'black'})

# Add legend
plt.legend(df['Department'], title="Departments", loc="upper left", bbox_to_anchor=(1, 1), fontsize=10)

# Chart details
plt.title("Total Salary Distribution per Department", fontsize=14, color='black')

# Set background color to white
plt.gcf().set_facecolor('white')
plt.gca().set_facecolor('white')

# Make text more visible by setting font color to black
for text in plt.gca().texts:
    text.set_color("black")

# Display the chart
plt.show()
