import axios from 'axios';
class Users {
  static all() {
    return axios.get('/users').then(resp => resp.data);
  }
}
export default Users;