//
//  Place.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

final class Place {

    private(set) var cityName: String?
    private(set) var country: String?
    private(set) var weatherRecords: [WeatherRecord]?

}

extension Place: JSONMappable {
    class func updateWithJSONDictionary(jsonDictionary: JSONDictionary) throws -> Place {
        guard let cityJSON = jsonDictionary["city"] as? JSONDictionary,
            let cityName = cityJSON["name"] as? String,
            let country = cityJSON["country"] as? String,
            let list = jsonDictionary["list"] as? [JSONDictionary]

            else { throw InvalidDataError() }

        let place = Place()

        place.cityName = cityName
        place.country = country
        place.weatherRecords = try? WeatherRecord.updateWithJSONArray(list)

        return place
    }
}

extension Place: CustomDebugStringConvertible {
    var debugDescription: String {
        return "cityName: \(cityName)," +
            "\ncountry: \(country)," +
            "\nweatherRecords: \(weatherRecords)\n"
    }
}
