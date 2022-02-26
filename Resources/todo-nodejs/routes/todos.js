var express = require('express');
var router = express.Router();

var controller = require("../Controllers/TodoController");

router.get('/inits', controller.init);

  router.get('/alls', controller.all);
  
  router.get('/:id', controller.viewOne);

  router.post('/', controller.create)

  router.put('/:id', controller.edit);

  router.delete('/:id', controller.delete);

  module.exports = router;