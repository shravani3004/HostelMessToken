# Hostel Mess Token 

## About the Project
Hostel Mess Token is a simple web-based project developed using Java JSP and MySQL. I made this project to manage meal tokens for hostel students and store their meal details in a database.

## Features
- Enter student name and select a meal.
- Select the meal date.
- Save meal token details in the database.
- View saved token records.
- Filter records based on meal type.

## Technologies Used
- HTML and CSS
- Java JSP
- JDBC
- MySQL
- Apache Tomcat
- Maven

## Database
Database name: `hostel_mess_db`

Table name: `mess_token`

The table stores the student name, meal type, meal date, and token ID.

## How to Run the Project
1. Clone or download this repository.
2. Open the project in your code editor.
3. Create the database `hostel_mess_db` in MySQL.
4. Create the `mess_token` table using the SQL query provided in the project.
5. Update the database username and password in `result.jsp` if required.
6. Build the project using `mvn clean package`.
7. Copy the generated WAR file from the `target` folder to Tomcat's `webapps` folder.
8. Start Apache Tomcat and open the application in your browser.

## Learning Outcome
While developing this project, I learned the basics of JSP, JDBC, MySQL database connectivity, and deploying a Java web application using Apache Tomcat.
