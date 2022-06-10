//
//  UserRepository.swift
//  TBVCommunity
//
//  Created by HaiPham on 7/6/21.
//

/**
Provide methods using for User action
*/
import Foundation
import SwiftUI
import Combine

protocol UserRepository {
	// Input params
	typealias InputUserSignIn = (email: String, passwd: String)
	typealias InputUserRegister = (email: String, nickName: String, phone: String, department: String, jobTitle: String, password: String)
    typealias OutputNotificationTopic = (Bool, Error?) -> Void
    
	// Output params
	typealias OutputAllUsersEntity = ([UserEntity]?, Error?) -> Void
	typealias OutputUserEntity = (UserEntity?, NSError?) -> Void
	typealias OutputStatus = (Bool, Error?) -> Void
	
	// Authen
	func signIn(input: InputUserSignIn, completion: @escaping OutputUserEntity)
	func signOut(completion: @escaping (Bool) -> Void)
	
	// Info
	func userInfo(completion: @escaping OutputUserEntity)
	
	// Register
	func register(input: InputUserRegister, completion: @escaping OutputUserEntity)
	
	// Reset password
	func resetPasswordWith(email: String, completion: @escaping OutputStatus)
	
    // Survey and Event
    func activeUsers(completion: @escaping OutputAllUsersEntity)
    
	// For Admin
	func allUsers(completion: @escaping OutputAllUsersEntity)
    func updateUserInfo(input: UserModel, completion: @escaping OutputUserEntity)
    func activateUser(uid: String, actived: Bool, completion: @escaping OutputUserEntity)
    func getUser(userId: String ,completion: @escaping OutputUserEntity)
    
    func subscribeTBVAllTopic(completion: @escaping OutputNotificationTopic)
    func subscribeAdminTopic(completion: @escaping OutputNotificationTopic)
    func unSubscribeAllTopic(completion: @escaping OutputNotificationTopic)
}

class UserRepositoryImpl: UserRepository {
    
	private let network: UserNetwork
    private let notiNetwork: NotificationNetwork
    init(network: UserNetwork, notiNetwork: NotificationNetwork) {
		self.network = network
        self.notiNetwork = notiNetwork
	}
	
	func signIn(input: InputUserSignIn, completion: @escaping OutputUserEntity) {
		return network.signIn(input: input, completion: completion)
	}

    func signOut(completion: @escaping (Bool) -> Void) {
        network.signOut { result in
            completion(result)
        }
	}
	
	func userInfo(completion: @escaping OutputUserEntity) {
		network.getCurentUser(completion: completion)
	}
	
    func register(input: InputUserRegister, completion: @escaping OutputUserEntity) {
        
        network.signUp(input: input, completion: { [weak self] entity, error in

            let notification = NotificationRequestEntity(id: entity?.uid ?? "", title: "Noti.Title.account".localized, message: "Noti.Body.account".localized , type: NotificationRequestType.newAccount)

            self?.notiNetwork.notify(topic: ConstantFCMKey.fcmTopicAllAdmin, notification: notification, completion: { _ , _ in
                completion(entity, error)
            })
        })
    }
	
	func resetPasswordWith(email: String, completion: @escaping OutputStatus) {
		network.resetPasswordWith(email: email, completion: completion)
	}
	
	func allUsers(completion: @escaping OutputAllUsersEntity) {
		network.allUsers(completion: completion)
	}
    
    func activeUsers(completion: @escaping OutputAllUsersEntity) {
        network.activeUsers(completion: completion)
    }
    
    func activateUser(uid: String, actived: Bool, completion: @escaping OutputUserEntity) {
        network.activateUser(uid: uid, actived: actived, completion: completion)
    }
    
    func updateUserInfo(input: UserModel, completion: @escaping OutputUserEntity) {
        var userEnity = UserEntity()
        userEnity.id = input.id
        userEnity.uid = input.uid
        userEnity.fullName = input.fullName
        if input.jobTitle != .unknown { userEnity.jobTitle = input.jobTitle.id }
        if input.department != .unknown { userEnity.department = input.department.id }
        userEnity.phone = input.phone
        network.updateUserInfo(input: userEnity, completion: completion)
    }
    
    func getUser(userId: String ,completion: @escaping OutputUserEntity) {
        network.getUser(uid: userId, completion: completion)
    }
    
    func subscribeTBVAllTopic(completion: @escaping OutputNotificationTopic) {
        notiNetwork.subscribe(topic: ConstantFCMKey.fcmTopicAllTBV, completion: { result, error in
            if result {
                AppInfo.isSubscribedTopic = true
            }
            completion(result, error)
        })
    }
    
    func subscribeAdminTopic(completion: @escaping OutputNotificationTopic) {
        notiNetwork.subscribe(topic: ConstantFCMKey.fcmTopicAllAdmin, completion: { result, error in
            if result {
                AppInfo.isSubscribedAdminTopic = true
            }
            completion(result, error)
        })
    }
    
    func unSubscribeAllTopic(completion: @escaping OutputNotificationTopic) {
        notiNetwork.unSubscribe(topic: ConstantFCMKey.fcmTopicAllTBV, completion: { result, error in
            if result {
                AppInfo.isSubscribedTopic = false
            }
            completion(result, error)
        })
        notiNetwork.unSubscribe(topic: ConstantFCMKey.fcmTopicAllAdmin, completion: { result, error in
            if result {
                AppInfo.isSubscribedAdminTopic = false
            }
            completion(result, error)
        })
    }
}

