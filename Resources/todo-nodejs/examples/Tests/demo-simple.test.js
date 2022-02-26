const demoSimple = require('../demo-simpleTest');

test('add two number', () => {
    return expect(demoSimple.addFunc(2, 3)).toBe(5);
});

test('null', () => {
    const n = null;
    expect(n).toBeNull();
    expect(n).toBeDefined();
    expect(n).not.toBeUndefined();
    expect(n).not.toBeTruthy();
    expect(n).toBeFalsy();
});
  
test('zero', () => {
    const z = 0;
    expect(z).not.toBeNull();
    expect(z).toBeDefined();
    expect(z).not.toBeUndefined();
    expect(z).not.toBeTruthy();
    expect(z).toBeFalsy();
});

test('test matching number', () => {
    const value = 2 + 2;
    expect(value).toBeGreaterThan(3);
    expect(value).toBeGreaterThanOrEqual(3.5);
    expect(value).toBeLessThan(5);
    expect(value).toBeLessThanOrEqual(4.5);
  
    // Với dữ liệu dạng số thì các bạn có thể dùng toBe hoặc toEqual
    // để so sánh bằng đều được
    expect(value).toBe(4);
    expect(value).toEqual(4);
});

test('contain I', () => {
    expect('team').not.toMatch(/I/);
});
  
test('Not contain abc', () => {
    expect('Sabcdasdas').toMatch(/abc/);
});

test('contain abc', () => {
    expect(['abc', 'xyz']).toContain('abc');
});

function divideByZero() {
    throw new Error('can not devide to 0');
}
  
test('test throw exeption divideByZero', () => {
    expect(() => divideByZero()).toThrow();
    expect(() => divideByZero()).toThrow(Error);
  
    // compare message or use regex
    expect(() => divideByZero()).toThrow('can not devide to 0');
    expect(() => divideByZero()).toThrow(/can not/);
});





  







