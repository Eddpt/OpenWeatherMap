//
//  WeatherRecordView.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit
import SDWebImage

final class WeatherRecordView: UIView {

    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!

    func setup(withWeatherRecord weatherRecord: WeatherRecord) {
        guard let maxTemperature = weatherRecord.maxTemperature,
            let weatherIcon = weatherRecord.weatherIcon,
            let weatherDate = weatherRecord.timestamp else { return }

        temperatureLabel.text = "\(maxTemperature.integerValue)°"
        timeLabel.text = NSDate.hoursAndMinutes(fromDate: weatherDate)
        weatherIconImageView.sd_setImageWithURL(NSURL.weatherIconURL(forIconName: weatherIcon))
    }
}