// mock.test.js
jest.mock('../demo-mock-implement');
const testImplement = require('../demo-mock-implement');

testImplement.mockImplementation(() => true);
testImplement();
// ==> true
test('test promise doublefunc', () => {
    const data = testImplement();
    return expect(data).toBe(true);
});