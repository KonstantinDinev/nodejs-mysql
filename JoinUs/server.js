var express = require('express');
var mysql = require('mysql');
var bodyParser = require("body-parser");
var app = express();

// To extract info from post request (req.body as js)
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + "/public"));
app.set("view engine", "ejs");

var connection = mysql.createConnection({
   host: 'localhost',
   user: 'corleozo',
   database: 'join_us'
});

app.get("/", function(req, res) {
   var q = "SELECT COUNT(*) AS total_users FROM users";
   connection.query(q, function(err, results) {
       if (err) throw err;
       //res.send("Number of registered users: " + results[0].total_users);
       let count = results[0].total_users;
       
       res.render("home", {data: count, dateNow: Date(Date.now()).toString() });
   });
});

app.get("/joke", function(req, res) {
    var joke = "What do you call a dog that does magic tricks? <br>A labracadabrador.";
    res.send(joke);
});

app.get("/random_num", function(req, res) {
    var rNumb = Math.floor(Math.random() * 100) + 1;
    res.send(`${rNumb}`);
});

app.post("/register", function(req, res) {
    console.log(req.body);
    console.log("POST REQUEST SENT TO /REGISTER email is " + req.body.formEmail);
    
    var person = {
        email: req.body.formEmail
    };
    
    connection.query('INSERT INTO users SET ?', person, function(err, result) {
        if (err) throw err;
        console.log(result);
        
        //res.send("Thanks for joining our wait list!");
        res.redirect("/");
    });
});

app.listen(8080, function(){
    console.log("Server running on port 8080!");
});