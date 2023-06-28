//
//  UserLocationManager.swift
//  Swift Weather App
//
//  Created by Cameron on 6/27/23.
//

import Foundation
import CoreLocation

/// User Location tutorials:
/// https://coledennis.medium.com/tutorial-connecting-core-location-to-a-swiftui-app-dc62563bd1de
/// https://www.advancedswift.com/user-location-in-swift/
/// https://sarunw.com/posts/how-to-request-user-location/

protocol UserLocationManagerDelegate {
    func updatedUser(lat: Double, lon: Double) -> Void
}

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager();
    var delegate: UserLocationManagerDelegate?
    var locationStatus: CLAuthorizationStatus = .notDetermined;
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self;
    }
    
    func requestUsersLocation() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation();
            self.delegate?.updatedUser(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            self.locationStatus = .authorizedWhenInUse
            self.locationManager.requestLocation()
            break
            
        case .restricted:
            self.locationStatus = .restricted
            break
            
        case .denied:
            self.locationStatus = .denied
            break
            
        case .notDetermined:
            self.locationStatus = .notDetermined
            break

        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
