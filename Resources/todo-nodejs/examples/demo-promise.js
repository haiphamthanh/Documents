doubleFunc = function(number) {
    return new Promise((resolve, reject) => {
        if(number%2 == 0) {
            resolve(number*2)
        }
        else {
            reject("error 1")
        }
    })
}

navFunc = function(number) {
    return new Promise((resolve, reject) => {
      if(number%2 == 0) {
          resolve(-number)
      }
      else {
          reject("error 2")
      }
    })
}

module.exports.doubleFunc = doubleFunc;
module.exports.navFunc = navFunc;