//
//  UserUseCase.swift
//  TBVCommunity
//
//  Created by HaiKaito on 06/07/2021.
//

import SwiftUI
/**
Provide methods using for User action
*/
protocol UserUseCase {

	// Output params
	typealias OutputAllUsersData = (_ results: [UserModel]?) -> Void
	typealias OutputUserData = (UserModel?, NSError?) -> Void
	typealias OutputStatus = (Bool, Error?) -> Void
	
	// Authen
	func signIn(email: String, passwd: String, completion: @escaping OutputUserData)
	func signOut(completion: @escaping (Bool) -> Void)
	
	// Info
	func userInfo(completion: @escaping OutputUserData)
	
	// Register
    func register(email: String, nickName: String, phone: String, department: String, jobTitle: String, password: String, completion: @escaping OutputUserData)
	
	// Reset password
	func resetPasswordWith(email: String, completion: @escaping OutputStatus)
	
	// For Admin
	func allUsers(completion: @escaping OutputAllUsersData)
    func updateUserInfo(input: UserModel, completion: @escaping OutputUserData)
    func activateUser(uid: String, actived: Bool, completion: @escaping OutputUserData)
    func getUser(userId: String, completion: @escaping OutputUserData)
    func subscribeTBVAllTopic(completion: @escaping OutputStatus)
    func subscribeAdminTopic(completion: @escaping OutputStatus)
    func unSubscribeAllTopic(completion: @escaping OutputStatus)
}

class UserUseCaseImpl: UserUseCase {
	private let repository: UserRepository
	init(repository: UserRepository) {
		self.repository = repository
	}
	
	func signIn(email: String, passwd: String, completion: @escaping OutputUserData) {
		let input = (email: email, passwd: passwd)
		repository.signIn(input: input) { [weak self] result, error in
			guard let result = result, error == nil else {
				completion(nil, error)
				return
			}
			
			let user = UserModel(from: result)
			completion(user, nil)
            
            // If user is invalid -> SignOut
            self?.signOutIfInvalid(user: user)
		}
	}
	
    func signOut(completion: @escaping (Bool) -> Void) {
        repository.signOut { result in
            completion(result)
        }
	}
	
	func userInfo(completion: @escaping OutputUserData) {
		repository.userInfo { [weak self] result, error in
			guard let result = result, error == nil else {
				completion(nil, error)
				return
			}
			
			let user = UserModel(from: result)
			completion(user, nil)
            
            // If user is invalid -> SignOut
            self?.signOutIfInvalid(user: user)
		}
	}
	
    func register(email: String, nickName: String, phone: String, department: String, jobTitle: String, password: String, completion: @escaping OutputUserData) {
        let input = (email: email, nickName: nickName, phone: phone, department: department, jobTitle: jobTitle, password: password)
		repository.register(input: input) { result, error in
			guard let result = result, error == nil else {
                completion(nil, error)
				return
			}
			
			let user = UserModel(from: result)
			completion(user, nil)
		}
	}
	
	func resetPasswordWith(email: String, completion: @escaping OutputStatus) {
		repository.resetPasswordWith(email: email, completion: completion)
	}
	
	
	// For Admin
	func allUsers(completion: @escaping OutputAllUsersData) {
		repository.allUsers { results, error in
            guard let results = results,
                  results.count > 0,
                  error == nil else {
				completion(nil)
				return
			}
			
			let users: [UserModel] = results.compactMap { UserModel(from: $0) }
			completion(users)
		}
	}
    
    func updateUserInfo(input: UserModel, completion: @escaping OutputUserData) {
        repository.updateUserInfo(input: input) { result, error in
            guard let result = result, error == nil else {
                completion(nil, error)
                return
            }
            
            let user = UserModel(from: result)
            completion(user, nil)
        }
    }
    
    func activateUser(uid: String, actived: Bool, completion: @escaping OutputUserData) {
        repository.activateUser(uid: uid, actived: actived) { result, error in
            guard let result = result, error == nil else {
                completion(nil, error)
                return
            }
            
            let user = UserModel(from: result)
            completion(user, nil)
        }
    }
    
    func getUser(userId: String, completion: @escaping OutputUserData) {
        repository.getUser(userId: userId) { result, error in
            guard let result = result, error == nil else {
                completion(nil, error as NSError?)
                return
            }
            let user = UserModel(from: result)
            completion(user, nil)
        }
    }
    
    func subscribeTopic(completion: @escaping OutputStatus) {
       
    }
    func subscribeTBVAllTopic(completion: @escaping OutputStatus) {
        repository.subscribeTBVAllTopic(completion: completion)
    }
    
    func subscribeAdminTopic(completion: @escaping OutputStatus) {
        repository.subscribeAdminTopic(completion: completion)
    }
    
    func unSubscribeAllTopic(completion: @escaping OutputStatus) {
        repository.unSubscribeAllTopic(completion: completion)
    }
}

private extension UserUseCaseImpl {
    func signOutIfInvalid(user: UserModel) {
        if !user.isEmailVerified || !user.actived {
            signOut(completion: { _ in })
        }
    }
}
