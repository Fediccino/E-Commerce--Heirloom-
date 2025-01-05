import pandas as pd
import matplotlib.pyplot as plt

# Data
data = {
    "Employee Name": [
        "Kendall Heppenspall", "Tina Jeannequin", "Wakefield Ambrogio", 
        "Valentine Thomerson", "Valina Thomerson"
    ],
    "Department": ["IT", "Marketing", "Finance", "Finance", "Finance"],
    "Email": [
        "kheppenspall57@kickstarter.com", "tjeannequin17@slate.com", 
        "wambrogio7r@creativecommons.org", "vthomerson6s@dell.com", 
        "vthomerson6s@dell.com"
    ],
    "Salary": [85365.28, 85365.28, 67652.35, 65890.44, 60365.28]
}

# Create DataFrame
df = pd.DataFrame(data)

# Plotting the bar chart for employee salaries
plt.figure(figsize=(10, 6))

# Set background color to black
plt.gcf().set_facecolor('black')
plt.gca().set_facecolor('black')

# Create a bar chart with purple bars and black edges
plt.bar(df["Employee Name"], df["Salary"], color='purple', edgecolor='black')

# Chart details with white color for text
plt.title("Top Employee Salaries", fontsize=14, color='white')
plt.xlabel("Employee Name", fontsize=12, color='white')
plt.ylabel("Salary ($)", fontsize=12, color='white')
plt.xticks(rotation=45, ha='right', color='white')
plt.yticks(color='white')
plt.grid(axis='y', linestyle='--', alpha=0.7, color='white')

# Show the plot
plt.tight_layout()
plt.show()
