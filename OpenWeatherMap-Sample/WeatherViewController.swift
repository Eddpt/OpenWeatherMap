//
//  WeatherViewController.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let openWeatherMapAPIClient = OpenWeatherMapAPIClient()
    private var requestTask: NSURLSessionDataTask?
    private let locationHelper = LocationHelper()

    //MARK: Lifecycle

    deinit {
        requestTask?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWeather()
    }

    //MARK: Private Methods

    private func loadWeather() {
        locationHelper.requestLocation { [weak self] (location) in
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            self?.requestForecast(forLat: latitude, longitude: longitude)
        }
    }

    private func requestForecast(forLat latitude: Double, longitude: Double) {
        requestTask = openWeatherMapAPIClient.getForecast(forLat: latitude, lon: longitude, completion: { (place: Place?) in
            print(place)
        })
    }
}

