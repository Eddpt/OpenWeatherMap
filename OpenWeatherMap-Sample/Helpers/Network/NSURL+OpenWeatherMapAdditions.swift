//
//  NSURL+OpenWeatherMapAdditions.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

extension NSURL {
    class func forecastURL(forLat lat: Double, lon: Double) -> NSURL? {
        assert((GlobalConfiguration.OpenWeatherMapAPIKey != "<API KEY>"), "\n\n-----> PLEASE SET YOUR API KEY <-----\n\n")

        var openWeatherMapURL = NSURL(string: GlobalConfiguration.OpenWeatherMapURLString)

        openWeatherMapURL = openWeatherMapURL?.addComponent(withName: GlobalConfiguration.AppIdQueryParameter,
                                                            value: GlobalConfiguration.OpenWeatherMapAPIKey)

        openWeatherMapURL = openWeatherMapURL?.addComponent(withName: GlobalConfiguration.UnitsQueryParameter,
                                                            value: GlobalConfiguration.UnitsQueryParameterDefaultValue)

        openWeatherMapURL = openWeatherMapURL?.addComponent(withName: GlobalConfiguration.LatQueryParameter,
                                                            value: "\(lat)")
        openWeatherMapURL = openWeatherMapURL?.addComponent(withName: GlobalConfiguration.LonQueryParameter,
                                                            value: "\(lon)")

        return openWeatherMapURL
    }

    class func weatherIconURL(forIconName iconName: String) -> NSURL? {
        let weatherIconURLBaseString = GlobalConfiguration.OpenWeatherMapAssetURLString
        let weatherIconURLString = weatherIconURLBaseString.stringByAppendingString("\(iconName).png")

        return NSURL(string: weatherIconURLString)
    }
}