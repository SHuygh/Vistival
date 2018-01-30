//
//  FoodStand.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation
import MapKit

public class FoodStand: NSObject, MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D;
    var id:Int;
    public var title:String?;
    var descriptionFood: String;
    
    init(coordinate:CLLocationCoordinate2D, name:String, id:Int, descriptionFood:String) {
        self.coordinate = coordinate;
        self.title = name;
        self.id = id;
        self.descriptionFood = descriptionFood;
    }
}
