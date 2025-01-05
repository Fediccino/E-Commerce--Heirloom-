import folium

# Data for the cities
data = [
    {"city": "Washington", "state": "DC", "country": "United States", "sales": 3626.65, "coordinates": [38.9072, -77.0369]},
    {"city": "New York City", "state": "NY", "country": "United States", "sales": 3080.55, "coordinates": [40.7128, -74.0060]},
    {"city": "Houston", "state": "TX", "country": "United States", "sales": 2830.42, "coordinates": [29.7604, -95.3698]},
    {"city": "Atlanta", "state": "GA", "country": "United States", "sales": 2142.35, "coordinates": [33.7490, -84.3880]},
    {"city": "Dallas", "state": "TX", "country": "United States", "sales": 2019.47, "coordinates": [32.7767, -96.7970]},
    {"city": "Louisville", "state": "KY", "country": "United States", "sales": 1840.58, "coordinates": [38.2527, -85.7585]},
    {"city": "Cincinnati", "state": "OH", "country": "United States", "sales": 1830.50, "coordinates": [39.1031, -84.5120]},
    {"city": "Las Vegas", "state": "NV", "country": "United States", "sales": 1674.60, "coordinates": [36.1699, -115.1398]},
    {"city": "Saint Louis", "state": "MO", "country": "United States", "sales": 1597.74, "coordinates": [38.6270, -90.1994]},
    {"city": "Chicago", "state": "IL", "country": "United States", "sales": 1596.55, "coordinates": [41.8781, -87.6298]},
]

# Create a map centered in the United States
us_map = folium.Map(location=[37.0902, -95.7129], zoom_start=4, tiles="cartodbpositron")

# Add markers for each city
for entry in data:
    folium.CircleMarker(
        location=entry["coordinates"],
        radius=10,
        color="blue",
        fill=True,
        fill_color="red",
        fill_opacity=0.7,
        popup=f"<strong>City:</strong> {entry['city']}<br>"
              f"<strong>State:</strong> {entry['state']}<br>"
              f"<strong>Country:</strong> {entry['country']}<br>"
              f"<strong>Total Sales:</strong> ${entry['sales']:.2f}",
    ).add_to(us_map)

# Save map as HTML to view in a browser
us_map.save("interactive_us_sales_map.html")

# Display message to open the file
print("Map has been saved as 'interactive_us_sales_map.html'. Open it in a browser to view.")
