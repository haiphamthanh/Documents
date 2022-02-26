@Fang A @Cao Hùng @thaiha @Nguyễn Anh Tiệp cc @Thanh Đào @Võ Long
cc @Phạm Linh @Nghĩa Hiếu

# [Sharing] REPORT phần Firebase Cloud Messaging

**TẤT CẢ PHƯƠNG THỨC SEND ĐỀU THỰC HIỆN QUA REST API**

1. Send DEVICES GROUP (Cách này phải có server hoặc phải giữ hết tokens)
   * PHẢI quản lý được device tokens để tạo notification_key.
   * Gọi thực hiện bằng: notification_key (GROUP các device_tokens)
   * LINK: https://firebase.google.com/docs/cloud-messaging/ios/device-group
2. Send TOPIC (KHÔNG CẦN SERVER)
   - KHÔNG cần quản lý device tokens.
   - Gọi thực hiện bằng  topics (các TOPIC NAME)
   - Điều kiện: Device đã subscribe các topics (có thể dùng SDK)
   - LINK: https://firebase.google.com/docs/cloud-messaging/ios/topic-messaging