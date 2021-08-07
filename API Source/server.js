// Modules

const express = require("express");
const mysql = require('mysql');
const bodyParser = require('body-parser');

// Create Web Server

const app = express();
const port = 25565;

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/", (request, response) => {
    response.send("BloxSql Database");
});

const listener = app.listen(port, () => {
    console.log("BloxSQL API is listening on " + port);
});

// Default

app.post("/v1/", async (request, response) => {
    const host = request.body.Host;
    const user = request.body.Username;
    const password = request.body.Password;
    const database = request.body.Database;

    const con = mysql.createConnection({
        host, user, password, port, database
    });
    try {
        con.connect(function(err) {
            if (err) console.log('Database Connection ERROR for ' + host + " Error: " + err)
            else console.log('Database Connection SUCCESS for ' + host)
        });
    } catch (error) {
        console.log('Error was caught!')
    }

    const querySQL = request.body.Query

    try {
        con.query(querySQL, (err, result, fields) => {
            if (err) response.send("Error finishing request! Error: " + err);
            else response.json(result);
        });
    } catch (error) {
        console.log(error)
    }

    con.end()
});

app.get("/v1/", async (request, response) => {
    response.send("This function only works for POST!")
});