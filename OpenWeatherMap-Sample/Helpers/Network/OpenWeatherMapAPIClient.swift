//
//  OpenWeatherMapAPIClient.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

final class OpenWeatherMapAPIClient: APIClient {

    func getForecast(forLat lat: Double, lon: Double, completion: (Place?) -> Void) -> NSURLSessionDataTask? {
        guard let url = forecastURL(forLat: lat, lon: lon) else {
            return nil
        }

        return getData(fromURL: url, completion: { (result: Result<JSONDictionary, APIError>) in
            switch(result) {
            case let .success(data):
                completion(try? Place.updateWithJSONDictionary(data))

            case let .failure(APIError.genericError(error: error)):
                print("Error while requesting the API \(error)")

            case let .failure(APIError.badResponseError(response: response)):
                print("Bad response \(response)")

            case .failure(_):
                print("Failed requesting the API")
            }
        })
    }

    //MARK: Private helpers

    private func forecastURL(forLat lat: Double, lon: Double) -> NSURL? {
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
}