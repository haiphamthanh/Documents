# Thông tin API
## URL
https://fcm.googleapis.com/fcm/send

## Phương thức thực hiện
POST

## HEADER
iOS ServerKey: AAAAi0fC3GU:APA91bFvnCFaOkCB1dma3gUyPMeRQhCuExVAr3MEsgEv2XdQ3bdyzRWKkmuZFwq_GCy67Q7vvkCEcooXyEPxUzZeo66igq0exvKwL7E3PED2AxgqLRtNG3J_ej-G95tlI_ImzNc38T0h
Android ServerKey: ....

Content-Type: application/json
Authorization: key=<ServerKey>


## Body
Topic Name: NotificationAllTBV

```
{
  "to": "/topics/<Topic Name>",
  "notification":{ 
  	"title": <Title>, 
  	"body": <Content>, 
  	"sound":"default", 
  	"click_action":"FCM_PLUGIN_ACTIVITY", 
  	"icon":"fcm_push_icon",
    "event": {
        "topicName": "NotificationAllTBV",
        "eventId": "4udVg44x8ZE2UUXAqijQ"
    }
    "disaster": {
        "topicName": "NotificationAllTBV",
        "disasterId": "4udVg44x8ZE2UUXAqijQ"
    }
  }
}
```

### Lưu ý ở đây:
- **Cấu trúc event và disaster là tự define nếu có cách nào tốt hơn thì propose nhé**
- **Có thể gom lại thành 1 đối tượng hay gì đó. Nếu có cách tốt hơn thì nói nhé**

# LUỒNG HOẠT ĐỘNG

## Luồng Subscribe
- Đăng nhập -> Subscribe topic
- SignOut -> UnSubscribe topic

## Luồng push
- Create Event -> Thành công -> Push
	- Update Event (Check sau)
- Create Disaster -> Thành công -> Push
	- Update Event (Chưa define)

## Luồng nhận response
- `Case1`
Khi app trên forceground: Không xử lý gì cả.

- `Case2`
	- Khi app xuống background: Nhận notification -> Tap vào Notification -> Vào màn hình detail.

- `Case3`
	- B1. Nhấn home để app xuống background: 
	- B2. Mở Postman lên push 1 noti
	- B3. Nhận notification -> KHÔNG tap vào Notification
	- B4: Nhấn vào app cho app lên Forceground lại.
	- B4. kéo widget từ top xuống và tap vào Notification -> Vào màn hình detail.

## Cơ chế parse notification khi nhận từ iOS (Tham khảo)
```
    private func handlePushNotification(userInfo: [AnyHashable : Any]) {
        guard let aps = userInfo["aps"] as? NSDictionary,
              let eventRawString = userInfo["gcm.notification.event"] as? String,
              let event = eventRawString.dictionaryFromJSONString as? NSDictionary else {
            return
        }
        
        let responseObject = EventNotificationModel(aps: aps, event: event)
        NotificationManager.shared.enter(notifyEventId: responseObject.event?.eventId)
    }
```


```
struct EventNotificationModel {
    var aps: Alert?
    var event: Event?
    var category: String?
    var sound: String?
    
    struct Alert {
        var body: String?
        var title: String?
        
        init(aps: NSDictionary?) {
            self.body = aps?["body"] as? String
            self.title = aps?["title"] as? String
        }
    }
    
    struct Event {
        var topicName: String?
        var eventId: String?
        
        init(event: NSDictionary) {
            self.topicName = event["topicName"] as? String
            self.eventId = event["eventId"] as? String
        }
    }
    
    init(aps: NSDictionary, event: NSDictionary) {
        self.aps = Alert(aps: aps["alert"] as? NSDictionary)
        self.event = Event(event: event)
        self.category = event["category"] as? String
        self.sound = event["sound"] as? String
    }
}
```