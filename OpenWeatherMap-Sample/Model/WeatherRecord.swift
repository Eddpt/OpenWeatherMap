//
//  WeatherRecord.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

final class WeatherRecord {

    private(set) var timestamp: NSDate?

    private(set) var minTemperature: NSNumber?
    private(set) var maxTemperature: NSNumber?
    private(set) var pressure: NSNumber?
    private(set) var seaLevel: NSNumber?
    private(set) var groundLevel: NSNumber?
    private(set) var humidity: NSNumber?

    private(set) var weatherDescription: String?
    private(set) var weatherIcon: String?

    private(set) var windSpeed: NSNumber?
    private(set) var windDegrees: NSNumber?

}

extension WeatherRecord: JSONMappable {
    static func updateWithJSONDictionary(jsonDictionary: JSONDictionary) throws -> WeatherRecord {
        guard let timestamp = jsonDictionary["dt"] as? NSNumber,

            let mainDictionary = jsonDictionary["main"] as? JSONDictionary,
            let minTemperature = mainDictionary["temp_min"] as? NSNumber,
            let maxTemperature = mainDictionary["temp_max"] as? NSNumber,
            let pressure = mainDictionary["pressure"] as? NSNumber,
            let seaLevel = mainDictionary["sea_level"] as? NSNumber,
            let groundLevel = mainDictionary["grnd_level"] as? NSNumber,
            let humidity = mainDictionary["humidity"] as? NSNumber,

            let weatherDictionary = (jsonDictionary["weather"] as? [JSONDictionary])?.first,
            let weatherDescription = weatherDictionary["description"] as? String,
            let weatherIcon = weatherDictionary["icon"] as? String,

            let windDictionary = jsonDictionary["wind"] as? JSONDictionary,
            let windSpeed = windDictionary["speed"] as? NSNumber,
            let windDegrees = windDictionary["deg"] as? NSNumber

            else { throw InvalidDataError() }

        let weatherRecord = WeatherRecord()

        weatherRecord.timestamp = NSDate(timeIntervalSince1970: timestamp.doubleValue)
        weatherRecord.minTemperature = minTemperature
        weatherRecord.maxTemperature = maxTemperature
        weatherRecord.pressure = pressure
        weatherRecord.seaLevel = seaLevel
        weatherRecord.groundLevel = groundLevel
        weatherRecord.humidity = humidity

        weatherRecord.weatherDescription = weatherDescription
        weatherRecord.weatherIcon = weatherIcon

        weatherRecord.windSpeed = windSpeed
        weatherRecord.windDegrees = windDegrees

        return weatherRecord
    }
}

extension WeatherRecord: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\ntimestamp: \(timestamp)," +

            "\nminTemperature: \(minTemperature)," +
            "\nmaxTemperature: \(maxTemperature)," +
            "\npressure: \(pressure)," +
            "\nseaLevel: \(seaLevel)," +
            "\ngroundLevel: \(groundLevel)," +
            "\nhumidity: \(humidity)," +

            "\nweatherDescription: \(weatherDescription)," +
            "\nweatherIcon: \(weatherIcon)," +
            
            "\nwindSpeed: \(windSpeed)," +
            "\nwindDegrees: \(windDegrees)\n\n"
    }
}
