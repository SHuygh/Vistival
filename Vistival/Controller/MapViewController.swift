//
//  MapViewController.swift
//  Vistival
//
//  Created by Daan Demeulemeester on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    let stages = ImportData.data.stageList;
    let foodstands = ImportData.data.foodCourt;
    
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self;
        

        self.initializeMap();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func initializeMap(){
        //generate region to be shown
        self.setLocation();
        
        //check if userlocation is enabled and show user location accordignly
        self.checkPermissionLocation();
        
        //Place pins for stages
        self.makePinsStage();
        
        //place pins for foodstands
        self.makePinsFoodCourt();
        
    }
    
    func setLocation(){
        // coordinaten van het festival
        
        let center = CLLocationCoordinate2D(latitude: 51.152992, longitude: 2.721108)
        
        //set orientation in the right direction (53° relative to north)
        mapView.centerCoordinate = center
        mapView.camera.heading = 53;
        mapView.camera.altitude = 250
        mapView.camera.pitch = 60;
        mapView.setCamera(mapView.camera, animated: false);
        
        mapView.mapType = .hybrid
        //no interaction enabled;
        mapView.isRotateEnabled = false;
        mapView.isScrollEnabled = false;
        mapView.isZoomEnabled = false;

    }
    
    func checkPermissionLocation(){
    
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways ){
            
            mapView.showsUserLocation = true;
            
        }else{
            locationManager.requestWhenInUseAuthorization();
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         mapView.showsUserLocation  = (status == .authorizedWhenInUse || status == .authorizedAlways )
    }
    
    func makePinsStage(){
        
        for stage:Stage in stages {
            
            self.mapView.addAnnotation(stage)
        }

    }
    
    func makePinsFoodCourt(){
        
        for foodstand:FoodStand in foodstands {
            
            self.mapView.addAnnotation(foodstand)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if let stagePin = annotation as? Stage{
            
            let identifier:String = "Stage";
            
            
            if let reuasableView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
                reuasableView.annotation = stagePin;
                return reuasableView;
            }else{
                
                let view = MKPinAnnotationView(annotation: stagePin, reuseIdentifier: identifier);
                
                let timetableButton = UIButton.init(type: .detailDisclosure);
                
                timetableButton.accessibilityIdentifier = "\(stagePin.id)";
                timetableButton.addTarget(self, action: #selector(goToTimetable(sender:)), for: .touchUpInside)
                
                view.rightCalloutAccessoryView =  timetableButton;
                
                view.pinTintColor = UIColor.blue;
                view.canShowCallout = true;

                return view;
            }
        }
        else if let foodStandPin = annotation as? FoodStand
        {
            let identifier:String = "Foodstand";
            
            
            if let reuasableView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
                reuasableView.annotation = foodStandPin;
                return reuasableView;
                
            }else{
                
                let view = MKPinAnnotationView(annotation: foodStandPin, reuseIdentifier: identifier);
                
                view.pinTintColor = UIColor.red;
                view.canShowCallout = true;
                
                return view;
            
            }
        }
            
        return nil;
    }

    
    @objc func goToTimetable(sender: UIButton){


        let lineUpVC = tabBarController?.childViewControllers[1] as! LineUpViewController;
        
        var tmpShowStage = [Bool]()
        
        for stage in ImportData.data.stageList{
            tmpShowStage.append(false)
        }
        
        tmpShowStage[(sender.accessibilityIdentifier as! NSString).integerValue] = true;
        
        lineUpVC.showStage = tmpShowStage;
        
        lineUpVC.showID = 0;
        
        tabBarController?.selectedIndex = 1
    }
    

}
