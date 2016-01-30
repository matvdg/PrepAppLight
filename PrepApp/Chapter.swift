//
//  Chapter.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 23/07/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import RealmSwift

// Chapter model
class Chapter : Object {
    dynamic var id: Int = 0
    dynamic var subject: Subject?
    dynamic var number: Int = 0
    dynamic var name: String = ""
    dynamic var version: Int = 0    
}