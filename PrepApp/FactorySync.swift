//
//  FactorySync.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 21/07/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import UIKit
import RealmSwift

class FactorySync {
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*DEV (LOCAL) OR PROD (ONLINE) */
    static var production: Bool = true //sync to server (production)
    static var debugMode: Bool = false //autoConnect
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    static var errorNetwork: Bool = false
    static var offlineMode: Bool = false
    
    
    private static let imageManager = ImageManager()
    private static let chapterManager = ChapterManager()
    private static let questionManager = QuestionManager()
    private static let subjectManager = SubjectManager()
    private static let configManager = ConfigManager()
    private static let newsfeedManager = NewsfeedManager()
    private static let realm = FactoryRealm.getRealm()
    
    /*APIs*/
    private static let domain = NSURL(string: "http://prep-app.com")
    //private static let domain = NSURL(string: "http://192.168.1.30/PrepApp")
    private static let apiUrl = NSURL(string: "\(FactorySync.domain!)/api")
    
    //UPLOADS (images)
    static let uploadsUrl = NSURL(string: "\(FactorySync.domain!)/uploads")
    
    //CONFIG
    static let configUrl = NSURL(string: "\(FactorySync.apiUrl!)/configs/")
    static let versionUrl = NSURL(string: "\(FactorySync.apiUrl!)/configs/version/")
    
    //NEWSFEED
    static let newsfeedUrl = NSURL(string: "\(FactorySync.apiUrl!)/newsfeed/")
    
    //QUESTIONS
    static let questionUrl = NSURL(string: "\(FactorySync.apiUrl!)/questions/")
    static let questionMarkedUrl = NSURL(string: "\(FactorySync.apiUrl!)/questions/mark/")
    static let chapterUrl = NSURL(string: "\(FactorySync.apiUrl!)/chapters/")
    static let subjectUrl = NSURL(string: "\(FactorySync.apiUrl!)/subjects/")
    static let imageUrl = NSURL(string: "\(FactorySync.apiUrl!)/uploads/")

    //FRIENDS
    static let findFriendUrl = NSURL(string: "\(FactorySync.apiUrl!)/friend/find/")
    static let shuffleFriendUrl = NSURL(string: "\(FactorySync.apiUrl!)/friend/shuffle/")
    static let updateFriendsUrl = NSURL(string: "\(FactorySync.apiUrl!)/friend/update/")
    static let retrieveFriendsUrl = NSURL(string: "\(FactorySync.apiUrl!)/friend/retrieve/")
    
    //FEEDBACK
    static let feedbackUrl = NSURL(string: "\(FactorySync.apiUrl!)/feedback/")
    
    //LEADERBOARD
    static let leaderboardUrl = NSURL(string: "\(FactorySync.apiUrl!)/leaderboard/")
    
    //USER APIs
    static let userUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/connection/")
    static let passwordUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/update/pass/")
    static let nicknameUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/update/nickname/")
    static let levelUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/update/level/")
    static let awardPointsUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/update/awardPoints/")
    static let colorUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/update/color/")
    static let updateHistoryUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/update/history/")
    static let retrieveHistoryUrl = NSURL(string: "\(FactorySync.apiUrl!)/user/retrieve/history/")
    
    //P'Chat
    static let pchatUrl = NSURL(string: "http://93.26.44.149/")
    
    static let path: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
    
    
    class func getImageManager() -> ImageManager {
        return self.imageManager
    }
    
    class func getQuestionManager() -> QuestionManager {
        return self.questionManager
    }
    
    class func getChapterManager() -> ChapterManager {
        return self.chapterManager
    }
    
    class func getSubjectManager() -> SubjectManager {
        return self.subjectManager
    }
    
    class func getConfigManager() -> ConfigManager {
        return self.configManager
    }
    
    class func getNewsfeedManager() -> NewsfeedManager {
        return self.newsfeedManager
    }
    
    //Called in SyncViewController.swift
    class func sync() {
        print("syncing")
        FactorySync.getSubjectManager().saveSubjects()
        // we fetch subjects then chapters then questions then images in order to avoid Realm bad mapping (ORM)
    }
}