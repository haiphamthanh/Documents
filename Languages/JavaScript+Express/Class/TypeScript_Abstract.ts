/**
 * Cách sử dụng Abstract
 * Abstract class xuất hiện trong JS và Java
 * Ở swift thì lại không có abstract
 * Còn ở C++ abstract được thể hiện thông qua các pure virtual function (Lớp con bắt buộc phải implement các function này, không sử dụng trực tiếp lớp cha)
 */

// Không thể sử dụng trực tiếp Abstract class
abstract class Base {
    abstract getName(): string;

    printName() {
        console.log('Hello fen: ' + this.getName());
    }
}

class DiveredBase extends Base {
    getName(): string {
        return "Hai";
    }
}

const b = new DiveredBase();
b.printName()

// Cách thức để khởi tạo một tuỳ biến class dựa vào abstract class của nó
// Một cách thông thường ta có thể sử dụng cách sau
// Cách số 1: (ctor: typeof Base)
// Cách số 2: (ctor: new () => Base) <-- Đây được gọi là "Abstract Construct Signatures"
function greet(ctor: new () => Base) {
    const instance = new ctor() // <= Cách số 1: Vấn đề là ta không thể khởi tạo trực tiếp kiểu này được
    instance.printName()
}
greet(DiveredBase)