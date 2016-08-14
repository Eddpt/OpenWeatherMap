//
//  LocationHelper.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationHelper: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var completion: ((CLLocation) -> Void)?

    override init() {
        super.init()

        setupLocation()
    }

    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation(withCompletion completion: (CLLocation) -> Void) {
        self.completion = completion

        if !isAuthorized() {
            return
        }

        locationManager.requestLocation()
    }

    func isAuthorized() -> Bool {
        return (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse)
    }

    //MARK: CLLocationManagedDelegate methods

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let completion = self.completion,
            let location = locations.first else { return }

        completion(location)

        self.completion = nil
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}