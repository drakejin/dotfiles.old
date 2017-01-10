
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'likemilk.fun25.co.kr',
  port     : '15406',
  user     : 'dydwls121200',
  password : 'dydrkf45',
  database : 'studySimpleProject'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
  if (err) throw err;

  console.log('The solution is: ', rows[0].solution);
});

connection.end();
