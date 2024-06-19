# Railway-Management-SQL
This project aims to manage various aspects of a railway system through a MySQL database-backed application and a web interface. The system includes functionalities for managing passengers, trains, bookings, payments, and user authentication. Here’s an overview of its key features and components:

Database Schema
The MySQL database schema includes the following tables:

Passenger: Stores details about passengers such as name, address, gender, and age.
Train: Contains information about trains including train number, name, source, destination, timings, and available seats.
Ticket: Tracks booked tickets linking passengers and trains.
Payment: Records payments associated with booked tickets.
Traveller: Records historical data of passengers' travel details.
User_tables: Manages user credentials for system access.
Triggers and Views
The project utilizes triggers for automatic updates:

update_seats_available: Adjusts available seats in a train after a new ticket booking.
update_seats_cancelled: Updates available seats when a ticket is cancelled.
A view named booked_tickets_view provides a consolidated view of booked tickets, combining data from passengers, tickets, and trains.

Server-side Application (Node.js)
The backend server, built with Node.js and Express, interacts with the MySQL database to handle various operations:

GET endpoints retrieve data such as all passengers, all trains, and passengers by gender.
POST endpoint adds a new passenger to the database.
Frontend (HTML/CSS/JavaScript)
The frontend interface allows users to:

View all passengers registered in the system.
List all trains along with their details.
Filter and display passengers based on gender.
Add new passengers through a form.
Security and Access Control
The project implements user roles and privileges:

A role named railwayadmin with full privileges on the railway_system database.
User authentication ensures secure access to the system.
Project Components
Database Initialization: Creates necessary tables, triggers, views, and initial data.
Server Configuration: Connects the Node.js server to the MySQL database.
Frontend Interface: Provides a user-friendly interface for interacting with the railway system.
Usage
To run the project:

## How to Run ?
Initialize the MySQL database with the provided schema and initial data using workbench/MySQL-Command_Line.
Configure and start the Node.js server (server.js).
Access the web interface by going to (http://localhost:3000) in any browser.
This railway management system project aims to make prototype of railway admin portal which uses my sql.
