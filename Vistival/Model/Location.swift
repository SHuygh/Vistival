//
//  Location.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation
import MapKit

public class Location:NSObject, MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D;
    var id:Int;
    var name:String;
    
    init(coordinate:CLLocationCoordinate2D, name:String, id:Int) {
        self.coordinate = coordinate;
        self.name = name;
        self.id = id;
    }
}
