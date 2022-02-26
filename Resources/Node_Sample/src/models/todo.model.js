const mongoose = require('mongoose')

const { Scheme } = mongoose;

const todoScheme = Scheme({
    name: String
})

const TodoModel = mongoose.model("Todos", todoScheme, "todos")
export default TodoModel