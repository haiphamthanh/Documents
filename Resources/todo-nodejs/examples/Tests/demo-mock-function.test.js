function forEach(items, callback) {
    for (let index = 0; index < items.length; index++) {
      callback(items[index]);
    }
  }
  
  test('test foreach', () => {
      const mockCallback = jest.fn(x => 99 + x);
      forEach([0, 1], mockCallback);
      // mock function được gọi 2 lần
      expect(mockCallback.mock.calls.length).toBe(2);
      // tham số thứ nhất của lần gọi đầu tiên là 0
      expect(mockCallback.mock.calls[0][0]).toBe(0);
      // tham số thứ nhất của lần gọi thứ 2 là 1
      expect(mockCallback.mock.calls[1][0]).toBe(1);
      // giá trị trả về của lần gọi đầu tiên là 42
      expect(mockCallback.mock.results[0].value).toBe(99);
      // giá trị trả về của lần gọi đầu tiên là 42
      expect(mockCallback.mock.results[1].value).toBe(100);
  });