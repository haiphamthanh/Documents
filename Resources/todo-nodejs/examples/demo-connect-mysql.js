
var mysql = require('mysql');
var pool  = mysql.createPool({
  host     : 'localhost',
  user     : 'root',
  password : '123',
  database : 'testdb'
});

pool.getConnection(function(err, connection) {
  // Use the connection
  connection.query('SELECT * FROM `tbl_sings`', function (error, results, fields) {
    // And done with the connection.
    connection.release();

    // Handle error after the release.
    if (error) throw error;
    console.log(results);
    pool.end();
    // Don't use the connection here, it has been returned to the pool.
  });
});