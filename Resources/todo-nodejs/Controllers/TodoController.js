
var express = require('express');
const { Error } = require('mongoose');
var router = express.Router();

var Todos = require("../models/TodoModel");

function initDatas(req, res) {
    var dataInits = [
        {
            text: "Tim hieu javascript",
            isDone: false
        },
        {
            text: "Tim hieu nodeJs",
            isDone: false
        },
        {
            text: "Tim hieu expressjs",
            isDone: false
        },
        {
            text: "lam demo",
            isDone: false
        }
    ];
    Todos.create(dataInits, function (err, results) {
        if (err) {
            res.status(500).json(err);
        }
    });
}

function getTodos (req, res) {
    Todos.find({userid: req.cookies.userid}, function (err, results) {
        if (err) {
            // res.status(500).json(err);
            throw err;
        }
        else {
            console.log(results);
            res.json(results);
        }
    });
}

function createNew(req, res) {
    console.log(req.cookies)
    var todo = {
        userid: req.cookies.userid,
        text: req.body.text,
        isDone: req.body.isDone
    }
    Todos.create(todo, function (err, result) {
      if (err) {
          res.status(500).json(err);
      } else {
          getTodos(req, res);
      }
  });
}

function getOne(req, res) {
    Todos.findById({_id: req.params.id}, function (err, results) {
        if (err) {
            res.status(500).json(err);
        }
        else {
            res.json(results);
        }
    });
}

function update(req, res) {
    if (!req.params.id) { res.status(500).send("ID is required!"); }
    else {
      Todos.updateOne({_id: req.params.id}, { 
          text: req.body.text,
          isDone: req.body.isDone
      }, function (err, result) {
          if (err) {
              res.status(500).json(err);
          } else {
              getTodos(req, res);
          }
      })
    }
}

function remove(req, res){
    Todos.remove({
        _id: req.params.id
    }, function (err, result) {
      if (err) {
          throw err;
      } else {
          getTodos(req, res);
      }
  });
}

module.exports = {
    init: initDatas,
    all: getTodos,
    viewOne: getOne,
    create: createNew,
    edit: update,
    delete: remove
};