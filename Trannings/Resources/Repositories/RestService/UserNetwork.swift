//
//  UserNetwork.swift
//  TBVCommunity
//
//  Created by HaiKaito on 06/07/2021.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

// MARK: - ================================= API Interface =================================
protocol UserNetwork {
	// Input params
	typealias InputUserSignIn = (email: String, passwd: String)
	typealias InputUserRegister = (email: String, nickName: String, phone: String, department: String, jobTitle: String, password: String)

	// Output params
	typealias OutputAllUsersEntity = ([UserEntity]?, Error?) -> Void
	typealias OutputUserEntity = (UserEntity?, NSError?) -> Void
	typealias OutputStatus = (Bool, Error?) -> Void
	
	func signUp(input: InputUserRegister, completion: @escaping OutputUserEntity)
	func signIn(input: InputUserSignIn, completion: @escaping OutputUserEntity)
	func signOut(completion: @escaping (Bool) -> Void)
	
	func getCurentUser(completion: @escaping OutputUserEntity)
	func resetPasswordWith(email: String, completion: @escaping OutputStatus)
	
    // Survey and Event
    func activeUsers(completion: @escaping OutputAllUsersEntity)
    
	// For Admin
	func allUsers(completion: @escaping OutputAllUsersEntity)
    func updateUserInfo(input: UserEntity, completion: @escaping OutputUserEntity)
    func activateUser(uid: String, actived: Bool, completion: @escaping OutputUserEntity)
    func getUser(uid: String, completion: @escaping OutputUserEntity) 
}

final class UserNetworkImpl: BaseAPINetwork, UserNetwork {
	func signUp(input: InputUserRegister, completion: @escaping OutputUserEntity) {
		Auth.auth().createUser(withEmail: input.email, password: input.password) { [weak self] result, error in
            if let error = error as NSError? {
                return completion(nil, error)
			}
			
            result?.user.sendEmailVerification(completion: { error in
                if let error = error as NSError? {
                    return completion(nil, error)
                }
                
                let userEntity = UserEntity(uid: result?.user.uid,
                                            fullName: input.nickName,
                                            email: input.email,
                                            isEmailVerified: result?.user.isEmailVerified,
                                            role: "staff",
                                            registrationDate: Timestamp(date: Date()),
                                            actived: false,
                                            phone: input.phone,
                                            department: input.department,
                                            jobTitle: input.jobTitle)

                self?.post(user: userEntity, completion: { user, error in
                    completion(user, error)
                })
            })
		}
	}
	
	func signIn(input: InputUserSignIn, completion: @escaping OutputUserEntity) {
		Auth.auth().signIn(withEmail: input.email, password: input.passwd) { [weak self] result, error in
			guard error == nil, let uid = result?.user.uid else {
				return completion(nil, error as NSError?)
			}
			
			self?.getUser(uid: uid, completion: { user, error in
                guard let uid = user?.uid, user?.isEmailVerified == false && result?.user.isEmailVerified == true else {
                    completion(user, error)
                    return
                }
				
                self?.updateUserEmailVerified(uid: uid, completion: completion)
			})
		}
	}
	
	func signOut(completion: @escaping (Bool) -> Void) {
		let firebaseAuth = Auth.auth()
		do {
			try firebaseAuth.signOut()
            completion(true)
		} catch {
            completion(false)
		}
	}
	
	private func post(user: UserEntity, completion: @escaping OutputUserEntity) {
		let collection = db.collection("users")
		do {
			let _ = try collection.addDocument(from: user)
			completion(user, nil)
		} catch {
			completion(nil, error as NSError?)
		}
	}
	
	func getCurentUser(completion: @escaping OutputUserEntity) {
        guard let uid = Auth.auth().currentUser?.uid else {
			completion(nil, nil)
			return
		}
	
		getUser(uid: uid, completion: completion)
	}
	
    func updateUserInfo(input: UserEntity, completion: @escaping OutputUserEntity) {
        guard let uid = input.uid else {
            let err = NSError(domain: "User UID Nil Error", code: -100001, userInfo: nil)
            return completion(nil, err)
        }
        
        var updateData = [String : Any]()
        if let actived = input.fullName {
            updateData["full_name"] = actived
        }
        if let jobTitle = input.jobTitle {
            updateData["job_title"] = jobTitle
        }
        if let department = input.department {
            updateData["department"] = department
        }
        if let phone = input.phone {
            updateData["phone"] = phone
        }
        
        getUser(uid: uid) {[weak self] user, error in
            guard let user = user,
                  let id = user.id else {
                return completion(nil, error)
            }
            self?.db.collection("users").document(id).updateData(updateData) { [weak self] error in
                if let error = error as NSError? {
                    return completion(nil, error)
                }
                
                self?.getUser(uid: uid) { user, error in
                    return completion(user, error)
                }
            }
        }
    }
    
    func activateUser(uid: String, actived: Bool, completion: @escaping OutputUserEntity) {
        var updateData = [String : Any]()
        updateData["actived"] = actived
        
        getUser(uid: uid) {[weak self] user, error in
            guard let user = user,
                  let id = user.id else {
                return completion(nil, error)
            }
            self?.db.collection("users").document(id).updateData(updateData) { [weak self] error in
                if let error = error as NSError? {
                    return completion(nil, error)
                }
                
                self?.getUser(uid: uid) { user, error in
                    return completion(user, error)
                }
            }
        }
    }
    
	func resetPasswordWith(email: String, completion: @escaping OutputStatus) {
		Auth.auth().sendPasswordReset(withEmail: email) { error in
			if let error = error {
                return completion(false, error)
			}
			completion(true, nil)
		}
	}
    
    func allUsers(completion: @escaping OutputAllUsersEntity) {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion(nil, err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> UserEntity? in
                return UserEntity(from: ref)
            }
            let validUsers = list?.filter() { return $0.isValid }
            let sortingUsers = validUsers?.sorted(by: { first, second in
                guard let firstDate = first.registrationDate else { return false }
                guard let secondDate = second.registrationDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
            
            completion(sortingUsers, nil)
        }
    }
    
    func activeUsers(completion: @escaping OutputAllUsersEntity) {
        db.collection("users")
            .whereField("actived", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion(nil, err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> UserEntity? in
                return UserEntity(from: ref)
            }
            let validUsers = list?.filter() { return $0.isActive }
            let sortingUsers = validUsers?.sorted(by: { first, second in
                guard let firstDate = first.registrationDate else { return false }
                guard let secondDate = second.registrationDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
            
            completion(sortingUsers, nil)
        }
    }
    
    func getUser(uid: String, completion: @escaping OutputUserEntity) {
        db.collection("users")
            .whereField("uid", isEqualTo: uid)
            .limit(to: 1)
            .getDocuments(completion: { (querySnapshot, err) in
                if let err = err as NSError? {
                    return completion(nil, err)
                }
                guard let document = querySnapshot else {
                    return completion(nil, err as NSError?)
                }
                
                completion(UserEntity(from: document.documents.first), nil)
            })
    }
    
    private func updateUserEmailVerified(uid: String, completion: @escaping OutputUserEntity) {
        getUser(uid: uid) {[weak self] user, error in
            guard let user = user,
                  let id = user.id else {
                return completion(nil, error)
            }
            self?.db.collection("users").document(id).updateData(["is_email_verified" : true]) { [weak self] error in
                if let error = error as NSError? {
                    return completion(nil, error)
                }
                
                self?.getUser(uid: uid) { user, error in
                    return completion(user, error)
                }
            }
        }
        
    }
}
