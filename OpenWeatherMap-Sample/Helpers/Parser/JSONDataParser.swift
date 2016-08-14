//
//  JSONDataParser.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

class InvalidJSONDataError: ErrorType { }

final class JSONDataParser {
    class func parse(withData data: NSData) throws -> JSONDictionary {
        do {
            guard let resultData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? JSONDictionary else {
                throw InvalidJSONDataError()
            }

            return resultData
        } catch {
            throw InvalidJSONDataError()
        }
    }
}