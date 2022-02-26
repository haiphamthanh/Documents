var firstFunction = function() {
    console.log("FirstFunction")
}
var secondFunction = function() {
    setTimeout(firstFunction, 5000)
    console.log("SecondFunction")
}
secondFunction();

function demoCallback(callback) {
    callback("data");
}

demoCallback( function(data){
console.log(data)
})

