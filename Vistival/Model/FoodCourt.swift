//
//  FoodCourt.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation
import MapKit;

public class FoodStand:Location {
    
    var description:String;
    
    init(coordinate: CLLocation, name: String, id: Int, description:String) {
        super.init(coordinate: coordinate, name: name, id: id);
        self.description = description;
    }


}
