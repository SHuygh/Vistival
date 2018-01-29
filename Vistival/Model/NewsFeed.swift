//
//  NewsFeed.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation

public class NewsFeed{
    
    var title:String;
    var body: String;
    var id:Int;
    
    init(title:String, body:String, id:Int) {
        self.title = title;
        self.body = body;
        self.id = id;
    }
    
    
}
