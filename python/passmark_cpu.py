import requests
from bs4 import BeautifulSoup
import csv
import argparse

# URL of the page to scrape
url = "https://www.cpubenchmark.net/singleThread.html"

# Base URL for CPU links
base_url = "https://www.cpubenchmark.net/"

# Send a GET request to the URL
response = requests.get(url)
response.raise_for_status()  # Check if the request was successful

# Parse the HTML content using BeautifulSoup
soup = BeautifulSoup(response.content, "html.parser")

# Find the chart body that contains the list of CPUs
chart_body = soup.find("div", class_="chart_body")
cpus = chart_body.find_all("li")

# List to hold the CPU data
cpu_data = []

# Argument parser setup
parser = argparse.ArgumentParser(description="Save CPU performance data as CSV or text table.")
parser.add_argument('--csv', action='store_true', help="Save the data as a CSV file")
parser.add_argument('--price-cap', type=float, default=float('inf'), help="Price cap to remove CPUs above this price")
args = parser.parse_args()

# Iterate through each CPU entry and extract the required data
for cpu in cpus:
    name = cpu.find("span", class_="prdname").text.strip()
    performance_text = cpu.find("span", class_="count").text.strip().replace(",", "")
    price_text = cpu.find("span", class_="price-neww").text.strip().replace("$", "").replace("*", "").replace(",", "")
    link = base_url + cpu.find("a")["href"]
    
    # Check if the performance and price are valid numbers
    try:
        performance = int(performance_text)
        price = float(price_text)
        if price <= args.price_cap:
            performance_per_dollar = round(performance / price, 2)
            cpu_data.append([name, performance, price, performance_per_dollar, link])
    except ValueError:
        continue  # Skip this CPU entry if performance or price is not a number

# Function to get multi-score from the CPU page
def get_multi_score(url):
    try:
        response = requests.get(url)
        response.raise_for_status()  # Check if the request was successful
        soup = BeautifulSoup(response.content, "html.parser")
        multi_score = soup.find("div", class_="right-desc").find_all("span")[1].text.strip()
        return int(multi_score.replace(",", ""))  # Ensure Multi-Score is treated as a number
    except Exception as e:
        return "N/A"

# Add multi-score to each CPU entry
for cpu in cpu_data:
    multi_score = get_multi_score(cpu[4])
    cpu.insert(2, multi_score)  # Insert Multi-Score at the 3rd column

# Sort the data by performance_per_dollar in descending order
cpu_data.sort(key=lambda x: x[4], reverse=True)

# Print the top 10 results to the console
print("Top 10 CPUs by Performance per Dollar:")
for cpu in cpu_data[:10]:
    print(cpu)

# Define a function to create a formatted text table
def create_text_table(data):
    # Calculate column widths
    col_widths = [max(len(str(cell)) for cell in col) for col in zip(*data)]
    format_str = " | ".join(["{:<" + str(width) + "}" for width in col_widths])
    line_str = "-+-".join(["-" * width for width in col_widths])
    
    # Create table
    table = []
    table.append(format_str.format(*data[0]))  # Header
    table.append(line_str)
    for row in data[1:]:
        table.append(format_str.format(*row))
    return "\n".join(table)

# Create the data for the table
table_data = [["CPU Name", "Performance", "Multi-Score", "Price ($)", "Performance per Dollar", "Link"]] + cpu_data

# Save data based on the argument flag
if args.csv:
    csv_file = "cpu_performance.csv"
    with open(csv_file, mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["CPU Name", "Performance", "Multi-Score", "Price ($)", "Performance per Dollar", "Link"])
        writer.writerows(cpu_data)
    print(f"Data has been written to {csv_file}")
else:
    txt_file = "cpu_performance.txt"
    with open(txt_file, mode="w") as file:
        file.write(create_text_table(table_data))
    print(f"Data has been written to {txt_file}")

