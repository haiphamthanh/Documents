var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var cookieParser = require('cookie-parser');

/* GET users listing. */
router.get('/', function(req, res, next) {
  console.log("Request URL: ", req.url);
  req.requestTime = new Date();

  var connection = mysql.createConnection({
    host: "localhost",
    connectionLimit: 10,
    acquireTimeout: 30000, //30 secs
    user: "root",
    password: "root",
    database: "testdb",
    port: "80"
  });
  connection.connect(function(err) {
    if (err) {
      console.error('error connecting: ', err);
      return;
    }
  });
  connection.query("SELECT * FROM tbl_sings", function(error, rows) {
    if(error) { console.log(error); }
   res.render('index', { title: "rows" });
   connection.end();
  });
  
  next();
});

module.exports = router;