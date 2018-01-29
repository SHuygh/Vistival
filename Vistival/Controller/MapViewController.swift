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
        
        let center = CLLocationCoordinate2D(latitude: 51.152256, longitude: 2.722487)
        let span = MKCoordinateSpanMake(0.0015, 0.0015)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.region = region
        
        //set orientation in the right direction (53° relative to north)
        mapView.camera.heading = 53;
        mapView.setCamera(mapView.camera, animated: false);
        
        //no interaction enabled;
        mapView.isUserInteractionEnabled = false;

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
