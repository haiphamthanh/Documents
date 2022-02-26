var configValues = require("./config")
module.exports = {
    getDbConnectionString: function() {
        return `mongodb+srv://${configValues.username}:${configValues.password}@nodetestdb.ohhct.mongodb.net/${configValues.database}?retryWrites=true&w=majority`;
    }
}