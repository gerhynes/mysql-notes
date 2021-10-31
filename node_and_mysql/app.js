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

// =======================
// Inserting one user
// =======================

// const person = { email: faker.internet.email(), created_at: faker.date.past() };

// const end_result = connection.query(
//   "INSERT INTO users SET ?",
//   person,
//   function (error, results, fields) {
//     if (error) throw error;
//     console.log(results);
//   }
// );

// // View the SQL query you created
// console.log(end_result.sql);

// =======================
// Bulk inserting 500 rows
// =======================
const data = [];

for (let i = 0; i < 500; i++) {
  data.push([faker.internet.email(), faker.date.past()]);
}

// Create query
const q = "INSERT INTO users (email, created_at) VALUES ?";

// Execute query
connection.query(q, [data], function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});

connection.end();
