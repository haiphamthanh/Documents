const myMock = jest.fn();
const valueA = new myMock();
const valueB = {};
const bound = myMock.bind(valueB);
bound();
console.log(myMock.mock.instances);
// console.log
//[ mockConstructor {}, {} ]
