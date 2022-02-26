@Võ Long @thoduong cc @Fang A @Cao Hùng cc @Nghĩa Hiếu @Phạm Linh

# ServerKey
```
AAAAi0fC3GU:APA91bFvnCFaOkCB1dma3gUyPMeRQhCuExVAr3MEsgEv2XdQ3bdyzRWKkmuZFwq_GCy67Q7vvkCEcooXyEPxUzZeo66igq0exvKwL7E3PED2AxgqLRtNG3J_ej-G95tlI_ImzNc38T0h
```

## Mục đích
Push notification thông qua topic name

## Công việc
1. Người dùng cần subscribe <TOPIC NAME> đó :white_check_mark:
2. @Fang A Mình đang chưa define nội dung push gồm những gì ta? Define dùm em với. :pray:
3. Admin dùng accesstoken để push nội dung đi :white_check_mark:
4. Lấy access token: (Hướng dẫn lấy accesstoken) :no_entry:

## Vấn đề

Có vẻ không thực hiện lấy access token từ app được. 

- em nghĩ cái này làm đỡ 1 collection trên Fire Store chứa sẵn access token cập nhật bằng tay các giá trị trong đó, rồi admin từ client chỉ get về để lấy quyền push thôi chứ em tìm cả đêm ko làm đc cái get access token từ client rồi ạ. 
- Sử dụng Google Sign-In thì cần config thêm 1 cái app Sign-In trên cloud nữa mà không biết có tính phí không nên đang chờ hỏi ý kiến a Long. Các bạn góp ý luôn nhé :pray: :smiling_face_with_tear:
- Bữa em ko đọc tới chỗ này <Setup iOS> nên tưởng iOS có thể sử dụng Google Sign-In là được nhưng có vẻ phải dùng BE hỗ trợ 

## Hướng giải quyết
* Sử dụng Firebase Cloud Functions
Hướng dẫn: https://www.youtube.com/watch?v=Qnw2bO3ljZs
* Mô tả: Code API như một server bình thường. Host là Firebase
* Chi phí dev: Thêm phần code cho BE bằng NodeJS
* Chi phí sử dụng : 

##Lợi ích
* Có luôn BE nhỏ gọn được tích hợp sẵn trong Firebase
* Có thể quản lý luôn Push đủ thể loại

## Đề xuất
1. Tạm thời tạo 1 collection trên firestore lưu tay các giá trị token phục vụ cho srpint lần này.
2. Code thêm phần BE cho chỗ hướng giải quyết để giải quyết triệt để các vấn đề phát sinh về phía BE mà ta phải control bằng Client.



## PUSH KHÔNG CẦN ACCESS TOKEN

### HEADER

```
Content-Type: application/json
Authorization: key=<Server Key>
```

### BODY (RAW JSON VALUE)

```
{
  "to": "/topics/NotificationAllTBV",
  "notification":{ 
  	"title":"Notification title", 
  	"body":"Notification body", 
  	"sound":"default", 
  	"click_action":"FCM_PLUGIN_ACTIVITY", 
  	"icon":"fcm_push_icon"
  },
  "data": {
    "message": "This is a Firebase Cloud Messaging Topic Message!"
   }
}
```