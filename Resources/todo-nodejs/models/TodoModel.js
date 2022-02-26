var mongoose = require("mongoose");

var Schema = mongoose.Schema;
var todoSchema = new Schema({
    userid: String,
    text: String,
    isDone: Boolean
});

var Todos = mongoose.model("todos", todoSchema);
module.exports = Todos;