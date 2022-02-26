/**
 * Cách define một biến <var - let - const>
 */

// Từ khoá constant giúp sinh ra một biến hằng và không thể thay đổi giá trị
function constantFC() {
    const sampleConst = 10;
    sampleConst = 20
}

/**
 * Đối với việc sử dụng VAR
 * Trường hợp định nghĩa lại thì biến đó được reference tới biến bên ngoài nó
 * Nói một cách khác VAR được sử dụng như một biến tham chiếu
 */
function varFC() {
    var sampleVar = 10;
    if (true) {
        var sampleVar = 20
    }
    console.log(sampleVar)
}

/**
 * Đối với việc sử dụng LET
 * Trường hợp định nghĩa lại thì ưu tiên sử dụng biến trong khối block đó
 * Nói một cách khác LET ưu tiên sử dụng biến local
 */
function letFC() {
    let sampleLet = 10;
    if (true) {
        let sampleLet = 20
    }
    console.log(sampleLet)
}

/**
 * Một ví dụ thêm về việc sử dụng VAR sẽ dẫn đến kết quả không mong muốn
 * Do đó, hạn chế sử dụng VAR và sử dụng LET
 */
function blockScoped() {
    for (var i = 0; i < 5; i++) {
        setTimeout(function(){ 
           console.log('Yo! ', i);
        }, 1000);
    }

     for (let i = 0; i < 5; i++) {
         setTimeout(function(){ 
            console.log('Yo! ', i);
         }, 1000);
    }
}

// Sử dụng global
/**
 * Var: Phát sinh giá trị cho biến global this
 * Let: Không phát sinh giá trị cho biến global this
 */
var globalX = 'globalX';
let globalY = 'globalY';
console.log(this.globalX); // "global"
console.log(this.globalY); // undefined

// Từ khoá this

function main(): number {
    constantFC();
    varFC();
    letFC();
    blockScoped();
    return 0;
}

main()

/**
 * Khi một biến được định nghĩa bên trong một hàm, 
 * Biến đó được sử dụng Local cho function đó và không thể được sử dụng bên ngoài.
 */
// Không thể sử dụng vượt khỏi scope của mình trong tất cả trường hợp
function scope() {
    var sampleVar = 10;
    let sampleLet = 10;
    const sampleConst = 10;
}
console.log(sampleVar) 
console.log(sampleLet) 
console.log(sampleConst)