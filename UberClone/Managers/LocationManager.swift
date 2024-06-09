//
//  LocationManager.swift
//  UberClone
//
//  Created by Arman  Urstem on 05.06.2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:                                                     [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
