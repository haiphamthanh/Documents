var mongoose = require("mongoose");
var config = require("../config");
var Todos = require("../models/TodoModel");

//console.log(config.getDbConnectionString());
mongoose.connect(config.getDbConnectionString(), { useNewUrlParser: true, useUnifiedTopology: true });
Todos.find(function(error, result) { console.log(result) });