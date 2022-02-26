class PointA {
    x: number; // Không có dấu ! bắt buộc phải có giá trị khởi tạo (biến require)
    y: number; // (biến require)
    name!: string; // Có dấu ! không bắt buộc có giá trị khởi tạo (biến optional)
    readonly info: string; // Biến readonly

    private id: string; // Biến private
    protected phone: string; // Biến protected
    #forceId: string; // Biến private

    // info là biến optional có thể không truyền vào và được hiểu là undefined
    constructor(x: number, name: string, info?: string, y = 5) {
        this.id = "This is the simple private id but does not secure any more"
        this.#forceId = "This is the simple FORCE private id"
        this.x = x;
        this.y = y;
        this.name = name;

        if (info !== undefined) {
            this.info = info;
        }
    }

    // Cách khai báo instance method
    desc(): PointA {
        return this;
    }

    // Cách khai báo static method
    static staticMethod(): string {
        return "This is static method"
    }

    // Block in class
    static #count = 0;
    get count() {
        return PointA.#count;
    }
    // Khối block này sẽ gọi thực thi.
    // Đây cũng là một cách ta thiết đặt các giá trị lúc khởi tạo đối tượng.
    static {
        try {
            const lasIntances = 5;
            PointA.#count += lasIntances;
        } catch { }
    }
}

class Derived extends PointA {
    constructor(x: number, 
        name: string, 
        info?: string, 
        k = 5, 
        public readonly path: string = "This is readonly path") {
            super(x, name, info, k);
    }
}

function classMain(): number {
    const point = new Derived(3, "Minh", undefined);
    point.x = 10;
    console.log(point.desc().name);
    console.log(`${point.desc().name} is ${point.desc().info}`);
    console.log(Derived.staticMethod());
    console.log(point.count);

    // Các từ khoá private, protected chỉ giúp đỡ về mặt hình thức mà thôi
    // Lợi ích: Giúp tiếp cận nhanh từ người lập trình viên đã có kỹ năng lập trình hướng đối tượng
    // nhưng lúc chạy thật ta hoàn toàn có thể truy vấn ngay cả khi private
    // Ta có thể truy cập biến private thông qua cách
    console.log(point["id"])
    // Có một cách để private HOÀN TOÀN là sử dụng # phía trước biến đó.
    console.log(point["#forceId"])
    // Có thể sử dụng biến được khai báo trên constructor (mặc dù KHÔNG khai báo trong class)
    // Lưu ý: Biến phải đặt các prefix như: public, private, protected, or readonly
    console.log(point.path)

    return 1;
}

classMain();

/**
 * Cách khai báo class bằng một phương thức khác nữa
 */
const someClass = class<Type> {
    content: Type;
    constructor(value: Type) {
        this.content = value
    }
}
const m = new someClass("Some text"); // m: someClass<string>


/**
 * Mối liên hệ giữa các class với nhau
 * Có thể khai báo các class với nhau nếu 2 class trùng nhau về tên lẫn kiểu dữ liệu
 * TH1: Lớp có ít số biến hơn có thể khai báo bằng lớp có nhiều biến hơn.
 * TH2: Ngược lại: Không thể (vì không đủ số biến)
 * Giải thích: 
 *      1. Bản chất của JS chỉ nhìn nhận đối tượng dưới dạng các kiểu any cho nên nó không quan tâm về kiểu lắm.
 *      2. Việc không khai báo được ở đây là do số lượng biến không đáp ứng đủ mà thôi
 *      3. TH1 có thể khai báo là do Lớp nhiều có số lượng biến số trùng (tên + kiểu) và bao phủ được Lớp ít biến hơn.
 */

class Person {
    name: string;
    age: number
}

class Titan {
    name: string;
    age: number;
    behavior: string;
}

const p: Person = new Titan(); // Ok
const t: Titan = new Person(); // Not Ok

/**
 * Lưu ý: Empty class
 * Ta có thể viết empty class như bên dưới nhưng nó sẽ sử dụng đúng cho tất cả các trường hợp
 * Cũng chính vì lý do đó, nên hầu như nó không có ý nghĩa gì về mặt sử dụng
 * Tốt nhất là: ĐỪNG SỬ DỤNG NÓ
 *  */
class Empty {}
function fn(x: Empty) {
    // không có gì phải làm với x, vì vậy đừng sử dụng nó
}
// All Ok!
fn({})
fn(fn)
fn(1)
