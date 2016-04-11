//
//  QuestionManager.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 21/09/2015.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import UIKit
import RealmSwift

class QuestionManager {
    
    var questionsToSave: Int = 0
    var questionsSaved: Int = 0
    var hasFinishedSync: Bool = false
    let realm = FactoryRealm.getRealm()
    
    func saveQuestions() {
        self.hasFinishedSync = false
        self.questionsSaved = 0
        self.questionsToSave = 0
        self.getQuestions({ (data) -> Void in
            var onlineQuestions = [Question]()
            // dictionary
            for (id, version) in data {
                let question = Question()
                question.id = Int(id as! String)!
                question.version = (version as! Int)
                onlineQuestions.append(question)
            }
            self.compare(onlineQuestions)
        })

    }
    
    private func getQuestions(callback: (NSDictionary) -> Void) {
        let request = NSMutableURLRequest(URL: FactorySync.questionUrl!)
        request.HTTPMethod = "POST"
        let postString = "mail=\(User.currentUser!.email)&pass=\(User.currentUser!.encryptedPassword)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    print("error : no connexion in getQuestions")
                    FactorySync.errorNetwork = true
                } else {
                    let statusCode = (response as! NSHTTPURLResponse).statusCode
                    if statusCode == 200 {
                        let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if let result = jsonResult {
                            callback(result as NSDictionary)
                        } else {
                            print("error : NSArray nil in getQuestions")
                            FactorySync.errorNetwork = true
                        }
                        
                        
                    } else {
                        print("header status = \(statusCode) in getQuestions")
                        FactorySync.errorNetwork = true
                    }
                }
            }
            
        }
        task.resume()
    }
    
    private func compare(onlineQuestions: [Question]){
        
        // Query a Realm
        let offlineQuestions = self.realm.objects(Question)
        
        // we check what has been removed OR updated
        var idsToRemove = [Int]()
        for offlineQuestion in offlineQuestions {
            var willBeRemoved = true
            for onlineQuestion in onlineQuestions {
                if onlineQuestion.id == offlineQuestion.id && onlineQuestion.version == offlineQuestion.version {
                    willBeRemoved = false
                }
            }
            if willBeRemoved {
                idsToRemove.append(offlineQuestion.id)
            }
        }
        self.deleteQuestions(idsToRemove)
        
        
        // we check what we have to add OR update
        var idsToAdd = [Int]()
        for onlineQuestion in onlineQuestions {
            var willBeAdded = true
            for offlineQuestion in offlineQuestions {
                if onlineQuestion.id == offlineQuestion.id {
                    willBeAdded = false
                }
            }
            if willBeAdded {
                idsToAdd.append(onlineQuestion.id)
            }
        }
        self.questionsToSave = idsToAdd.count
        if self.questionsToSave == 0 {
            self.hasFinishedSync = true
            FactorySync.getImageManager().sync()
            print("questions: nothing new to sync")
        }
        self.saveQuestions(idsToAdd)
    }
    
    private func deleteQuestions(idsToRemove: [Int]){
        for idToRemove in idsToRemove {
            let objectToRemove = realm.objects(Question).filter("id=\(idToRemove)")
            try! self.realm.write {
                self.realm.delete(objectToRemove)
            }
        }
    }
    
    private  func saveQuestions(idsToAdd: [Int]){
        for idToAdd in idsToAdd {
            if FactorySync.errorNetwork == false {
                self.getQuestion(idToAdd, callback: { (questionData) -> Void in
                    self.saveQuestion(questionData)
                })
            }
        }
    }
    
    private func getQuestion(id: Int, callback: (NSDictionary) -> Void) {
        let url = NSURL(string: "\(FactorySync.questionUrl!)\(id)")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let postString = "mail=\(User.currentUser!.email)&pass=\(User.currentUser!.encryptedPassword)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    print("error : no connexion in getQuestion")
                    FactorySync.errorNetwork = true
                } else {
                    let statusCode = (response as! NSHTTPURLResponse).statusCode
                    if statusCode == 200 {
                        let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if let result = jsonResult {
                            callback(result as NSDictionary)
                        } else {
                            print("error : NSArray nil in getQuestion")
                            FactorySync.errorNetwork = true
                        }
                    } else {
                        print("header status = \(statusCode) in getQuestion")
                        FactorySync.errorNetwork = true
                    }
                }
            }
            
        }
        task.resume()
    }
    
    private func saveQuestion(data: NSDictionary) {
        let realm = try! Realm()
        let id =  data["id"] as! Int
        var chapter = Chapter()
        if !self.realm.objects(Chapter).filter("id=\(data["idChapter"] as! Int)").isEmpty {
            chapter = self.realm.objects(Chapter).filter("id=\(data["idChapter"] as! Int)")[0]
        }
        
        let images = self.extractImagesPaths(data["images"] as! NSDictionary)
        let wording = self.parseNplaceImage(data["wording"] as! String, images: images)
        let answersList = self.extractAnswers(data["answers"] as! NSDictionary, images: images)
        var answers = [Answer]()
        for answer in answersList {
            answers.append(answer)
        }
        let calculator = data["calculator"] as! Bool
        let info = self.formatInfo(data["info"] as! String)
        let type = data["type"] as! Int
        let idDuo = data["idGroupDuo"] as! Int
        let idContest = data["idConcours"] as! Int
        let correction = self.parseNplaceImage(data["correction"] as! String, images: images)
        let version = data["version"] as! Int
        
        let newQuestion: Question = Question(value: [
            "id" : id,
            "chapter" : chapter,
            "wording" : wording,
            "answers" : answers,
            "calculator" : calculator,
            "info" : info,
            "type" : type,
            "idDuo" : idDuo,
            "idContest" : idContest,
            "correction" : correction,
            "version" : version
        ])
        
        try! realm.write {
            realm.add(newQuestion)
        }
        self.questionsSaved += 1
        if self.questionsSaved == self.questionsToSave && self.questionsToSave != 0 {
            self.hasFinishedSync = true
            print("questions loaded into Realm DB")
            FactorySync.getImageManager().sync()
        }
    }
    
    private func extractImagesPaths(data: NSDictionary) -> [String] {
        var images = [String]()
        for (_,value) in data {
            images.append(value as! String)
        }
        print(images)
        return images
    }

    private func parseNplaceImage(input: String, images: [String]) -> String {
        var text = input
        if !images.isEmpty {
            var counter = 0
            counter = images.count
            
            for index in 1...counter {
                text = input.stringByReplacingOccurrencesOfString("{\(index)}", withString: "<img width=\"300\" src=\"images/\(images[index-1])\"/>", options: NSStringCompareOptions.LiteralSearch, range: nil)
                //text = input.stringByReplacingOccurrencesOfString("#f9f9f9", withString: "transparent", options: NSStringCompareOptions.LiteralSearch, range: nil)
            }
        }
        return text
    }
    
    private func extractAnswers(data: NSDictionary, images: [String]) -> List<Answer> {
        let answers = List<Answer>()
        for (_,value) in data {
            let answerToExtract = value as! NSDictionary
            let answer = Answer()
            answer.id = (answerToExtract["id"] as! Int)
            answer.content = parseNplaceImage((answerToExtract["content"] as! String), images: images)
            answer.correct = (answerToExtract["correct"] as! Bool)
            answers.append(answer)
        }
        let sortedAnswers = answers.sort { $0.id < $1.id }
        return List(sortedAnswers)
    }
    
    private func formatInfo(input: String) -> String {
        var text = input
        text = input.stringByReplacingOccurrencesOfString("<p>", withString: "<p style=\"font-style: italic; font-size: 12px; text-align: center;\">", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return text
    }
    
    
}