//
//  WeatherViewCell.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

final class WeatherViewCell: UITableViewCell {

    @IBOutlet private weak var placeNameLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!

    //MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        placeNameLabel.text = nil

        stackView.arrangedSubviews.forEach { (view) in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    func flashScrollIndicators() {
        scrollView.flashScrollIndicators()
    }
}

extension WeatherViewCell : ConfigurableCell {
    func configure(forObject place: Place) {
        guard let cityName = place.cityName,
            let country = place.country,
            let weatherRecords = place.weatherRecords else { return }

        placeNameLabel.text = "\(cityName) (\(country))"

        for weatherRecord in weatherRecords {
            let weatherRecordView = WeatherRecordView.loadFromNib()
            weatherRecordView.setup(withWeatherRecord: weatherRecord)
            stackView.addArrangedSubview(weatherRecordView)
        }
    }
}
