//
//  Subject.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 23/07/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import RealmSwift


// Subject model
class Subject : Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var version: Int = 0
    dynamic var ratio: Int = 0
    dynamic var timePerQuestion: Int = 0 //seconds
}