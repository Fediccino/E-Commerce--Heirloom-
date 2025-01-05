import pandas as pd
import matplotlib.pyplot as plt

# Data
data = {
    "Manager_ID": [
        "015a3810-f371-42af-8d24-4275d937cbzp", "436d1965-bfb1-4a7d-9336-3cbdbdb7d244",
        "d96aed0c-aa4f-4230-9bf2-3ef8ba26cd47", "dd12cc5b-6278-4aed-b534-cd3321111ee7",
        "04f97f6f-6c7d-4eac-adf5-d6704ba9d94d", "0a6cadc8-973a-4233-9550-82ff0dd5df7e",
        "760d8158-bc3e-463a-9777-c3bfa97761c3", "87f97f6f-6c7d-4eac-adf5-d6784ba9d69d",
        "8c5f5468-7107-45af-8a7a-4b661efe312e", "f8153238-b1fa-441b-a2c6-e2629f5c39ef",
        "b5ac9d30-a08a-4278-b6db-d48f49c2429d"
    ],
    "Manager_Name": [
        "Griselda Grigoire", "Cass Bruton", "Kendall Heppenspall", "Tina Jeannequin",
        "Valina Thomerson", "Wakefield Ambrogio", "Basile Geistman", "Valentine Thomerson",
        "Donal Malley", "Kevin Chabau", "Quill Sword"
    ],
    "Manager_Department": [
        "Finance", "Sales", "IT", "Marketing", "Finance", "Finance",
        "HR", "Finance", "HR", "HR", "Marketing"
    ],
    "Number_of_Employees": [4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 1],
    "Hire_Date": [
        "2024-01-01 13:04:20", "2024-02-09 22:27:11", "2024-11-06 11:55:39", 
        "2024-02-27 09:56:47", "2024-09-13 13:04:20", "2024-11-11 01:01:01",
        "2024-01-06 23:39:19", "2024-05-30 13:28:34", "2024-02-12 22:16:46",
        "2024-02-12 22:16:46", "2024-07-31 09:22:20"
    ]
}

# Create DataFrame
df = pd.DataFrame(data)

# Group data by Manager_Department and sum the Number_of_Employees
department_data = df.groupby("Manager_Department")["Number_of_Employees"].sum()

# Plotting
plt.figure(figsize=(10, 6))

# Set background color to black
plt.gcf().set_facecolor('black')
plt.gca().set_facecolor('black')

# Plot with purple bars
department_data.plot(kind='bar', color='purple', edgecolor='black')

# Chart details with white color for text
plt.title("Number of Employees Managed per Department", fontsize=14, color='white')
plt.xlabel("Department", fontsize=12, color='white')
plt.ylabel("Number of Employees", fontsize=12, color='white')
plt.xticks(rotation=45, color='white')
plt.yticks(color='white')
plt.grid(axis='y', linestyle='--', alpha=0.7, color='white')

# Save the chart as an image file
plt.tight_layout()
plt.savefig("employees_per_department_chart.png")
plt.show()
