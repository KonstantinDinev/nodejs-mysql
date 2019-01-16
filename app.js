const faker = require('faker');
const mysql = require('mysql');


const connection = mysql.createConnection({
    host: 'localhost',
    user: 'corleozo',
    database: 'join_us'
});

let data = [];

for (let i = 0; i < 500; i++) {
    data.push([
        faker.internet.email(),
        faker.date.past()
    ]);
}

let insertQuery = 'INSERT INTO users (email, created_at) VALUES ?';
// connection.query('INSERT INTO users SET ?', person, function(err, result) { if(err) throw err; }

// INSERTING DATA TAKE 2
const person = {email: faker.internet.email()};
var end_result = connection.query(insertQuery, [data], function(err, result) {
  if(err) throw err;  
  console.log(result);
});

//console.log(end_result.sql);

let q = `SELECT 
            DATE_FORMAT(created_at, "%m-%D-%Y") AS created_at, 
            email 
        FROM users 
        ORDER BY created_at 
        DESC LIMIT 50`;

connection.query(q, (error, results, fields) => {
    if (error) throw error;
    
    data = results;
    //console.log(data);
    
    for(let i = 0; i < results.length; i++) {
        console.log(`${results[i].created_at}: ${results[i].email}`);
    }
    
    //console.log(` time = ${data.time}\n date - ${data.date}\n now = ${data.now}`);
});

connection.end();

// To DROP the data -> DELETE FROM users;



// for(let i = 0; i < 100; i++)
//     console.log(faker.address.city());


//var q = 'SELECT CURTIME() AS time, CURDATE() as date, NOW() as now';
//var q = 'SELECT DATABASE() AS db';

// var insertDataQuery = 'INSERT INTO users (email) VALUES ("inserted@js.js")';

// connection.query(insertDataQuery, function (error, results, fields) {
//   if (error) throw error;
//   console.log(results);
// });