//
//  LocationService.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    lazy var isLoadLocate: BoolVoid? = nil
    
    private var isUpdate = false
    
     var authorizationStatus: CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }
        
    static let shared: LocationService = {
        LocationService()
    }()

    private override init() {
        super.init()
        configure()
    }
    
    private func configure() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status != .notDetermined else {
            return
        }
        currentLocation = manager.location
        getCity()
    }
    
    private func getCity() {
        guard let location = currentLocation else { return }
        getPlace(for: location) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DataStorage.shared.currentCity = success?.locality
                self.isLoadLocate?(true)
            case .failure(let failure):
                print(failure.localizedDescription)
                self.isLoadLocate?(false)
            }
        }
    }
    
    func updateLocate() {
        isUpdate = true
        locationManager.startUpdatingLocation()
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard isUpdate else { return }
        isUpdate = false
        locationManager.stopUpdatingLocation()
        currentLocation = manager.location
        getCity()
    }
}

extension LocationService {
    
    func getPlace(for location: CLLocation,
                  completion: @escaping(Result<CLPlacemark?, Error>) -> Void) {
        let geocoder = CLGeocoder()
       
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let placemark = placemarks?.first else {
                let errorPlacemark = NSError.error("Placemark is not found")
                completion(.failure(errorPlacemark))
                return
            }
            completion(.success(placemark))
        }
    }
}
