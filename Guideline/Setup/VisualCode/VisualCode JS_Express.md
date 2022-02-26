# Kiến thức về Cài đặt môi trường NodeJS

Kết quả đạt được:

- [ ] Cách cài đặt môi trường Node.js
- [ ] Cách thêm và sử dụng thư viện Express
- [ ] Kiến trúc của một dự án NodeJS chuẩn
- [ ] Cách cấu hình các biến môi trường trong NodeJS
- [ ] Cách sử dụng cách Middleware

## 1. Hướng dẫn tạo project

**Điều kiện**:

- [ ] Đã cài ![NodeJS](https://img.shields.io/badge/NodeJS-greenyellow?style=plastic&logo=Node.js)
- [ ] Đã cài ....

**Tạo project mới**

1. Tạo thư mục rỗng

2. Chạy lệnh npm int

3. Sau khi thiết lập xong thì file khởi chạy sẽ nằm trong **package.js** tại key **"main"** (thường là **app.js** hoặc **index.js**)

4. Cài plugin **.gitignore Generator**

5. ![image-20210806152224191](/Users/haikaito/Library/Application Support/typora-user-images/image-20210806152224191.png) Sau đó chọn Node

6. Add các dependency vào project: `npm i express monk helmet morgan cors dotenv`

7. Cách add dependencies to a `package.json` file from the command line

   * Thêm vào prod: npm install <package-name> [--save-prod]
   * Thêm vào dev: npm install <package-name> --save-dev

8. Cài đặt nodemon vào dev: `npm íntall nodemon --save-dev`

   ![image-20210806160351575](/Users/haikaito/Library/Application Support/typora-user-images/image-20210806160351575.png)

9. Để có thể thực hiện được câu lệnh: **npm run dev**

   ![image-20210806160659907](/Users/haikaito/Library/Application Support/typora-user-images/image-20210806160659907.png)

10. Kết quả: Sử dụng lệnh curl để test api

    ![image-20210806161907208](/Users/haikaito/Library/Application Support/typora-user-images/image-20210806161907208.png)

## Công nghệ

1. Ngôn ngữ: JavaScript (Typescript)

2. Môi trường: NodeJS

3. Thư viện hỗ trợ Code: Express

4. CSDL: Ví dụ **MongoDB**

5. Công cụ giúp Web App tương tác với CSDL: **Mongoose** hay **monk**

6. Security cho ứng dụng: **Helmet**

   * **Helmet** là một package npm, gồm 14 middleware nhỏ ở trong giúp xử lý, lọc các HTTP header độc hại (nhằm khai thác lỗ hổng XSS hay clickjacking, ...).

   ![img](https://images.viblo.asia/a893e3d1-cb43-4ff1-aeda-2e519c922973.png)

7. Công cụ ghi log: **Morgan**

8. **CORS (Cross Origin Resource Sharing)**: 

   * CORS được sinh ra là vì [same-origin policy](https://www.w3.org/Security/wiki/Same_Origin_Policy), là một chính sách liên quan đến bảo mật được cài đặt vào toàn bộ các trình duyệt hiện nay. Chính sách này ngăn chặn việc truy cập tài nguyên của các domain khác một cách vô tội vạ.

     Ta có ví dụ một kịch bản như sau:

     - Bạn truy cập một trang web có mã độc. Trang web đó sử dụng Javascript để truy cập tin nhắn Facebook của bạn ở địa chỉ `https://facebook.com/messages`.
     - Nếu bạn đã đăng nhập Facebook từ trước rồi. Nếu không có same-origin policy, trang web độc hại kia có thể thoải mái lấy dữ liệu của bạn và bất cứ điều gì chúng muốn.

     Same-origin policy chính là để ngăn chặn những kịch bản như trên để bảo vệ người dùng, giúp an toàn hơn khi lướt web.

9. Thư viện quản lý biến môi trường: **dotenv**

10. // DevOps?? 

    * CI/CD:
    * Deploy: Dev, Test, Prod

11. Document: **Swagger**

12. Auto restart for dev: **nodemon**

    * Chỉ add vào devdependencies

## 2. Thiết kế dự án như thế nào

1. Router -> Controller -> Service -> Model
2. Content-path: /api

## 3. Code sample

```javascript
// Vài thay đổi nhỏ trong việc import
const express = require('express')
const { getAllTodos } = require('../controllers/todo.controller')

// Ở CS6 đổi thành
import { router as _router } from 'express'
import { getAllTodos } from '../controllers/todo.controller'
```

### 3.1 Sử dụng router

* Khai bảo router

* Sử dụng router cho việc điều hướng API ![image-20210806173519253](/Users/haikaito/Library/Application Support/typora-user-images/image-20210806173519253.png)

* Kiểm tra production

  ``` javascript
  const isProduction = process.evn.NODE_ENV === "production"
  ```

* Sử dụng morgan để ghi log:

  ```javascript
  const accessLogStream = rfs.createStream("access.log", {
    interval: "1d",
    path: join(__dirname, "log")
  })
  app.use(isProduction ? morgan("combined", { stream: accessLogStream }) : morgan("dev"))
  ```

* Connect to data base
* Thực hiện bundling bằng webpack
  * Add các middleware cần thiết
  * Thực hiện config webpack
  * Câu lệnh chạy webpack: `npm run web-pack`
  * Câu lệnh chạy bundle: `npm run start`
    * File ta build được nằm tại thư mục **dist** có tên là **bundle.js**
    * Ta đã config trong file **webpack.config.js** với key **start** là **node ./dist/bundle.js**

