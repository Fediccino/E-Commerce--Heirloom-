import pandas as pd
import plotly.express as px

# Data
data = {
    "City": [
        "Washington", "New York City", "Houston", "Atlanta", "Dallas", 
        "Louisville", "Cincinnati", "Las Vegas", "Saint Louis", "Chicago"
    ],
    "State": ["DC", "NY", "TX", "GA", "TX", "KY", "OH", "NV", "MO", "IL"],
    "Country": ["United States"] * 10,
    "Total Sales": [
        3626.65, 3080.55, 2830.42, 2142.35, 2019.47, 
        1840.58, 1830.50, 1674.60, 1597.74, 1596.55
    ]
}

# Create DataFrame
df = pd.DataFrame(data)

# Create an interactive heatmap
fig = px.density_mapbox(df, 
                        lat=[37.7749, 40.7128, 29.7604, 33.7490, 32.7767, 38.2527, 39.1031, 36.1699, 38.6270, 41.8781],  # Example latitudes (adjust accordingly)
                        lon=[-77.0369, -74.0060, -95.3698, -84.3880, -96.7970, -85.7585, -84.5120, -115.1398, -90.1994, -87.6298],  # Example longitudes (adjust accordingly)
                        z=df['Total Sales'],
                        color_continuous_scale='Viridis',  # Color scale for the heatmap
                        title="City and State Sales Performance",
                        mapbox_style="carto-positron",
                        labels={"Total Sales": "Sales ($)"},
                        opacity=0.7)

# Show the plot
fig.show()
