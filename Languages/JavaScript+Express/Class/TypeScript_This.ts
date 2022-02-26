/**
 * Điểm khác biệt trong việc sử dụng this
 */

class MyClass {
  name = "MyClass"
  getName() {
    return this.name;
  }
  // Để đảm bảo problem 2 không được sử dụng (nhằm tránh sai sót)
  // Với cách này ta không thể gọi theo phương thức xxx.getNameFunc mà bắt buôc phải là xxx.getNameFunc()
  // Cách này có thể hiểu là binding trực tiếp đối tượng gọi hàm vào nên sẽ tránh sai sót
  // Ví dụ: Ở đây ta chỉ chấp nhận đối tượng gọi hàm getNameRightWay là MyClass mà thôi
  getNameRightWay(this: MyClass) {
    return this.name;
  }
  getNameArrow = () => {
    return this.name;
  };
}

function thisClass(): number {
    const myclass = new MyClass();
    const newObj = {
      name: "this is different name",
      getNameValue: myclass.getName(),
      getNameFunc: myclass.getName,
      getNameArrow: myclass.getNameArrow,
      getNameRightWay: myclass.getNameRightWay(),
    };
    
    //Problem 1: Nơi đây bạn khai báo biến là KẾT QUẢ của hàm số
    // Cho nên: this ở đây là đối tượng myclass
    console.log(newObj.getNameValue);

    //Problem 2: Nơi đây bạn khai báo biến là ĐỊNH NGHĨA một hàm số
    const sample = newObj.getNameFunc + ""
    console.log(sample);
    // Cho nên: this ở đây là đối tượng newObj
    // Giải thích: Điều gì khi bạn gọi thực thi newObj.getNameFunc()
    // 1. Gán giá trị cho getNameFunc = function getName() { return this.name; }, 
    //    1.1 getNameFunc được gọi là biến hàm
    // 2. Gọi thực thi biến hàm getNameFunc với cú pháp getNameFunc()
    //    2.1 Tất nhiên this trong trường hợp này sẽ là đối tượng chứa getNameFunc rồi
    //    2.2 Đối tượng chứa getNameFunc lúc này là newObj (điều cần chứng minh)
    console.log(newObj.getNameFunc())
    
    //Problem 3: Với cách sử dụng Arrow function sẽ đảm bảo gọi đúng lúc chạy
    // Cho nên: _this ở đây là đối tượng myclass
    // Nhận định: 
    //    1. Ta nhận thấy this lúc này trở thành _this
    //    2. Biến newObj tạo ra môt biến hàm getNameArrow là một COPY của hàm getNameArrow trong myclass
    // Do đó: Cách này sẽ tiêu tốn nhiều bộ nhớ hơn
    const sample1 = newObj.getNameArrow + ""
    console.log(sample1);
    console.log(newObj.getNameArrow())

    //Avoid problem 2
    const sample3 = newObj.getNameRightWay + ""
    console.log(sample3);
    console.log(newObj.getNameRightWay)


    return 1;
}

thisClass();

class BoxOther {
  content: string = "";
  // Cách này kiểm tra KHÔNG QUAN TÂM có cùng class hay không. Chỉ cần cùng lớp cha
  sameAs(other: BoxOther) {
    return this.content === other.content
  }

  // Cách này kiểm tra QUAN TÂM phải chính xác cùng lớp với nhau.
  sameAsDirived(other: this) {
    return this.content === other.content
  }
}
 
class DerivedBoxOther extends BoxOther {
  otherContent: string = "?";
}

const base = new BoxOther();
const derived = new DerivedBoxOther();
console.log(derived.sameAs(base));
// console.log(derived.sameAsDirived(base)); // Không thực hiện được vì lớp của đối tượng base khác với lớp đối tượng derived

/**
 * Sử dụng this để kiểm tra file
 * Tương tự như sử dụng guard let trong Swift
 */
class FileSystemObject {
  isFile(): this is FileRep {
    return this instanceof FileRep;
  }
  isDirectory(): this is Directory {
    return this instanceof Directory;
  }
  isNetworked(): this is Networked & this {
    return this.networked;
  }

  constructor(public path: string, private networked: boolean) {
  }
}

class FileRep extends FileSystemObject {
  constructor(path: string, public content: string) {
    super(path, false);
  }
}

class Directory extends FileSystemObject {
  children: FileSystemObject[]
}

interface Networked {
  host: string;
}

const fso: FileSystemObject = new FileRep("path", "foo")
if (fso.isFile()) {
  fso.content
} else if (fso.isDirectory()) {
  fso.children
} else if (fso.isNetworked()){
  fso.host
}

/**
 * Chưa hiểu nói gì nữa
 * A common use-case for a this-based type guard is to allow for lazy validation of a particular field. For example, this case removes an undefined from the value held inside box when hasValue has been verified to be true:
 */
class BoxOtherGeneric<T> {
  value?: T;
  hasValue(): this is { value: T} {
    return this.value !== undefined
  }
}

const boxOtherGeneric = new BoxOtherGeneric();
boxOtherGeneric.value = "Gameboy"
console.log(boxOtherGeneric.value) // (property) Box<unknown>.value?: unknown
if (boxOtherGeneric.hasValue()) {
  boxOtherGeneric.value // (property) value: unknown
}