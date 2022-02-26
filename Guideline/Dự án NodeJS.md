# Lựa chọn template thực hiện

Nhiều loại template có thể lựa chọn: https://www.free-css.com/free-css-templates

Template hiện tại đang chọn: https://www.free-css.com/free-css-templates/page269/virtual-folio

# Thời gian thực hiện

Bắt đầu: 21-08-2021

Kết thúc: 21-09-2021

# Lựa chọn công nghệ

Công cụ sử dụng: Visual Code

Front-end: Typescript + JavaScript

Back-end: Springboot

Microservice: 

* Ngôn ngữ: Typescript
* Môi trường: Node.js
* Thư viện ngôn ngữ: Express
* Thư viện build package: webpack
* Thư viện thực hiện dịch mã: babel

Các công nghệ sử dụng:

* Json web token: Chứng thực Oauth2
* Nginx: dùng trong việc load balacer
* Thư viện chống DDOS và SQL Injection: --->> Cần định nghĩa <<----
* Công nghệ mã hoá: ---> AuthenZ hay là gì đó <----
* Công nghệ Ajax: Sử dụng bởi JQuery thuần
* Thử sử dụng memcache: Cache dữ liệu

Tìm hiểu các khái niệm AWS trong quá trình làm đề tài.

# Công đoạn thực hiện

- [ ] Thực hiện làm theo video để có cái nhìn cơ bản lại về web front-end: https://www.youtube.com/watch?v=9FD2ugeS4OU

- [ ] Setup docker compose để có được các điều sau:
  - [ ] NginX hoặc XAMP dùng để quản lý local backend
  - [ ] Container chứa JavaScript + JQuery
  - [ ] Các volumns Webser Nginx hoặc XAMP phải được config kết nối với thư mục ngoài cho dễ thao tác
- [ ] Back-end sẽ code bằng Springboot
- [ ] Các micro-service
  - [ ] Chứng thực User
  - [ ] Thông tin các bài blog đã viết
  - [ ] Cài đặt Elastich-Search dùng để tìm các bài viết nhanh chóng
- [ ] Thiết kế hệ thống recommendation (Cái này làm sau)
- [ ] Trang quản lý thông tin CMS (Cái này cũng khó để sau)