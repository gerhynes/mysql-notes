const faker = require("faker");
const mysql = require("mysql2");
require("dotenv").config();

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB
});

connection.connect();

const person = { email: faker.internet.email(), created_at: faker.date.past() };

connection.query(
  "INSERT INTO users SET ?",
  person,
  function (error, results, fields) {
    if (error) throw error;
    console.log(results);
  }
);

connection.end();
