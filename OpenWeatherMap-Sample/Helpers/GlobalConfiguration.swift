//
//  GlobalConfiguration.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

struct GlobalConfiguration {

    static let OpenWeatherMapAPIKey = "<API KEY>"

    static let OpenWeatherMapURLString = "http://api.openweathermap.org/data/2.5/forecast"
    static let OpenWeatherMapAssetURLString = "http://openweathermap.org/img/w/"

    static let AppIdQueryParameter = "appid"
    static let UnitsQueryParameter = "units"
    static let LatQueryParameter = "lat"
    static let LonQueryParameter = "lon"

    static let UnitsQueryParameterDefaultValue = "metric"
}