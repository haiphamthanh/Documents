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

syncFunc = async function(data) {
    try {
      const result = await doubleFunc(data)
      return result
    } catch (err) {
      throw err
    }
}

module.exports.syncFunc = syncFunc;