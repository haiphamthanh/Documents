#  Tiếp cận vấn đề từ ngôn ngữ Swift
[Link tham khảo về TypeScript-Class](https://www.typescriptlang.org/docs/handbook/2/classes.html)

* Javascript sử dụng this thay vì sử dung self như ở Swift.
* các properties trong Class không sử dụng var - let hay constant gì cả.

`Why No Static Classes?`
```
TypeScript (and JavaScript) don’t have a construct called static class the same way C# and Java do.

Those constructs only exist because those languages force all data and functions to be inside a class; because that restriction doesn’t exist in TypeScript, there’s no need for them. A class with only a single instance is typically just represented as a normal object in JavaScript/TypeScript.

For example, we don’t need a “static class” syntax in TypeScript because a regular object (or even top-level function) will do the job just as well:

// Unnecessary "static" class
class MyStaticClass {
  static doSomething() {}
}
 
// Preferred (alternative 1)
function doSomething() {}
 
// Preferred (alternative 2)
const MyHelperObject = {
  dosomething() {},
};
```