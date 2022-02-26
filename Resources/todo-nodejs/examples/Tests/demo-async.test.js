const demo = require('../demo-async');

test('test async', async () => {
    const data = await demo.syncFunc(12);
    expect(data).toBe(24);
});