require("dotenv").config();
const express = require("express");
const faker = require("faker");
const mysql = require("mysql2");
const bodyParser = require("body-parser");

const app = express();
const port = 3000;

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB
});

connection.connect();

app.get("/", function (req, res) {
  // Find count of users in DB
  const q = "SELECT COUNT(*) as count FROM users";
  connection.query(q, function (error, results) {
    if (error) throw error;
    const count = results[0].count;
    res.render("home", { count });
  });
});

app.post("/register", function (req, res) {
  const person = { email: req.body.email };
  connection.query(
    "INSERT INTO users SET ?",
    person,
    function (error, results, fields) {
      if (error) throw error;
      console.log(results);
      res.redirect("/");
    }
  );
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
