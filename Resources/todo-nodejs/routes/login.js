var express = require('express');
var router = express.Router();

var controller = require("../Controllers/UserController");

router.get('/login', controller.render);
router.post('/login', controller.login);
router.get('/logout', controller.logout);
  module.exports = router;