const cassandra = require('cassandra-driver');

const client = new cassandra.Client({
  contactPoints:['127.0.0.1:9042'],
  localDataCenter: 'datacenter1',
  credentials: { username: 'tphuong', password: 'tphuong' }
});

client.execute('SELECT * FROM tphuongdb.tbl_sings', function(err, data) {
      if (err) {
          // handle error
          console.log('handle error.', err)
      } else {
          console.log('handle success.', data)
          // handle success.
      }
  });