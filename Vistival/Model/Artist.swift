//
//  Artist.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation

public class Artist{
    
    var name:String;
    var stageID:Int;
    var time:Date;
    var image:String
    var duration: Int;
    
    init(name:String, stageID:Int, time:Date, image:String, duration:Int) {
        self.name = name;
        self.stageID = stageID;
        self.time = time;
        self.image = image;
        self.duration = duration
    }
    
    
}
