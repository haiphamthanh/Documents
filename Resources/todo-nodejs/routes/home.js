var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  if (req.cookies.userid && req.cookies.email) {
    res.redirect("/home")
  }
  else {
    res.redirect("/login")
  }
});

/* GET home page. */
router.get('/home', function(req, res, next) {
  // res.render('home', { todoNumber = "5"});
  // console.log("router.get('/', function(req, res, next) {")
  res.render('home', { title: `Welcome ${req.cookies.email}!!!` });
});



module.exports = router;
