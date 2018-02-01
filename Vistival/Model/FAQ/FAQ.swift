//
//  FAQ.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation


struct FAQ{
    
    var title:String;
    var body:[String]!
    var expanded: Bool!

    
    init(title:String, body:[String], expanded: Bool) {
        self.title = title;
        self.body = body;
        self.expanded = expanded;
    }
    
}
