//
//  QuestionHistory.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 11/08/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import RealmSwift

// QuestionHistory model
class QuestionHistory : Object {
    dynamic var id: Int = 0
    dynamic var training: Bool = false
    dynamic var success: Bool = false
    dynamic var firstSuccess: Bool = false
    dynamic var marked: Bool = false
    dynamic var doubleAssiduity: Bool = false
    dynamic var weeksBeforeExam: Int = 0
}