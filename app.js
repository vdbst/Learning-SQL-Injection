const express = require("express");
const app = express();
const mysql = require("mysql");
const db = require("./db.js");
const conn = mysql.createConnection(db);

// check database connection
conn.ping((err) => {
    if (err) {
        console.log("Could not connect to database: " + err);
        process.exit(1);
    }
});

app.use(express.static("public"));

app.get("/hw", function (req, res) {
    const query = "SELECT name, stock, price FROM product WHERE name LIKE '%" + req.query.name + "%'";
    console.log("Executed query: " + query);
    conn.query(query, [], (err, rows) => {
        if (err) {
            console.log("    Error: " + err.message);
            res.status(500).send(err.message);
        } else {
            res.status(200).json(rows);
        }
    });
});

app.listen(3000, "localhost", function () {
    console.log("Learning SQL Injection app listening on port 3000!");
    console.log("Go to http://localhost:3000");
});
