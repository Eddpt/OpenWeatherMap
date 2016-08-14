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
        guard let url = NSURL.forecastURL(forLat: lat, lon: lon) else {
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
}