var express = require('express');
const { Error } = require('mongoose');
var router = express.Router();

var Users = require("../models/UserModel");

function init(req, res) {
    res.render('login', {
        errorMessage: ''
    });
}

function logout(req, res) {
    res.clearCookie('userid', {path:'/'});
    res.clearCookie('email', {path:'/'});
    res.redirect('/login');
}

function login(req, res, next) {
    console.log(req.body.email);
    if (!req.body.email || !req.body.password) { 
        res.render('login', {
            errorMessage: 'Cần nhập đủ email & password!'
        });
        return; 
    }
    Users.findOne({ email: req.body.email , password: req.body.password})
        .then(user => {
            console.log(user)
            if (!user) {
                res.render('login', {
                    errorMessage: 'Email hoặc mật khẩu không đúng!'
                });
                return;
            }
            res.cookie('userid', user._id);
            res.cookie('email', user.email);
            res.redirect('/home');
        })
        .catch(next);
}

module.exports = {
    render: init,
    login: login,
    logout: logout
};