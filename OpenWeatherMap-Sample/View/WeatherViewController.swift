//
//  WeatherViewController.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

private let AddPlaceFeatureTitle = "Feature coming soon"
private let AddPlaceFeatureMessage = "In the future you'll be able to add more places.\nStay tuned!"
private let AddPlaceFeatureDismissButton = "Dismiss"

class WeatherViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let openWeatherMapAPIClient = OpenWeatherMapAPIClient()
    private var requestTask: NSURLSessionDataTask?
    private let locationHelper = LocationHelper()
    private var weatherDataSource: WeatherDataSource!

    //MARK: Lifecycle

    deinit {
        requestTask?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadWeather()
    }


    //MARK: Actions

    @IBAction func didTapAddPlaceButton(sender: AnyObject) {
        let alert = UIAlertController(title: AddPlaceFeatureTitle, message: AddPlaceFeatureMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: AddPlaceFeatureDismissButton, style: .Default, handler:nil))

        presentViewController(alert, animated: true, completion: nil)
    }

    //MARK: Private Methods

    private func setupTableView() {
        let nib = UINib(nibName: WeatherViewCell.nibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: WeatherViewCell.reuseIdentifier)

        weatherDataSource = WeatherDataSource(tableView: tableView)
        tableView.dataSource = weatherDataSource
        tableView.delegate = weatherDataSource
    }

    private func loadWeather() {
        locationHelper.requestLocation { [weak self] (location) in
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            self?.requestForecast(forLat: latitude, longitude: longitude)
        }
    }

    private func requestForecast(forLat latitude: Double, longitude: Double) {
        requestTask = openWeatherMapAPIClient.getForecast(forLat: latitude, lon: longitude,
                                                          completion: { [weak self] (place: Place?) in
            self?.weatherDataSource.update(withPlace: place)
        })
    }
}

