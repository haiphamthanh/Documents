import axios from 'axios';
import Users from '../demo-mock-module';

jest.mock('axios');
test('fetch users thanh cong', () => {
  const users = [{name: 'Tan'}];
  const resp = {data: users};
  axios.get.mockResolvedValue(resp);
  return Users.all().then(data => expect(data).toEqual(users));
});