# Kiến thức về Hyper Text Transfer Protocol - HTTP

## 1. Tổng quan về HTTP (HTTP/1.0)

[An overview of HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview)

### 1.1 Định nghĩa

HTTP là **GIAO THỨC** truyền tải **SIÊU VĂN BẢN** được sử dụng trong môi trường www

* GIAO THỨC: Một tập các quy định được đưa ra ta cần phải tuân thủ
* SIÊU VĂN BẢN: Là loại văn bản tích hợp nhiều dạng dữ liệu khác nhau như: văn bản, âm thanh, hình ảnh, video,... và các siêu liên kết đến các siêu văn bản khác. Siêu văn bản là văn bản của một tài liệu có thể được truy tìm không theo tuần tự.

![A Web document is the composition of different resources](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview/fetching_a_page.png)


**<ins>Nâng cao</ins>**

* HTTP/2: 
* HTTPS: 

### 1.2 Kiến thức cơ bản

Giao thức HTTP còn được gọi là giao thức Yêu Cầu - Phản Hồi (Request - Response). Hai thao tác này được thực hiện độc lập với nhau.

Khi một CLIENT gửi một message cho SERVER thì sẽ được gọi là Request. Lúc đó, SERVER xử lý request và phản hồi về một messgae được gọi là RESPONSE (gồm nội dung và **trạng thái SERVER** hiện tại). Thông thường, trạng thái đó sẽ được biểu diễn bằng các kí số hay còn gọi là **HTTP CODE**. Mỗi kí số đều có ý nghĩa riêng của nó.

![](https://img.shields.io/badge/HTTP_CODE-1xx_(100_~>_199)_>_Information_responses-blue?style=plastic&logo=MDNWebDocs) 
> `Yêu cầu đã được chấp nhận và quá trình xử lý yêu cầu của bạn đang được tiếp tục.`

![](https://img.shields.io/badge/HTTP_CODE-2xx_(200_~>_299)_>_Successful_responses-blue?style=plastic&logo=MDNWebDocs) 
> `Yêu cầu của bạn đã được máy chủ tiếp nhận, hiểu và xử lý thành công.`

![](https://img.shields.io/badge/HTTP_CODE-3xx_(300_~>_399)_>_Redirects-blue?style=plastic&logo=MDNWebDocs) 
> `Phía client cần thực hiện hành động bổ sung để hoàn tất yêu cầu.`

![](https://img.shields.io/badge/HTTP_CODE-4xx_(400_~>_499)_>_Client_errors-blue?style=plastic&logo=MDNWebDocs) 
> `Yêu cầu không thể hoàn tất hoặc yêu cầu chứa cú pháp không chính xác. 4xx sẽ hiện ra khi có lỗi từ phía client do không đưa ra yêu cầu hợp lệ.`

![](https://img.shields.io/badge/HTTP_CODE-5xx_(500_~>_599)_>_Server_errors-blue?style=plastic&logo=MDNWebDocs) 
> `Máy chủ không thể hoàn thành yêu cầu được cho là hợp lệ. Khi 5xx xảy ra, bạn chỉ có thể đợi để bên hệ thống máy chủ xử lý xong.`

Có **2 GIAO THỨC TRUYỀN TẢI DỮ LIỆU** phổ biến nhất trên Internet là ![](https://img.shields.io/badge/TCP-blue?style=for-the-badge) và ![](https://img.shields.io/badge/UDP-orange?style=for-the-badge)

* ![](https://img.shields.io/badge/TCP-blue?style=for-the-badge?color=fedcba): Truyền tải đáng tin cậy (Không mất dữ liệu), nhưng chậm.
* ![](https://img.shields.io/badge/UDP-orange?style=for-the-badge?color=fedcba): Chấp nhận mất mát, nhưng nhanh.

![image-20210803000702561](./Resources/image-20210803000702561.png)

## 2. Cấu trúc

### ![](https://img.shields.io/badge/HTTP-Request-red?style=plastic&logo=MDNWebDocs) vs ![](https://img.shields.io/badge/HTTP-Response-blue?style=plastic&logo=MDNWebDocs)

```http
<START LINE>
<HTTP HEADERS>
<EMPTY LINE>
<BODY>
```

![image-20210803010954681](./Resources/image-20210803010954681.png)

#### ![](https://img.shields.io/badge/HTTP-<START_LINE>-blueviolet?style=for-the-badge)

##### ![HTTP Request](https://img.shields.io/badge/HTTP-Request-red?style=plastic&logo=MDNWebDocs)

```http
<An HTTP method> <The request target> <The HTTP version>
<An HTTP method>			: GET, PUT, POST...
<The request target>	: /test.html?query=alibaba
<The HTTP version>		: HTTP/1.0, HTTP/1.1, HTTP/2

Ví dụ: HEAD /test.html?query=alibaba HTTP/1.1
```

##### ![HTTP Response](https://img.shields.io/badge/HTTP-Response-blue?style=plastic&logo=MDNWebDocs)

```http
<An HTTP method> <A status code> <A status text>
<An HTTP method>	: Thường là HTTP/1.1
<A status code>		: /test.html?query=alibaba
<A status text>		: HTTP/1.0, HTTP/1.1, HTTP/2

Ví dụ: HEAD /test.html?query=alibaba HTTP/1.1
```

##### ![image-20210803013322607](./Resources/image-20210803013322607.png)

#### ![](https://img.shields.io/badge/HTTP-<HEADERS>-blueviolet?style=for-the-badge)

```http
<Request headers>
<General headers>
<Representation headers>
```

![image-20210803011558737](./Resources/image-20210803011558737.png)

#### ![](https://img.shields.io/badge/HTTP-<BODY>-blueviolet?style=for-the-badge)

##### ![HTTP Request](https://img.shields.io/badge/HTTP-Request-red?style=plastic&logo=MDNWebDocs)

1. Không phải Request nào cũng có **Body** ví dụ như GET, HEAD, DELETE, or OPTIONS.
2. Một vài request liên quan đến gửi dữ liệu đến SERVER liên quan đến công việc update như UPDATE, POST **thì mới cần**
3. Body có thể chia ra làm 2 loại:
	* Dạng chứa <ins>**DUY NHẤT 1**</ins> kiểu dữ liệu đơn (SINGLE): 
		* Được xác định bởi 2 headers ![](https://img.shields.io/badge/ContentーType-orange?style=for-the-badge) và ![](https://img.shields.io/badge/ContentーLenght-orange?style=for-the-badge)
		* Phục vụ cho request loại ![](https://img.shields.io/badge/URLEncoded-application/xーwwwーformーurlencoded-blueviolet?style=flat) ![](https://img.shields.io/badge/GraphQL-application/json-blueviolet?style=flat)
	* Dạng chứa <ins>**NHIỀU**</ins>  kiểu dữ liệu (MULTIPLE): 
		* Phục vụ cho request loại ![](https://img.shields.io/badge/MultipleData-multipart/formーdata-blue?style=flat) 

##### ![HTTP Response](https://img.shields.io/badge/HTTP-Response-blue?style=plastic&logo=MDNWebDocs)

1. Không phải RESPONSE nào cũng có **Body**.
2. Những RESPONSE với những **STATUS CODE** trả về trạng thái **thì KHÔNG cần** (Ví dụ như: [201-Created](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/201), [204-No Content](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/204))
3. Body có thể chia ra làm 3 loại:
	* Dạng chứa <ins>**(SINGLE)**</ins> **`BIẾT ĐƯỢC KÍCH THƯỚC`**: 
		* Được xác định bởi 2 headers ![](https://img.shields.io/badge/ContentーType-orange?style=for-the-badge) và ![](https://img.shields.io/badge/ContentーLenght-orange?style=for-the-badge)
	* Dạng chứa <ins>**(SINGLE)**</ins> **`KHÔNG BIẾT ĐƯỢC KÍCH THƯỚC`**:
		* Được encode bởi thuật toán ![](https://img.shields.io/badge/Chunked-critical?style=plastic)
		* Được định nghĩa bởi ![](https://img.shields.io/badge/TransferーEncoding-chunked-critical?style=plastic)
	* Dạng chứa <ins>**NHIỀU**</ins> kiểu dữ liệu (MULTIPLE): 
		* Phục vụ cho Response trả về nhiều loại ![](https://img.shields.io/badge/MultipleData-multipart/formーdata-blue?style=flat). Hiếm khi được xử dụng.

## 3. Keywords

- [x] Request URL: Đường dẫn API
- [x] Params: Query string (?query=alibaba...)
- [x] Headers
  - [x] Authorization: Chứa token hoặc Bearer token
  - [x] Content-Type: application/json, application/xml...
  - [x] Content-Length: <Kích thước Body>
- [x] Body
  - [x] ![](https://img.shields.io/badge/none-blueviolet?style=flat):
  - [x] ![](https://img.shields.io/badge/form/data-blueviolet?style=flat):
  - [x] ![](https://img.shields.io/badge/xーwwwーformーurlencoded-xーwwwーformーurlencoded-blueviolet?style=flat):
  - [x] ![](https://img.shields.io/badge/raw-blueviolet?style=flat):
  - [x] ![](https://img.shields.io/badge/binary-blueviolet?style=flat):
  - [x] ![](https://img.shields.io/badge/GraphQL-application/json-blueviolet?style=flat):
- [x] Pre-request Script
- [x] Settings
  - [x] Enable SSL certificate verification: Sử dụng SSL trong chứng thực (HTTPS)

### Tools

- [x] IntelliJ ![](https://img.shields.io/badge/IntelliJ-IDE-red?style=for-the-badge&logo=IntelliJIDEA)
- [x] SpringBoot ![](https://img.shields.io/badge/SpringBoot-Framework-red?style=for-the-badge&logo=SpringBoot)
- [x] Visual Code ![](https://img.shields.io/badge/Visual_Studio_Code-Editor-red?style=for-the-badge&logo=VisualStudioCode)
- [x] Cassandra ![](https://img.shields.io/badge/Cassandra-Distributed_Database-red?style=for-the-badge&logo=ApacheCassandra)
- [x] Postman ![](https://img.shields.io/badge/Postman-Restful_Tool-red?style=for-the-badge&logo=Postman)
- [x] Curl ![](https://img.shields.io/badge/Curl-Command_Line_Tool-red?style=for-the-badge&logo=Curl)
- [x] XAMPP ![](https://img.shields.io/badge/XAMP-Web_Server-red?style=for-the-badge&logo=XAMPP)
- [x] Docker ![](https://img.shields.io/badge/Docker-Virtualization_Technology-red?style=for-the-badge&logo=Docker)
- [x] Shields.IO ![](https://img.shields.io/badge/Shields-Format-red?style=for-the-badge&logo=Shields.io)
- [x] Simple Icons ![](https://img.shields.io/badge/Simple_Icons-Format-red?style=for-the-badge&logo=SimpleIcons)

## 4. Curls
[ProgrammerSought - Sample about GET, POST, PUT, UPDATE](https://www.programmersought.com/article/1931414468/)

### ![](https://img.shields.io/badge/CURL-<POST>-blueviolet?style=for-the-badge)
```
curl -X POST \
  https://some-web-url/api/v1/users \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer {ACCESS_TOKEN}' \
  -H 'cache-control: no-cache' \
  -d '{
  "username" : "myusername",
  "email" : "myusername@gmail.com",
  "password" : "Passw0rd123!"
}'
```

### ![](https://img.shields.io/badge/CURL-<GET>-blueviolet?style=for-the-badge)
```
curl \
    -i \
    -H "Content-Type: application/json" \
    -X GET \
    http://localhost:8080/api/whiskies
```

### ![](https://img.shields.io/badge/CURL-<POST>-blueviolet?style=for-the-badge)

```
curl \
    -i \
    -H "Content-Type: application/json" \
    -X POST \
    -d '{"id": 1, "name": "myname", "origin": "myorigin"}' \
    http://localhost:8080/api/whiskies
```

### ![](https://img.shields.io/badge/CURL-<PUT>-blueviolet?style=for-the-badge)
```
curl \
    -i \
    -H "Content-Type: application/json" \
    -X PUT \
    -d '{"name": "myname1", "origin": "myorigin1"}' \
    http://localhost:8080/api/whiskies/1
```

### ![](https://img.shields.io/badge/CURL-<DELETE>-blueviolet?style=for-the-badge)
```
curl \
    -i \
    -H "Content-Type: application/json" \
    -X DELETE \
    http://localhost:8080/api/whiskies/4
```