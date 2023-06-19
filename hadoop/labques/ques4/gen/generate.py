import csv
import random
from datetime import datetime, timedelta
import os

directory = "../input"
os.makedirs(directory, exist_ok=True)
file_path = os.path.join(directory, "input.csv")


event_types = ["INFO", "ERROR", "WARNING"]
descriptions = [
    "User logged in",
    "Page loaded",
    "Database connection failed",
    "Invalid input received",
    "User clicked on button",
    "Payment processing failed",
    "Failed to fetch data from API",
    "User logged out",
    "Password reset email sent",
    "Invalid login attempt detected",
    "User registration initiated",
    "Account created successfully",
]

with open(file_path, "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["timestamp", "event_type", "description"])

    current_time = datetime.utcnow()
    interval = timedelta(seconds=1)  # Adjust the interval as needed

    for _ in range(1000):
        timestamp = current_time.strftime("%Y-%m-%dT%H:%M:%SZ")
        event_type = random.choice(event_types)
        description = random.choice(descriptions)

        writer.writerow([timestamp, event_type, description])

        current_time += interval

