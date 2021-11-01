const express = require("express");
const faker = require("faker");
const mysql = require("mysql2");
require("dotenv").config();

const app = express();
const port = 3000;

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
    const msg = "We have " + results[0].count + " users";
    res.send(msg);
  });
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
