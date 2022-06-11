//
//  NotificationNetwork.swift
//  TBVCommunity
//
//  Created by HaiKaito on 12/07/2021.
//

import FirebaseMessaging

// MARK: - ================================= Params =================================
// Input
enum NotificationRequestType: Int {
    case event = 1
    case survey
    case newAccount
}

struct NotificationRequestEntity {
    var id: String
    var title: String
    var message: String
    var type: NotificationRequestType
}

// Output
typealias OutputNotifyTopicNetwork = (Bool, Error?) -> Void

protocol NotificationNetwork {
	func subscribe(topic: String, completion: @escaping OutputNotifyTopicNetwork)
    func unSubscribe(topic: String, completion: @escaping OutputNotifyTopicNetwork)
    func notify(topic: String, notification: NotificationRequestEntity, completion: @escaping OutputNotifyTopicNetwork)
}

// MARK: - ================================= API Implement =================================
final class NotificationNetworkImpl: BaseAPINetwork, NotificationNetwork {
    private let workSpaceUrl = "https://fcm.googleapis.com/fcm/send"
	
	func subscribe(topic: String, completion: @escaping OutputNotifyTopicNetwork) {
		Messaging.messaging().subscribe(toTopic: topic) { error in
			completion(error == nil, error)
		}
	}
    
    func unSubscribe(topic: String, completion: @escaping OutputNotifyTopicNetwork) {
        Messaging.messaging().unsubscribe(fromTopic: topic) { error in
            completion(error == nil, error)
        }
    }
	
	func notify(topic: String, notification: NotificationRequestEntity, completion: @escaping OutputNotifyTopicNetwork) {
        let id = notification.id
        let title = notification.title
        let type = notification.type.rawValue
        let message = String(notification.message.prefix(150))
		
        let restNetwork = RestNetwork<NotificationEntity>()
        
        let headers = ["Content-Type": "application/json",
                       "Authorization": "key=" + ConstantFCMKey.serverKey]
        
        // prepare json data
        let json: [String: Any] = [
            "to": "/topics/\(topic)",
            "notification": ["title": "\(title)",
                             "body": "\(message)",
                             "badge": 1,
                             "sound": "default",
                             "click_action": "FCM_PLUGIN_ACTIVITY",
                             "icon": "fcm_push_icon",
                             "event": ["topicName": "\(topic)",
                                       "id": "\(id)",
                                       "type": "\(type)"
                             ]
            ],
            "data": [
                "event": ["topicName": "\(topic)",
                          "id": "\(id)",
                          "type": "\(type)"
                ]
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        restNetwork.requestPost(apiUrl: workSpaceUrl, headers: headers, body: jsonData) { notificationEntity, error in
            completion( notificationEntity != nil, error)
        }
	}
}
