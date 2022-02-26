const MongoClient = require('mongodb').MongoClient;
const config = require("../config")

const uri = config.getDbConnectionString();
//console.log(config.getDbConnectionString());
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
  const collection = client.db(config.database).collection("collection1");
  // perform actions on the collection object
  console.log(collection);
  client.close();
});