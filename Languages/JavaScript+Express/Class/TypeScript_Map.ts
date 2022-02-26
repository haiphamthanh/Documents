/**
 * Cách sử dụng Map và WeakMap
 * Kiểu map: được hiểu như kiểu dữ liệu dictionary, quản lý dữ liệu thông qua các cặp {key, value}
 */

// Sử dụng trực tiếp dictionary
let john = { name: "John" };
let array = [ john ];
john = null; // overwrite the reference
console.log(array[0].name)
// => john is stored inside the array, so it won't be garbage-collected
// => we can get it as array[0]

/**
 * Phương pháp sử dụng MAP
 * Giá trị bên trong map tồn tại song song với các biến đưa vào (CÓ retain)
 * Do CÓ retain count nên nếu biến tương ứng bị xoá thì trong map KHÔNG bị xoá đi.
 * Sử dụng phương thức get-set để đưa dữ liệu vào map và lấy dữ liệu ra
 */
// Sử dụng thông qua Map
// Set đối tượng làm map.set(john1, "Tên John") // key là đối tượng john1, value là "Tên John"
var john1 = { name: "John" };
let map = new Map();
map.set(john1, "Tên John");
console.log(john1)
console.log(map.has(john1))
// Huỷ đối tượng nhưng trong map vẫn còn giữ các key đã set
john1 = null; // overwrite the reference
console.log(map)
// Do key của map liên kết với đối tượng (tham chiếu) 
// Nên việc khởi tạo lại key như ban đầu là không thể
john1 = { name: "Tên John" };
console.log(map.has(john1))

// Thay vào đó có thể duyệt tìm key và lấy lại tham chiếu ban đầu
let keys = Array.from( map.keys() );
for (let key of keys) {
    john1 = key
}
console.log(john1)
console.log(map.has(john1))
// Cách thức lấy dữ liệu trong MAP (Giả sử thêm vào map một đối tượng khác)
let it = map.keys();
map.set({ name2: "Merry" }, "Tên Merry");
console.log(it);
console.log(it.next().value["name"])
console.log(it.next().value["name2"])

map.forEach(function(value, key, map) {
    console.log(value)
})
// => john is stored inside the map,
// => we can get it by using map.keys()


/**
 * Phương pháp sử dụng WEAKMAP tránh memory leak
 * Giá trị bên trong weakmap tồn tại song song với các biến đưa vào (KHÔNG retain)
 * Do KHÔNG retain count nên nếu biến tương ứng BỊ xoá thì trong weakmap cũng bị xoá đi
 */
let john3 = { name: "John" };
let weakMap = new WeakMap();
weakMap.set(john3, "...");
john3 = null; // overwrite the reference
console.log(weakMap)
// => john is removed from memory!
