//
//  BaseAPI.swift
//  TBVCommunity
//
//  Created by HaiKaito on 06/07/2021.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

class BaseAPINetwork {
	var db: Firestore {
		return Firestore.firestore()
	}
	
	init() {
		// [START setup]
		let settings = FirestoreSettings()
		
		Firestore.firestore().settings = settings
		// [END setup]
	}
}

// Utils
//extension BaseAPINetwork {
//	func didSignIn(user: UserData) -> UserData {
//		var accessToken = XAccessToken()
//		accessToken.token = user.token
//		accessToken.expiry = user.expiry
//
//		return user
//	}
//}

class RestNetwork<T> where T: Codable {
	func requestPost(apiUrl: String,
					 headers: [String: String],
					 body: Data?,
					 completion: @escaping (T?, Error?) -> Void) where T: Codable {
		
		
		guard let url = URL(string: apiUrl) else { return }
		
		// create post request
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		
		// insert json data to the request
		request.httpBody = body//jsonData
		
		//HTTP Headers
		let allKeys = headers.keys
		for key in allKeys {
			guard let value = headers[key] else {
				continue
			}
			request.addValue(value, forHTTPHeaderField: key)
		}
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard error == nil else {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
				return
			}
			
			let decoder = JSONDecoder()
			guard let responseObject = try? decoder.decode(T.self, from: data) else {
				completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
				return
			}
			
			completion(responseObject, nil)
		}
		
		task.resume()
	}
}
