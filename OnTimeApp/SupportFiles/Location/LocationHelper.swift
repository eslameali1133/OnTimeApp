//
//  LocationHelper.swift
//  AshakAlena
//
//  Created by Mohammad Farhan on 22/12/178/1/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import CoreLocation
class LocationHelper:NSObject{
    
    
    var locationManager: CLLocationManager!
    
    static let shared = LocationHelper()
    
    override init(){
        super.init()
        
        
        locationManager = CLLocationManager();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func LocationIsEnable()->Bool{
        if locationManager.location != nil {
            
            return  true
        }else{
            
            
            return false
        }
        
    }
    
    func getlongitude()->Double{
        
        return (locationManager.location?.coordinate.longitude ?? 0.0)
        
    }
    
    func getlatitude()->Double{
        
        return  (locationManager.location?.coordinate.latitude ?? 0.0)
        
    }
    
    func calculateDistance(destinationLat:Double,destinationLog:Double)->CLLocationDistance{
        
        
        let coordinateSource = CLLocation(latitude: getlatitude(), longitude: getlongitude())
        let coordinateDistination = CLLocation(latitude: destinationLat, longitude: destinationLog)
        
        
        return    Double(round(1000*coordinateSource.distance(from: coordinateDistination))/1000)
    }
}

