/**
 * Căn bản trong TypeScript và cách sử dụng
 * Tham khảo: 
 *  https://levunguyen.com/laptrinhjavascript/2021/03/05/su-dung-toan-tu-trong-typescript/
 *  https://viblo.asia/p/kieu-du-lieu-nan-trong-javascript-mot-cai-nhin-sau-sac-WEMGBVZBGQK
 *  https://viblo.asia/p/javascript-null-undefined-va-nan-4dbZNwLklYM
 * Điều kiện tiên quyết để chạy file này: Sử dụng Quokka (https://quokkajs.com/)
 */

function primatiesType() {
    // Cách define một biến <var - let - const>
    var sampleVar = 10;
    let sampleLet = "10";
    const sampleConst = '10';

    //1. Kiểu boolean
    let isBool = true;
    
    //2. Kiểu dữ liệu number
    let decima  = 6;        // x10
    let hex     = 0xf00d;   // x16
    let binary  = 0b1010;   // x2
    let octal   = 0o744;    // x8

    //3. Kiểu dữ liệu string
    let color   = "blue";
    let brand   = 'Ford';

    //4. Kiểu dữ liệu array
    let list: number[] = [1, 2, 3];
    let array: Array<number> = [1, 2, 3];

    //5. Kiểu dữ liệu tupe (định nghĩa một block các biến)
    let student: [string, number];
    student = ["Nam", 10]
    console.log(`${student[0]} got ${student[1]} score`)

    //6. Kiểu dữ liệu enum
    enum Color { red = 'red', green = 'green', blue = 'blue' };
    enum Sex { male, female, other };
    let c = Color.green;
    let s = Sex.female;
    console.log(`${s} got ${c} color`)

    //7. Kiểu dữ liệu any
    let notSure: any = 4;
    notSure = "maybe a string instead";
        console.log(notSure)
    notSure = false;
        console.log(notSure)
    notSure = 10;
        console.log(notSure)
    
    let listNotSure: any[] = [1, true, "free"];
    listNotSure[1] = 100;
    console.log(listNotSure)

    //8. Kiểu dữ liệu void

    //9. Kiểu dữ liệu undefined
    let u: undefined = undefined;

    //10. Kiểu dữ liệu null
    let n: null = null;
    
    //11. Template literals (Template strings)
    let result = 10;
    console.log(`result is ${result}`);
    console.log(`result is ` + result);

    //12. Kiểu dữ liệu NaN
    /**
     * Đầu tiên, NaN không phải là một từ khóa trong JavaScript giống như true, false, null ... 
     * mà nó là một thuộc tính của global object. 
     * Giá trị của NaN giống như giá trị của Number.NaN
     * Ý nghĩa: Sinh ra khi một kết quả tạo ra một số không xác định
     */
    // Giới hạn của số học
    let number1 = (3.2317006071311 * 10e616) / (3.2317006071311 * 10e616);
    console.log(number1);
    // NaN không có thứ tự
    console.log(NaN < 1);
    console.log(NaN > 1);
    console.log(NaN == NaN);
    console.log(NaN === NaN);
    console.log(NaN != NaN);
    
    /**
     * isNaN() là phương thức kiểm tra NaN trong phạm vi global: 
     * trước tiên nó sẽ kiểm tra xem giá trị đó có phải number hay không, 
     * nếu không thì sẽ chuyển đổi để trả về kết quả 
     * Xem chi tiết các bước tại: https://262.ecma-international.org/6.0/#sec-isnan-number.
     * Một số ví dụ:
     */
    isNaN(NaN);           // true
    isNaN(1);             // false: 1 is a number
    isNaN(-2e-4);         // false: -2e-4 is a number (-0.0002) in scientific notation
    isNaN(Infinity);      // false: Infinity is a number
    isNaN(true);          // false: converted to 1, which is a number
    isNaN(false);         // false: converted to 0, which is a number
    isNaN(null);          // false: converted to 0, which is a number
    isNaN("");            // false: converted to 0, which is a number
    isNaN(" ");           // false: converted to 0, which is a number
    isNaN("45.3");        // false: string representing a number, converted to 45.3
    isNaN("1.2e3");       // false: string representing a number, converted to 1.2e3
    isNaN("Infinity");    // false: string representing a number, converted to Infinity
    isNaN(new Date);      // false: Date object, converted to milliseconds since epoch
    isNaN("10$");         // true: conversion fails, the dollar sign is not a digit
    isNaN("hello");       // true: conversion fails, no digits at all
    isNaN(undefined);     // true: converted to NaN
    isNaN();              // true: converted to NaN (implicitly undefined)
    isNaN(function(){});  // true: conversion fails
    isNaN({});            // true: conversion fails
    isNaN([1, 2]);        // true: converted to "1, 2", which can't be converted to a number

    /**
     * Phương thức Number.isNaN() khác với hàm kiểm tra isNaN() được viết sẵn như ở trên, 
     * nó sẽ trả về False với bất kì giá trị nào không thuộc kiểu number mà không ép kiểu cho nó. 
     * Chỉ có NaN mới đưa ra kết quả true cho phương thức này.
     */
     Number.isNaN(NaN);         // true
     Number.isNaN(1);           // false
     Number.isNaN(-2e-4);       // false
     Number.isNaN(Infinity);    // false
     Number.isNaN(true);        // false
     Number.isNaN(false);       // false
     Number.isNaN(null);        // false
     Number.isNaN("");          // false
     Number.isNaN(" ");         // false
     Number.isNaN("45.3");      // false
     Number.isNaN("1.2e3");     // false
     Number.isNaN("Infinity");  // false
     Number.isNaN(new Date);    // false
     Number.isNaN("10$");       // false
     Number.isNaN("hello");     // false
     Number.isNaN(undefined);   // false
     Number.isNaN();            // false
     Number.isNaN(function(){});// false
     Number.isNaN({});          // false
     Number.isNaN([]);          // false
     Number.isNaN([1]);         // false
     Number.isNaN([1, 2]);      // false
     Number.isNaN([true]);      // false
}

function operations() {
    //-----> 1. Toán tử số học
    var x = 5, y = 10;
    x + y;  //returns 15
    y - x;  //returns 5
    x * y;  //returns 50
    y / x;  //returns 2
    x % 2;  //returns 1 (Chia lấy dư)
    x++;    //returns 6 (Gán rồi mới cộng)
    ++x;    //returns 7 (Cộng rồi mới gán)
    x--;    //returns 6
    --x;    //returns 5

    //-----> 2. Toán tử gán
    var x = 5, y = 10;
    x = y;  //x would be 10
    x += 1; //x would be 6
    x -= 1; //x would be 4
    x *= 5; //x would be 25
    x /= 5; //x would be 1
    x %= 2; //x would be 1

    //-----> 3. Toán tử so sánh
    var a = 5, b = 10, c = "5";
    var x = a;
    a == c;     // returns true
    a === c;    // returns false
    a == x;     // returns true
    a != b;     // returns true
    a > b;      // returns false
    a < b;      // returns true
    a >= b;     // returns false
    a <= b;     // returns true
    a >= c;     // returns true
    a <= c;     // returns true

    //-----> 4. Toán tử logic
    var a = 5, b = 10;
    (a != b) && (a < b);    // returns true
    (a > b) || (a == b);    // returns false
    (a < b) || (a == b);    // returns true
    !(a < b);               // returns false
    !(a > b);               // returns true

    //-----> 5. Toán tử tam phân
    var a = 10, b = 5;
    let cond = a > b
    var result1 = cond ? a : b; // value of result1 would be 10
    var result2 = cond ? b : a; // value of result2 would be 5

    //-----> 6. Toán tử type
    //6.1 Toán tử in
    let Bike = {make: 'Honda', model: 'CLIQ', year: 2018};
    let value = 'make' in Bike;
    console.log(value)
    //6.2 Toán tử delete
    delete Bike.make;
    console.log(Bike); 
    //6.3 Toán tử typeof
    console.log(typeof(Bike))

    //-----> 3. Kiểm tra
    //3.1 Rỗng - A falsy value (https://developer.mozilla.org/en-US/docs/Glossary/Falsy)
    let emptyString = "";
    let stringValue = 'Some';
    let nullString = undefined;
    if (emptyString) {
        console.log('is a falsy value')
    }
    if (!emptyString) { // Kiểm tra tất cả theo điều kiện falsy value
        console.log('is a falsy value')
    }
    if (!(nullString === "")) { // Chỉ kiểm tra empty, không kiểm tra null, undef...
        console.log('is a falsy value')
    }
    if (stringValue) {
        console.log('is a truly value')
    }
    
    //3.2 Kiểm tra null và undefined
    // đối tượng null       đại diện cho reference dẫn đến một object hoặc address không tồn tại hoặc không có giá trị
    // đối tượng undefined  đại diện cho một đối tượng được khai báo nhưng không được gán giá trị
    let nullValue = null
    let undefValue = undefined
        //3.2.1- Phủ định đều là true. Đều đại diện cho một cái gì đó không tồn tại…
    console.log('!null = ' + !nullValue)
    console.log('!undefined = ' + !undefValue)
        //3.2.2- Kiểm tra Null một cách strictly (nghiêm ngặt)
    if (nullValue === null) {
        console.log('is a null value')
    }
        //3.2.3- Khai báo không gán giá trị -> Undefined
    let foo;
    console.log('không gán giá trị is undefined?', foo === undefined);
    console.log('không gán giá trị is null?', foo === null);
        //3.2.4- Thuộc tính không tồn tại -> Undefined
    let foo1 = { a: 'a' };
    console.log('Thuộc tính không tồn tại is undefined?', foo1.b === undefined);
    console.log('Thuộc tính không tồn tại is null?', foo1.b === null);
        //3.2.5- Hàm không trả về giá trị -> Undefined
    function foo2() { return; }
    console.log('Hàm không trả về giá trị is undefined?', foo2() === undefined);
    console.log('Hàm không trả về giá trị is null?', foo2() === null);
        //3.2.5- Giá trị tham số của hàm đã được khai báo nhưng bị bỏ qua khi gọi hàm -> Undefined
    function foo3(param) {
        console.log('is undefined?', param === undefined);
    }
    foo3('a');
    foo3();
        //3.2.6- (Only in browsers) undefined cũng là một thuộc tính của global window object
    // console.log(window.undefined); // undefined
    // window.hasOwnProperty('undefined');  // true
    
    //3.3 So sánh null và undefined
        //3.3.1- Về giá trị là như nhau
    console.log('null và undefined so sánh (giá trị) == là ', null == undefined);
    console.log('null và undefined so sánh (cùng kiểu) === là ', null === undefined);
        //3.3.2- Tính toán
        // Null đưa về 0
        // Undefined trả về NaN (Do chưa xác định kiểu)
    let numberToCheckNull = null + 5;
    let numberToCheckUndefined = undefined + 5;
    console.log(numberToCheckNull);
    console.log(numberToCheckUndefined);

    //3.4 Kiểu dữ liệu NaN
    console.log(isNaN(NaN));
    console.log(isNaN(6+""));

}

function mainBasis(): number {
    primatiesType();
    operations();
    return 0;
}

mainBasis()