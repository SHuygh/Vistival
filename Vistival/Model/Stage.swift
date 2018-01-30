//
//  Stage.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation
import MapKit

public class Stage: NSObject, MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D;
    var id:Int;
    public var title:String?;
    
    init(coordinate:CLLocationCoordinate2D, name:String, id:Int) {
        self.coordinate = coordinate;
        self.title = name;
        self.id = id;
    }
}
