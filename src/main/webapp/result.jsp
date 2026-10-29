<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>

<html>
<head>
    <title>Hostel Mess Token</title>

    <style>
        body {
            font-family: Arial;
            background: #eaf2f8;
            padding: 20px;
        }

        h2 {
            color: #174a7e;
            text-align: center;
        }

        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid gray;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #174a7e;
            color: white;
        }

        button {
            padding: 8px 15px;
            background: #174a7e;
            color: white;
            border: none;
        }

        .box {
            max-width: 800px;
            margin: auto;
        }
    </style>
</head>

<body>
<div class="box">

<h2>Hostel Mess Token Records</h2>

<%
    String url = "jdbc:mysql://localhost:3307/hostelmess_db";
    String user = "root";
    String password = "shravani30";

    String message = "";
    String selectedMeal = request.getParameter("filterMeal");

    if (selectedMeal == null || selectedMeal.equals("")) {
        selectedMeal = "All";
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(url, user, password);

        if ("POST".equalsIgnoreCase(request.getMethod())) {

            String student = request.getParameter("student");
            String meal = request.getParameter("meal");
            String date = request.getParameter("meal_date");

            if (student == null || student.trim().isEmpty()
                    || meal == null || date == null || date.isEmpty()) {

                message = "Please fill all fields";

            } else if (LocalDate.parse(date).isAfter(LocalDate.now())) {

                message = "Future date is not allowed";

            } else {

                String insert = "INSERT INTO mess_token(student, meal, meal_date) VALUES (?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(insert);

                ps.setString(1, student.trim());
                ps.setString(2, meal);
                ps.setDate(3, Date.valueOf(date));

                ps.executeUpdate();
                ps.close();

                message = "Token saved successfully";
            }
        }
%>

<p><b><%= message %></b></p>

<p>
    <a href="index.html">Add New Token</a>
</p>

<form action="result.jsp" method="get">
    Filter by Meal:

    <select name="filterMeal">
        <option value="All" <%= selectedMeal.equals("All") ? "selected" : "" %>>All</option>
        <option value="Breakfast" <%= selectedMeal.equals("Breakfast") ? "selected" : "" %>>Breakfast</option>
        <option value="Lunch" <%= selectedMeal.equals("Lunch") ? "selected" : "" %>>Lunch</option>
        <option value="Dinner" <%= selectedMeal.equals("Dinner") ? "selected" : "" %>>Dinner</option>
    </select>

    <button type="submit">Show</button>
</form>

<br>

<table>
    <tr>
        <th>ID</th>
        <th>Student</th>
        <th>Meal</th>
        <th>Date</th>
    </tr>

<%
    String sql = "SELECT * FROM mess_token";

    if (!selectedMeal.equals("All")) {
        sql += " WHERE meal = ?";
    }

    sql += " ORDER BY id";

    PreparedStatement ps2 = con.prepareStatement(sql);

    if (!selectedMeal.equals("All")) {
        ps2.setString(1, selectedMeal);
    }

    ResultSet rs = ps2.executeQuery();

    int count = 0;

    while (rs.next()) {
        count++;
%>

    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("student") %></td>
        <td><%= rs.getString("meal") %></td>
        <td><%= rs.getDate("meal_date") %></td>
    </tr>

<%
    }

    if (count == 0) {
%>
    <tr>
        <td colspan="4">No records found</td>
    </tr>
<%
    }
%>

</table>

<p><b>Total records: <%= count %></b></p>

<%
    rs.close();
    ps2.close();
    con.close();

    } catch (Exception e) {
%>

<p>Database Error: <%= e.getMessage() %></p>

<%
    }
%>

</div>
</body>
</html>
