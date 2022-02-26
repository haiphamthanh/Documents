Tổng hợp các cách sử dụng command line

1. Các phím tắt trên command line
>> ctrl + 0: Di chuyển về đầu.
>> fn + <- hoặc ->: Di chuyển về đầu dòng hoặc cuối dòng
>> Phím u: Thao tác undo
>> ctrl + r: Thao tác redo
>> Sử dụng v: để chọn
>> Sử dụng c: để cut
>> Sử dụng y: để copy
>> Sử dụng p: để dán

>> dd: Cut dòng
>> yy: copy dòng
>> yw: copy từ
>> y$: copy đến cuối duòng
>> D: copy all


2. Sử dụng lệnh trên cùng một command line.
>> Sử dụng A & B  (Chạy bất chấp tất cả các lệnh)
>> Sử dụng A && B (Chạy tất cả từ trái sang phải, dừng nếu A fail)
>> Sử dụng A | B  (Chạy tất cả từ trái qua phải, dừng nếu A fail, dùng kết quả của A để làm input cho B)
>> Sử dụng A || B (Chạy từ trái sang phải, dừng nếu có bất kì một lệnh nào success)



3. Một số lệnh được đùng cho docker
----> FETCHING <----
>> docker pull <image name>

----> RUN  <----
>> docker run -d -v <forder_in_computer>:<forder_in_container> -p <port_in_computer>:<port_in_container> -it <image_name> /bin/bash
???? -d: Tách riêng việc sử lý mapping ra và xử lý ở background.
???? -v <đường dẫn absolute>:<đường dẫn bên trong container muốn ánh xạ vào>: Ánh xạ dữ liệu ngoài vào trong container thông qua nơi ánh xạ.
???? -p <port_in_computer>:<port_in_container>: Điều hướng port trên máy sang port container.
???? -it <image hoặc container> /bin/bash: câu lệnh truy cập vào container đang và sẽ chạy cái gì (ở đây là ứng dụng bash trong thư mục /bin/).
>> docker start <container>: Khởi động một container.
>> docker exec -it <container đang chạy> /bin/bash: Truy cập vào container đang chạy.

---------------??? Ví dụ ???--------------- 
docker run -d -v : ~/Desktop/SampleDocker/webroot:/var/www/html -p 9000:80 -it ubuntu-nginx /bin/bash 
???? Ta sẽ thực hiện ánh xạ trực tiếp thư mục webroot theo đường dẫn trên vào thư mục /var/www/html như bên trên.
???? Sau đó thực hiện forward port máy tính từ 9000 sang port 80 trên một container.
???? >>>> Khi một request nào truy cập vào máy tính sẽ đi qua port 9000, Request này được chuyển vào port 80 của container.
???? >>>> Ta tưởng tượng mỗi container đang chạy đều như 1 máy tính độc lập, đều có port cho chính nó, nếu muốn truy cập vào đó phải thông qua đó.
???? >>>> Cho nên ta phải móc nối port máy tính vào port của container bên trong lại với nhau thì người bên ngoài mới có thể tương tác được container bên trong này.

----> MONITORING <----
>> docker images: Liệt kê tất cả các image.
>> docker rmi <image>: Xoá một iamage.
>> docker ps: Liệt kê các container đang chạy
>> docker ps -a: Liệt kê các container đã tắt
>> docker rm -f <container>: Xoá một container


4. Giải thích một số trong docker
>> Docker file: Định nghĩa tập các docker được sử dụng
>> 
