//
//  EventNetwork.swift
//  TBVCommunity
//
//  Created by HaiKaito on 07/07/2021.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

enum CheckInStatus {
    case hasCheckedIn
    case waiting
    case inDate
    case outDate
}

struct EventEntityWithoutID: Codable {
    var creator: String?
    var title: String?
    var content: String?
    var type: String?
    var isHidden: Bool?
    var location: String?
    var celebratedDate: String?
	var createdDate: Timestamp?
    var deadline: String?
    var needRegister: Bool?
    var creatorName: String?
    var showingDeadline: String?
    
	init(entity: EventEntity) {
        self.creator = entity.creator ?? ""
        self.title = entity.title ?? ""
        self.content = entity.content ?? ""
        self.type = entity.type ?? ""
        self.isHidden = entity.isHidden
        self.location = entity.location
        self.celebratedDate = entity.celebratedDate
		self.createdDate = entity.createdDate
        self.deadline = entity.deadline
        self.needRegister = entity.needRegister
        self.creatorName = entity.creatorName
        self.showingDeadline = entity.showingDeadline
	}
	
	enum CodingKeys: String, CodingKey {
		case creator
		case title
		case content
        case type
		case location
		case celebratedDate = "celebrated_date"
		case createdDate = "created_date"
		case deadline
		case needRegister = "need_register"
        case creatorName = "creator_name"
        case showingDeadline = "showing_deadline"
	}
}

// MARK: - ================================= Params =================================
// Input
// Output
typealias OutputEventListNetwork = ([EventEntity]?, Error?) -> Void
typealias OutputEventDetailNetwork = (EventEntity?, Error?) -> Void
typealias OutputAttendanceListNetwork = ([AttendanceEntity]?, Error?) -> Void
typealias OutputStatusNetwork = (Bool, Error?) -> Void

// MARK: - ================================= API Interface =================================
protocol EventNetwork {
	func post(event: EventEntity, completion: @escaping OutputEventDetailNetwork)
	func requestAllEvents(completion: @escaping OutputEventListNetwork)
    func requestEventsByDate(date: Date, completion: @escaping OutputEventListNetwork)
    func requestNewEvents(completion: @escaping OutputEventListNetwork)
    func requestEvents(isHidden: Bool, completion: @escaping OutputEventListNetwork)
	func requestEventDetail(id: String, completion: @escaping OutputEventDetailNetwork)
    func updateEvent(event: EventEntity, completion: @escaping OutputStatusNetwork)
    func hiddenEvent(id: String, isHidden: Bool, completion: @escaping OutputStatusNetwork)
    func postAttendance(eventID: String, userID: String, isAttendance: Bool, completion: @escaping OutputStatusNetwork)
	func deleteEvent(id: String, completion: @escaping OutputStatusNetwork)
	func requestAttendances(id: String, attendance: AttendanceModel.Filter, completion: @escaping OutputAttendanceListNetwork)
    func checkin(eventID: String, userID: String, completion: @escaping OutputStatusNetwork)
    func postSeen(eventID: String, userID: String, completion: @escaping OutputStatusNetwork)
    func countSeen(eventID: String, completion: @escaping (Int) -> Void)
}

// MARK: - ================================= API Implement =================================
final class EventNetworkImpl: BaseAPINetwork, EventNetwork {
	func post(event: EventEntity, completion: @escaping OutputEventDetailNetwork) {
		let eventWithoutId = EventEntityWithoutID(entity: event)
		
        let collection = db.collection("events")
		do {
            let ref = try collection.addDocument(from: eventWithoutId)
			
            let newObject = EventEntity(id: ref.documentID,
                                        creator: event.creator,
                                        title: event.title,
                                        content: event.content,
                                        location: event.location,
                                        celebratedDate: event.celebratedDate,
										createdDate: event.createdDate,
                                        deadline: event.deadline,
                                        needRegister: event.needRegister,
                                        creatorName: event.creatorName,
                                        showingDeadline: event.showingDeadline)
			completion(newObject, nil)
		} catch {
			completion(nil, error)
		}
	}
	
	func requestAllEvents(completion: @escaping OutputEventListNetwork) {
		db.collection("events").getDocuments() { (querySnapshot, err) in
			if let err = err {
				return completion([], err)
			}
			
			let list = querySnapshot?.documents.compactMap { ref -> EventEntity? in
                return EventEntity(from: ref)
			}
            
            let validEvents = list?.filter() { return $0.isValid }
            let sortingEvents = validEvents?.sorted(by: { first, second in
                guard let firstDate = first.createdDate else { return false }
                guard let secondDate = second.createdDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
			completion(sortingEvents, nil)
		}
	}
    
    func requestEventsByDate(date: Date, completion: @escaping OutputEventListNetwork) {
        db.collection("events").whereField("celebrated_date", isEqualTo: date.toServerDateString).getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion([], err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> EventEntity? in
                return EventEntity(from: ref)
            }
            
            let validEvents = list?.filter() { return $0.isValid }
            let sortingEvents = validEvents?.sorted(by: { first, second in
                guard let firstDate = first.createdDate else { return false }
                guard let secondDate = second.createdDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
            completion(sortingEvents, nil)
        }
    }
    
    func requestNewEvents(completion: @escaping OutputEventListNetwork) {
        requestAllEvents { list, error in
            if let error = error {
                return completion([], error)
            }
            let newEvents = list?.filter() { return $0.isNew }
            return completion(newEvents, error)
        }
    }
    
    func requestEvents(isHidden: Bool, completion: @escaping OutputEventListNetwork) {
        db.collection("events").whereField("is_hidden", isEqualTo: isHidden).getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion([], err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> EventEntity? in
                return EventEntity(from: ref)
            }
            
            let validEvents = list?.filter() { return $0.isValid }
            let sortingEvents = validEvents?.sorted(by: { first, second in
                guard let firstDate = first.createdDate else { return false }
                guard let secondDate = second.createdDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
            completion(sortingEvents, nil)
        }
    }
	
	func requestEventDetail(id: String, completion: @escaping OutputEventDetailNetwork) {
		db.collection("events").document(id).getDocument { (document, err) in
			if let err = err {
				return completion(nil, err)
			}
			
			guard let document = document else {
				return completion(nil, err)
			}
			
            completion(EventEntity(from: document), nil)
		}
	}
	
	func updateEvent(event: EventEntity, completion: @escaping OutputStatusNetwork) {
        guard let eventId = event.id else {
            return completion(false, NSError(domain: "EventIdNilError", code: -100001, userInfo: nil))
        }
        
        let eventWithoutId = EventEntityWithoutID(entity: event)
        
        let docRef = db.collection("events").document(eventId)
        do {
            try docRef.setData(from: eventWithoutId)
            return completion(true, nil)
        }
        catch {
            return completion(false, error)
        }
	}
    
    func hiddenEvent(id: String, isHidden: Bool, completion: @escaping OutputStatusNetwork) {
        db.collection("events").document(id).updateData(["is_hidden": isHidden]) { error in
            if let error = error {
                return completion(false, error)
            }
            
            return completion(true, nil)
        }
    }
    
    private func requestAttendances(id: String, completion: @escaping OutputAttendanceListNetwork) {
        db.collection("events").document(id).collection("attendances").getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion(nil, err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> AttendanceEntity? in
                return AttendanceEntity(from: ref)
            }
            let validEvents = list?.filter() { return $0.isValid }
            
            completion(validEvents, nil)
        }
    }
	
	func requestAttendances(id: String, attendance: AttendanceModel.Filter, completion: @escaping OutputAttendanceListNetwork) {
		if attendance == .all {
			requestAttendances(id: id, completion: completion)
		} else {
            db.collection("events").document(id)
                .collection("attendances")
                .whereField("attendance", isEqualTo: attendance.rawValue)
                .getDocuments() { (querySnapshot, err) in
				if let err = err {
					return completion(nil, err)
				}
				
				let list = querySnapshot?.documents.compactMap { ref -> AttendanceEntity? in
					return AttendanceEntity(from: ref)
				}
				let validEvents = list?.filter() { return $0.isValid }
				
				completion(validEvents, nil)
			}
		}
		
	}
    
    func postAttendance(eventID: String, userID: String, isAttendance: Bool, completion: @escaping OutputStatusNetwork) {
        let collection = db.collection("events").document(eventID).collection("attendances")
		
		collection.getDocuments() { [weak self] (querySnapshot, err) in
			if let err = err {
				return completion(false, err)
			}
			
			let attendances = querySnapshot?.documents.compactMap { ref -> AttendanceEntity? in
				return AttendanceEntity(from: ref)
			}.filter { $0.userId == userID } ?? []
			
            let attendanceValue = isAttendance ? 1 : 0
            
			if let attendance = attendances.first, let id = attendance.id {
				self?.updateAttendance(id: id, eventID: eventID, userID: userID, attendance: attendanceValue) { results, err in
					return completion(results, err)
				}
			}
            
			if attendances.isEmpty {
                self?.addAttendance(eventID: eventID, userID: userID, attendance: attendanceValue) { results, err in
					return completion(results, err)
				}
			}
		}
    }
    
    func postSeen(eventID: String, userID: String, completion: @escaping OutputStatusNetwork) {
        let collection = db.collection("events").document(eventID).collection("attendances")
        collection.getDocuments() { [weak self] (querySnapshot, err) in
            guard err == nil else {
                return completion(false, errorConstructor(LocalizationManager
                                                            .shared
                                                            .error
                                                            .errorEventNotExist))
            }
            
            let attendances = querySnapshot?.documents.compactMap { ref -> AttendanceEntity? in
                return AttendanceEntity(from: ref)
            }.filter { $0.userId == userID } ?? []
            
            if attendances.isEmpty {
                self?.addAttendance(eventID: eventID, userID: userID, seen: true) { results, err in
                    return completion(results, err)
                }
            } else {
                guard let attendance = attendances.first, let attendanceId = attendance.id else {
                    return completion(false, nil)
                }
                
                self?.updateAttendance(id: attendanceId, eventID: eventID, userID: userID, seen: true) { results, err in
                    return completion(results, err)
                }
            }
        }
    }
    
    func countSeen(eventID: String, completion: @escaping (Int) -> Void) {
        let collection = db.collection("events")
            .document(eventID)
            .collection("attendances")
            .whereField("seen", isEqualTo: true)
        collection.getDocuments() {(querySnapshot, err) in
            guard err == nil else {
                return completion(0)
            }
            
            completion(querySnapshot?.documents.count ?? 0)
        }
    }
    
	func checkin(eventID: String, userID: String, completion: @escaping OutputStatusNetwork) {
		if eventID.contains("/") {
			return completion(false, errorConstructor(LocalizationManager
                                                        .shared
                                                        .error
                                                        .errorEventNotExist))
        }
        
        let collection = db.collection("events").document(eventID).collection("attendances")
        collection.getDocuments() { [weak self] (querySnapshot, err) in
            guard err == nil else {
                return completion(false, errorConstructor(LocalizationManager
                                                            .shared
                                                            .error
                                                            .errorEventNotExist))
            }
            
            let attendances = querySnapshot?.documents.compactMap { ref -> AttendanceEntity? in
                return AttendanceEntity(from: ref)
            }.filter { $0.userId == userID } ?? []
            
            self?.requestEventDetail(id: eventID) { event, _ in
                guard let celebrateDate = event?.celebratedDate else {
                    return completion(false, errorConstructor(LocalizationManager
                                                                .shared
                                                                .error
                                                                .errorEventOutDate))
                }
                
                switch self?.checkinStatus(celebrateDate: celebrateDate, checkin: attendances.first?.checkin) {
                case .hasCheckedIn:
                    completion(false, errorConstructor(LocalizationManager
                                                        .shared
                                                        .error
                                                        .errorEventHasCheckedIn))
                case .outDate:
                    completion(false, errorConstructor(LocalizationManager
                                                        .shared
                                                        .error
                                                        .errorEventOutDate))
                case .waiting:
                    completion(false, errorConstructor(LocalizationManager
                                                        .shared
                                                        .error
                                                        .errorEventWaiting(celebrateDate: celebrateDate.toDate()?.toString() ?? "")))
                case .inDate:
                    self?.handleCheckin(attendances: attendances, userID: userID, eventID: eventID, completion: completion)
                case .none:
                    return completion(false, errorConstructor(LocalizationManager
                                                                .shared
                                                                .error
                                                                .errorEventNotExist))
                }
            }
        }
    }
    
    private func handleCheckin(attendances: [AttendanceEntity], userID: String, eventID: String, completion: @escaping OutputStatusNetwork) {
        if attendances.isEmpty {
            addAttendance(eventID: eventID, userID: userID, checkin: Timestamp(date: Date())) { results, err in
                return completion(results, err)
            }
        } else {
            guard let attendance = attendances.first, let attendanceId = attendance.id else {
                return completion(false, nil)
            }
            
            updateAttendance(id: attendanceId, eventID: eventID, userID: userID, checkin: Timestamp(date: Date())) { results, err in
                return completion(results, err)
            }
        }
    }
	
    private func addAttendance(eventID: String, userID: String, attendance: Int? = nil, checkin: Timestamp? = nil, seen: Bool? = true, completion: @escaping OutputStatusNetwork) {
        let collection = db.collection("events").document(eventID).collection("attendances")
		
		let attendance = AttendanceEntity(userId: userID, attendance: attendance, checkin: checkin, seen: seen)
		do {
			let _ = try collection.addDocument(from: attendance)
			completion(true, nil)
		} catch {
			completion(false, error)
		}
	}
	
    private func updateAttendance(id: String, eventID: String, userID: String, attendance: Int? = nil, checkin: Timestamp? = nil, seen: Bool? = true, completion: @escaping OutputStatusNetwork) {
        var updateData = [String : Any]()
        updateData["user_id"] = userID
        
        if let attendance = attendance {
            updateData["attendance"] = attendance
        }
        if let checkin = checkin {
            updateData["checkin"] = checkin
        }
        if let seen = seen {
            updateData["seen"] = seen
        }
        		
		db.collection("events").document(eventID).collection("attendances").document(id).updateData(updateData) { err in
			if let err = err {
				return completion(false, err)
			}
			return completion(true, nil)
		}
	}
	
	func deleteEvent(id: String, completion: @escaping OutputStatusNetwork) {
		db.collection("events").document(id).delete() { err in
			if let err = err {
				return completion(false, err)
			}
			return completion(true, nil)
		}
	}
    
    private func checkinStatus(celebrateDate: String, checkin: Timestamp?) -> CheckInStatus {
        guard checkin == nil else { return .hasCheckedIn }
        
        switch celebrateDate.toDate()?.compareDay(from: Date().toServerDateString.toDate() ?? Date()) {
        case .orderedAscending:
            return .outDate
        case .orderedDescending:
            return .waiting
        case .orderedSame:
            return .inDate
        default:
            return .outDate
        }
    }
}
