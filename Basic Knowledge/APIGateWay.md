# Kiến thức về IP, Submask và Default Gateway

## 1. Cấu trúc của một địa chỉ IP

* Cấu trúc của một IPv4: 32 bit chia làm 4 phần mỗi phần 8 bit giá trị từ 0 -> 255 (Ví dụ: 203.162.4.190 hay 192.168.1.2).

* Cấu trúc của một IPv6: 128 bit chia làm 8 phần, mỗi phần cũng 8 bit (Ví dụ: fda2:2524:92d:0:105a:a6a2:478a:ac61).

* Ví dụ: 

  * **Hai thành phần của một địa chỉ IP (ở đây sử dụng lớp mạng C để làm ví dụ)**

  ![image-20210808130346872](/Users/haikaito/Library/Application Support/typora-user-images/image-20210808130346872.png)

  * <u>***Network ID:***</u> gồm 3 bộ số đầu tiên, Network ID được dùng để xác định mạng mà thiết bị đang kết nối vào. Ví dụ với đia chỉ 192.168.1.34, thì Network ID là *192.168.1.*, nghĩa là tất cả các thiết bị có cùng lớp mạng *192.168.1.* sẽ giao tiếp được với nhau. Các địa chỉ IP ngoài mạng trên sẽ không giao tiếp được đến các địa chỉ trong mạng đó. 

  * **<u>*Host ID:*</u>** là bộ số cuối cùng, dùng để xác định địa chỉ chính xác của thiết bị. Ví dụ với đia chỉ 192.168.1.34, thì Host ID là *34.* Trong 1 mạng *192.168.1.* , thì sẽ có từ 1 đến 254 bộ Host ID, tương ứng với số thiết bị kết nối vào.

  => <u>***Nói một cách dễ hiểu:***</u> Trong một mạng nội bộ thì **Network ID** chính là tên **con đường**, **trong con đường** này thì sẽ có nhiều **Host ID** chính là **số nhà**. Vậy để tìm một nhà nào đó tại Đà Nẵng, bạn chỉ cần biết **tên đường (Network ID)** và **số nhà (Host ID)** là được.

## 2. Địa chỉ **IP Public** và **IP Private**

***<u>Địa chỉ IP Public</u>***

* Mỗi 1 địa chỉ **IP Public** ra  ngoài Internet là duy nhất. 
* Để các Network có những địa chỉ duy nhất ngoài Internet, thì **Internet Assigned Numbers Authority** (IANA) sẽ chia những khoảng địa chỉ không dự trữ thành những phần nhỏ và **ủy thác trách nhiệm phân phối địa chỉ** cho các tổ chức **Đăng Kí Miền** khắp thế giới.
* Những tổ chức đó là Asia-Pacific Network Information Center (**APNIC**), American Registry for Internet Numbers (**ARIN**), and Réseaux IP Européens (**RIPE NCC**). Những tổ chức này sẽ phân phối những khối địa chỉ đến 1 số nhà các Internet Service Provider (**ISP**) lớn và các ISP lớn này sau đó sẽ gán những khối nhỏ hơn cho các đại lý và các ISP nhỏ hơn. 
* ISP sẽ cấp 1 **IP Public** cho mỗi máy tính của bạn để các máy tính này có thể kết nối trực tiếp đến ISP. Các địa chỉ này được cấp 1 cách tự động dến mỗi máy tính khi máy tính kết nối và có thể là địa chỉ tĩnh nếu đường line của bạn thuê riêng hay các tài khoàn Dial-up.

***<u>Địa chỉ IP Private</u>***

* IANA đã dự trữ một ít địa chỉ IP mà các địa chỉ này **không bao giờ được sử dụng trên Internet** đây là những địa chỉ **IP Private**. 
* <u>***Công dụng:***</u> Những địa chỉ **IP Private** này được sử dụng cho những Host yêu cầu có IP để kết nối nhưng **không cần được thấy trên các mạng Public**. 
* **<u>*Ví dụ*</u>**
  * 1 user kết nối những máy tính trong mạng TCP/IP ở nhà thì **KHÔNG** cần cấp 1 địa chỉ IP Public cho **mỗi Host**.
  * Những host có địa chỉ **IP Private** có thể sử dụng **1 Proxy Server** hay 1 máy tính chạy Windows Server 2003 đã cấu hình như là **1 Network Address Translation (NAT) Server** để kết nối đến đường mạng bên ngoài. 
  * **Windows Server 2003** cũng tích hợp chức năng **Internet Connection Sharing (ICS)** để cung cấp dịch vụ **NAT** đơn giản cho các Client trong mạng Private.

## 3. Địa chỉ IP phân làm bao nhiêu lớp

**<u>*Người ta phân địa chỉ IP ra làm 5 lớp (class)*</u>**

* **Lớp A:** gồm các địa chỉ IP có oc-tet đầu tiên mang giá trị nằm trong khoảng từ 1-126
* **Lớp B:** gồm các địa chỉ IP có oc-tet đầu tiên mang giá trị nằm trong khoảng từ 128-191
* **Lớp C:** gồm các địa chỉ IP có oc-tet đầu tiên mang giá trị nằm trong khoảng từ 192-223
* **Lớp D:** gồm các địa chỉ IP có oc-tet đầu tiên mang giá trị nằm trong khoảng từ 224-239
* **Lớp E:** gồm các địa chỉ IP có oc-tet đầu tiên mang giá trị nằm trong khoảng từ 240-255

=> Trong thực tế, chỉ có lớp **A, B, C** được cài đặt cho các node mạng, lớp **D** được sử dụng trong các ứng dụng truyền thông đa phương tiện, như việc truyền tải video trong mạng. Lớp **E** vẫn còn đang thử nghiệm.

## 4. Kiến thức về Subnet mask

* Mỗi địa chỉ IP đều đi kèm với thành phần gọi là Subnet mask. Vì giao thức TCP/IP quy định hai địa chỉ IP muốn làm việc trực tiếp với nhau thì phải nằm chung một mạng, hay còn gọi là có chung một **Network ID**. 

* Subnet mask là một tập hợp gồm **32 bit** tương tự địa chỉ IP, nhưng có đặc điểm là phân làm **2 vùng**, **vùng bên trái toàn các bit 1, còn vùng bên phải toàn các bit 0**. 

* Như vậy phần địa chỉ IP nằm tương ứng với **vùng các bit 1** của Subnet mask được gọi là **vùng Network** của địa chỉ đó. Có ba Subnet mask chuẩn là **255.0.0.0** dành cho các địa chỉ mạng **lớp A**, **255.255.0.0** dành cho các địa chỉ mạng **lớp B**, và **255.255.255.0** dành cho các địa chỉ mạng **lớp C**.

* **<u>*Ví dụ*</u>**

  Một địa chỉ **192.168.1.2**, là địa chỉ lớp C nên sẽ có subnet mask chuẩn là **255.255.255.0**. Ta thấy Subnet mask này tạo một ranh giới giữa các bit 1 và các bit 0 tại vị trí giữa bit 24 và bit 25, tức là giữa oc-tet 3 và oc-tet 4, do đó ba oc-tet đầu của địa chỉ **192.168.1.2** sẽ là phần **Network ID** của nó. Nói cách khác **192.168.1.0** là NetID của địa chỉ **192.168.1.2**.

  | Địa chỉ IP  | 192      | 168      | 1        | 2        |
  | ----------- | -------- | -------- | -------- | -------- |
  | Subnet mask | 255      | 255      | 255      | 0        |
  | Subnet mask | 11111111 | 11111111 | 11111111 | 00000000 |
  | Network ID  | 192      | 168      | 1        | 0        |

## 5. Kiến thức về GATEWAY

**Gateway là một phần cứng hoặc phần mềm mạng. Cho phép các mạng rời rạc có thể truyền dữ liệu qua lại lẫn nhau.**

* Gateway khác với router và switch ở chỗ nó sử dụng **nhiều hơn 1 protocol** để kết nối nhiều mạng.
* Có thể hoạt động ở bất kì lớp nào trong số 7 lớp trong mô hình OSI (Open System InterConnection Model).
* Thuật ngữ Gateway: cũng có thể được dùng để đề cập đến một chương trình hoặc một máy tính được cấu hình để thực hiện một nhiệm vụ như một cánh cổng "a gateway" ví dụ như "default gateway" hoặc router.

***Khi nào cần dùng đến Default Gateway?***

* Giao thức TCP/IP cũng quy định rằng hai địa chỉ IP có cùng Network ID thì có thể gửi thông tin trực tiếp cho nhau. Ví dụ như **192.168.1.34** và **192.168.1.35** có cùng **NetID(NetworkID)** là 192.168.1.0 nên gửi thông tin cho nhau một cách đơn giản, vì trong cùng một mạng.
* Trường hợp **hai địa chỉ IP có Network ID khác nhau**, ví dụ như **192.168.1.2** có **NetID** là **192.168.1.0**, còn **172.16.4.2** có **NetID** là **172.16.0.0**, muốn gửi thông tin cho nhau thì phải đi xuyên qua thiết bị **Router** (bộ định tuyến), bằng cách gửi ra một cổng thoát mặt định, **Default Gateway là địa chỉ IP** của Router đó.
* Trong mạng máy tính gia đình, các địa chỉ máy con thường là 192.168.1.2, 192.168.1.3, 192.168.1.4 ..., khi muốn gửi nhận thông tin ra ngoài Internet, là các địa chỉ IP bất kỳ nào đó, chắc chắn có **NetID** khác với **192.168.1.0**, thì phải gửi ra địa chỉ Default Gateway là **192.168.1.1**. Địa chỉ IP **192.168.1.1** này phải được **cài đặt sẳn trên Router ADSL** của gia đình. Điều này cũng có nghĩa rằng một máy tính trong gia đình muốn kết nối ra Internet thì phải gửi thông tin ra **Router ADSL**, và thiết bị này sẽ định hướng lại gói tin đi đến nơi cần đến.

=> Default Gateway chính là **địa chỉ của Router** nhà bạn, là địa chỉ khi mà bạn muốn truy cập vào VnReview.vn, thì thông tin bạn yêu cầu sẽ từ máy tính của bạn gởi đến **Default Gateway của Router**, rồi sau đó Router sẽ gởi thông tin này ra ngoài internet để tải trang VnReview.vn và trả ngược lại cho bạn.

### 5.1 Các loại GATEWAY

**<u>Trên cơ sở hướng của luồng dữ liệu, các Gateway được chia thành hai loại</u>**

1. **Gateway một chiều** - Chúng cho phép dữ liệu chỉ lưu chuyển theo một hướng. Các thay đổi được thực hiện trong node nguồn được sao chép trong node đích, nhưng không phải ngược lại. Chúng có thể được sử dụng làm công cụ lưu trữ.
2. **Gateway hai chiều** - Chúng cho phép dữ liệu truyền theo cả hai hướng. Chúng có thể được sử dụng làm công cụ đồng bộ.

**<u>Trên cơ sở hướng của luồng dữ liệu, các Gateway được chia thành hai loại</u>**

1. Network Gateway

   * IP gate

2. Internet-to-orbit Gateway (I2O Gateway)

   * I2O kết nối các thiết bị trên Internet với vệ tinh và tàu vũ trụ quay quanh trái đất. 
   * 2 gateway I2O nổi bật là Project HERMES và Global Educational Network for Satellite Operations (GENSO).
   * "Project HERMES has a maximum coverage of 22,000 km and can transmit voice and data".

3. Cloud storage Gateway

   ![image-20210808124108261](/Users/haikaito/Library/Application Support/typora-user-images/image-20210808124108261.png)

   https://cafedev.vn/tu-hoc-aws-cong-luu-trustorage-gateway-trong-amazon-web-services-la-gi/

   * Là một thiết bị mạng hoặc server chuyên chuyển đổi các lưu trữ đám mây như SOAP hoặc REST thành các giao thức lưu trữ theo khố như iSCSI, kênh Fiber hoặc lưu trữ theo file như NFS hoặc CIFS.

   * Cloud storaget Gateway cho phép các công ty tích hợp các lưu trữ private cloud vào ứng dụng mà không cần phải chyển các ứng dụng đến một public Cloud. Do đó, đơn giản hoá được việc bảo vệ dữ liệu.

     <u>*Một số định nghĩa:*</u>

     - Cổng tệp (NFS) – File Gateway (NFS)
     - Cổng ổ cứng (iSCSI) – Volume Gateway
     - Cổng băng (VTL) – Tape Gateway

4. IoT Gateway

   ![image-20210808111402835](/Users/haikaito/Library/Application Support/typora-user-images/image-20210808111402835.png)

   * [IoT Gateway](https://www.thegioimaychu.vn/server/iot-embedded/) là một thiết bị đóng vai trò là điểm kết nối giữa đám mây và các thiết bị điều khiển, cảm biến và các thiết bị thông minh,… Tất cả dữ liệu di chuyển lên đám mây hoặc ngược lại sẽ đi qua gateway này. IoT gateway thông thường sẽ là một thiết bị phần cứng chuyên dụng, có thiết kế linh hoạt, chịu được môi trường khắc nghiệt, hỗ trợ các chuẩn kết nối cục bộ như: LAN, WiFi, 3G, Zigbee, Z-wave, RF. Hoặc nó cũng có thể là một máy chủ thông thường nếu không gian lắp đặt cho phép, được cài đặt phần mềm gateway và tích hợp các cổng kết nối, wireless phù hợp.
   * Một số cảm biến có thể tạo ra hàng chục ngàn điểm dữ liệu mỗi giây. IoT gateway cung cấp một nơi để xử lý trước dữ liệu cục bộ ở vùng biên trước khi nó được gửi lên đám mây. Khi dữ liệu được tổng hợp, thu gọn và phân tích một cách khôn ngoan ở vùng biên **"EDGE"**, nó **sẽ giảm thiểu khối lượng dữ liệu cần chuyển tiếp lên đám mây**, điều này có thể tác động lớn đến thời gian hồi đáp và chi phí đường truyền mạng.
   * Một lợi ích khác của cổng IoT là nó có thể cung cấp cơ chế bảo mật bổ sung cho mạng IoT và dữ liệu mà nó vận chuyển. Vì gateway quản lý thông tin di chuyển theo cả hai chiều, nó có thể bảo vệ dữ liệu khi di chuyển lên đám mây khỏi các rò rỉ, hạn chế các thiết bị IoT bị xâm phạm bởi nguồn tấn công bên ngoài với các tính năng như phát hiện giả mạo, mã hóa, tạo số ngẫu nhiên bằng phần cứng và công cụ mã hóa.
   * Một IoT Gateway đa năng có thể thực hiện bất kỳ nhiệm vụ nào sau đây:
     - Tạo điều kiện giao tiếp với các thiết bị cũ hoặc không có kết nối internet.
     - Bộ nhớ đệm dữ liệu, caching và media streaming.
     - Xử lý trước dữ liệu (data pre-processing), làm sạch, lọc và tối ưu hóa.
     - Tổng hợp dữ liệu thô.
     - Liên lạc Device-to-Device / Machine-to-Machine.
     - Tính năng kết nối mạng và lưu trữ dữ liệu trực tiếp.
     - Trực quan hóa dữ liệu và phân tích dữ liệu cơ bản thông qua các ứng dụng IoT Gateway.
     - Tính năng lịch sử dữ liệu ngắn hạn.
     - Bảo mật – quản lý truy cập người dùng và các tính năng bảo mật mạng.
     - Quản lý cấu hình thiết

5. See also (Xem thêm)

   1. [SMS gateway](https://en.wikipedia.org/wiki/SMS_gateway)
   2. [VoIP gateway](https://en.wikipedia.org/wiki/VoIP_gateway)
   3. [Access Point Name](https://en.wikipedia.org/wiki/Access_Point_Name)
   4. [Bridge](https://en.wikipedia.org/wiki/Bridging_(networking))
   5. [Cloud storage gateway](https://en.wikipedia.org/wiki/Cloud_storage_gateway)
   6. [Default gateway](https://en.wikipedia.org/wiki/Default_gateway)
   7. [Network switch](https://en.wikipedia.org/wiki/Network_switch)
   8. [Residential gateway](https://en.wikipedia.org/wiki/Residential_gateway)
   9. [Router](https://en.wikipedia.org/wiki/Router_(computing))
   10. [Subnetwork](https://en.wikipedia.org/wiki/Subnetwork)

![image-20210808143718834](/Users/haikaito/Library/Application Support/typora-user-images/image-20210808143718834.png)

# Tham khảo

1. Gateway (telecommunications): https://en.wikipedia.org/wiki/Gateway_(telecommunications)
2. IoT Gateway là gì: (Nguồn)[https://www.thegioimaychu.vn/blog/tong-hop/iot-gateway-la-gi-y-nghia-va-chuc-nang-van-hanh-cua-thiet-bi-nay-p2134/#:~:text=IoT%20Gateway%20l%C3%A0%20m%E1%BB%99t%20thi%E1%BA%BFt,c%C3%A1c%20thi%E1%BA%BFt%20b%E1%BB%8B%20th%C3%B4ng%20minh%2C%E2%80%A6&text=IoT%20gateway%20cung%20c%E1%BA%A5p%20m%E1%BB%99t,%C4%91%C6%B0%E1%BB%A3c%20g%E1%BB%ADi%20l%C3%AAn%20%C4%91%C3%A1m%20m%C3%A2y.]

