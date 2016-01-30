//
//  Answer.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 31/08/2015.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import RealmSwift

// Answer model
class Answer : Object {
    dynamic var id: Int = 0
    dynamic var content: String = ""
    dynamic var correct: Bool = false
}