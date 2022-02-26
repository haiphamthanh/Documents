const demo = require('../demo-promise');
test('test promise doublefunc', () => {
    return demo.doubleFunc(12).then(data => {
       expect(data).toBe(24);
    });
});