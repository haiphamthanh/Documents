//
//  SurveyNetwork.swift
//  TBVCommunity
//
//  Created by Jay Cao on 21/07/2021.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct SurveyEntityWithoutID: Codable {
    var title: String?
    var content: String?
    var creator: String?
    var createdDate: Timestamp?
    var buttonTexts: [String]?
    var showNoteBoard: Bool?
    var noteBoardHint: String?
    var showingDeadline: String?
    var type: String?
    var creatorName: String?
    
    init(entity: SurveyEntity) {
        self.title = entity.title ?? ""
        self.content = entity.content ?? ""
        self.creator = entity.creator
        self.createdDate = entity.createdDate
        self.buttonTexts = entity.buttonTexts
        self.showNoteBoard = entity.showNoteBoard
        self.noteBoardHint = entity.noteBoardHint
        self.showingDeadline = entity.showingDeadline
        self.type = entity.type
        self.creatorName = entity.creatorName
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case content
        case creator
        case createdDate = "created_date"
        case buttonTexts = "button_texts"
        case showNoteBoard = "show_noteboard"
        case noteBoardHint = "noteboard_hint"
        case showingDeadline = "showing_deadline"
        case type = "type"
        case creatorName = "creator_name"
    }
}

// MARK: - ================================= Params =================================
// Input
// Output
typealias OutputSurveyListNetwork = ([SurveyEntity]?, Error?) -> Void
typealias OutputSurveyDetailNetwork = (SurveyEntity?, Error?) -> Void
typealias OutputFeedbackListNetwork = ([FeedbackEntity]?, Error?) -> Void
typealias OutputSurveyStatusNetwork = (Bool, Error?) -> Void

// MARK: - ================================= API Interface =================================
protocol SurveyNetwork {
    func post(survey: SurveyEntity, completion: @escaping OutputSurveyDetailNetwork)
    func requestAllSurveys(completion: @escaping OutputSurveyListNetwork)
    func requestNewSurveys(completion: @escaping OutputSurveyListNetwork)
    func requestSurveyDetail(id: String, completion: @escaping OutputSurveyDetailNetwork)
    func updateSurvey(survey: SurveyEntity, completion: @escaping OutputSurveyStatusNetwork)
    func hideSurvey(id: String, isHidden: Bool, completion: @escaping OutputSurveyStatusNetwork)
    
    func postFeedback(surveyID: String, userID: String, status: Int, comment: String?, completion: @escaping OutputSurveyStatusNetwork)
    func allFeedbacks(id: String, completion: @escaping OutputFeedbackListNetwork)
    func requestFeedbacks(id: String, status: FeedbackModel.Filter, completion: @escaping OutputFeedbackListNetwork)
    func postSeen(surveyID: String, userID: String, completion: @escaping OutputSurveyStatusNetwork)
    func countSeen(surveyID: String, completion: @escaping (Int) -> Void)
}

final class SurveyNetworkImpl: BaseAPINetwork, SurveyNetwork {
    
    func post(survey: SurveyEntity, completion: @escaping OutputSurveyDetailNetwork) {
        let surveyWithoutId = SurveyEntityWithoutID(entity: survey)
        
        let collection = db.collection("surveys")
        do {
            let ref = try collection.addDocument(from: surveyWithoutId)
            
            let newObject = SurveyEntity(id: ref.documentID,
                                           title: survey.title,
                                           content: survey.content,
                                           createdDate: survey.createdDate,
                                           buttonTexts: survey.buttonTexts,
                                           showNoteBoard: survey.showNoteBoard,
                                           noteBoardHint: survey.noteBoardHint,
                                           showingDeadline: survey.showingDeadline,
                                           type: survey.type)
            completion(newObject, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    func requestAllSurveys(completion: @escaping OutputSurveyListNetwork) {
        db.collection("surveys").getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion([], err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> SurveyEntity? in
                return SurveyEntity(from: ref)
            }
            
            let validSurveys = list?.filter() { return $0.isValid }
            let sortingSurveys = validSurveys?.sorted(by: { first, second in
                guard let firstDate = first.createdDate else { return false }
                guard let secondDate = second.createdDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
            completion(sortingSurveys, nil)
        }
    }
    
    func requestNewSurveys(completion: @escaping OutputSurveyListNetwork) {
        requestAllSurveys { list, error in
            if let error = error { return completion([], error) }
            let newSurveys = list?.filter() { return $0.isNew }
            let sortingSurveys = newSurveys?.sorted(by: { first, second in
                guard let firstDate = first.createdDate else { return false }
                guard let secondDate = second.createdDate else { return true }
                
                return firstDate.compare(secondDate) == .orderedDescending
            })
            return completion(sortingSurveys, error)
        }
    }
    
    func requestSurveyDetail(id: String, completion: @escaping OutputSurveyDetailNetwork) {
        db.collection("surveys").document(id).getDocument { (document, err) in
            if let err = err {
                return completion(nil, err)
            }
            
            guard let document = document else {
                return completion(nil, err)
            }
            
            completion(SurveyEntity(from: document), nil)
        }
    }
    
    func updateSurvey(survey: SurveyEntity, completion: @escaping OutputSurveyStatusNetwork) {
        guard let surveyId = survey.id else {
            return completion(false, NSError(domain: "SurveyIdNilError", code: -100001, userInfo: nil))
        }
        
        let surveyWithoutId = SurveyEntityWithoutID(entity: survey)
        
        let docRef = db.collection("surveys").document(surveyId)
        do {
            try docRef.setData(from: surveyWithoutId)
            return completion(true, nil)
        }
        catch {
            return completion(false, error)
        }
    }
    
    func hideSurvey(id: String, isHidden: Bool, completion: @escaping OutputSurveyStatusNetwork) {
        db.collection("surveys").document(id).updateData(["is_hidden": isHidden]) { error in
            if let error = error {
                return completion(false, error)
            }
            
            return completion(true, nil)
        }
    }
    
    func postFeedback(surveyID: String, userID: String, status: Int, comment: String?, completion: @escaping OutputSurveyStatusNetwork) {
        let collection = db.collection("surveys").document(surveyID).collection("feedbacks")
        
        collection.getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                return completion(false, err)
            }
            
            let feedbacks = querySnapshot?.documents.compactMap { ref -> FeedbackEntity? in
                return FeedbackEntity(from: ref)
            }.filter { $0.userId == userID } ?? []
            
            if feedbacks.isEmpty {
                self?.addFeedback(surveyID: surveyID, userID: userID, status: status, comment: comment) { results, err in
                    return completion(results, err)
                }
            } else if let feedback = feedbacks.first, let id = feedback.id {
                self?.updateFeedback(id: id, surveyID: surveyID, userID: userID, status: status, comment: comment) { results, err in
                    return completion(results, err)
                }
            } else {
                return completion(false, err)
            }
        }
    }
    
    private func addFeedback(surveyID: String, userID: String, status: Int? = nil, comment: String? = nil, seen: Bool? = true, completion: @escaping OutputStatusNetwork) {
        let collection = db.collection("surveys").document(surveyID).collection("feedbacks")
        
        let feedback = FeedbackEntity(userId: userID, status: status, comment: comment, createDate: Timestamp(date: Date()), seen: seen)
        do {
            let _ = try collection.addDocument(from: feedback)
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }
    
    private func updateFeedback(id: String, surveyID: String, userID: String, status: Int? = nil, comment: String? = nil, seen: Bool? = true, completion: @escaping OutputSurveyStatusNetwork) {
        var updateData = [String : Any]()
        updateData["user_id"] = userID
        
        if let status = status {
            updateData["status"] = status
        }
        if let comment = comment {
            updateData["comment"] = comment
        }
        if let seen = seen {
            updateData["seen"] = seen
        }
                
        db.collection("surveys").document(surveyID).collection("feedbacks").document(id).updateData(updateData) { err in
            if let err = err {
                return completion(false, err)
            }
            return completion(true, nil)
        }
    }
    
    func allFeedbacks(id: String, completion: @escaping OutputFeedbackListNetwork) {
        db.collection("surveys").document(id).collection("feedbacks").getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion(nil, err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> FeedbackEntity? in
                return FeedbackEntity(from: ref)
            }
            let validFeedbacks = list?.filter() { return $0.isValid }
            
            completion(validFeedbacks, nil)
        }
    }
    
    func requestFeedbacks(id: String, status: FeedbackModel.Filter, completion: @escaping OutputFeedbackListNetwork) {
        if status == .all {
            allFeedbacks(id: id, completion: completion)
            return
        }
        
        db.collection("surveys").document(id).collection("feedbacks").whereField("status", isEqualTo: status).getDocuments() { (querySnapshot, err) in
            if let err = err {
                return completion(nil, err)
            }
            
            let list = querySnapshot?.documents.compactMap { ref -> FeedbackEntity? in
                return FeedbackEntity(from: ref)
            }
            let validFeedbacks = list?.filter() { return $0.isValid }
            
            completion(validFeedbacks, nil)
        }
    }
    
    func postSeen(surveyID: String, userID: String, completion: @escaping OutputSurveyStatusNetwork) {
        let collection = db.collection("surveys").document(surveyID).collection("feedbacks")
        collection.getDocuments() { [weak self] (querySnapshot, err) in
            guard err == nil else {
                return completion(false, errorConstructor(LocalizationManager
                                                            .shared
                                                            .error
                                                            .errorEventNotExist))
            }
            
            let feedbacks = querySnapshot?.documents.compactMap { ref -> FeedbackEntity? in
                return FeedbackEntity(from: ref)
            }.filter { $0.userId == userID } ?? []
            
            if feedbacks.isEmpty {
                self?.addFeedback(surveyID: surveyID, userID: userID, seen: true) { results, err in
                    return completion(results, err)
                }
            } else if let feedback = feedbacks.first, let id = feedback.id {
                self?.updateFeedback(id: id, surveyID: surveyID, userID: userID, seen: true) { results, err in
                    return completion(results, err)
                }
            } else {
                return completion(false, err)
            }
        }
    }
    
    func countSeen(surveyID: String, completion: @escaping (Int) -> Void) {
        let collection = db.collection("surveys")
            .document(surveyID)
            .collection("feedbacks")
            .whereField("seen", isEqualTo: true)
        collection.getDocuments() {(querySnapshot, err) in
            guard err == nil else {
                return completion(0)
            }
            
            completion(querySnapshot?.documents.count ?? 0)
        }
    }
}
