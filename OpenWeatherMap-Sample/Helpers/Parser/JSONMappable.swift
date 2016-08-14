//
//  JSONMappable.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

protocol JSONMappable {
    static func updateWithJSONDictionary(JSONDictionary: JSONDictionary) throws -> Self
}

class InvalidDataError: ErrorType { }

extension JSONMappable {
    static func updateWithJSONArray(jsonArray: [JSONDictionary]) throws -> [Self] {
        var result: [Self] = []

        for jsonDictionary in jsonArray {
            result.append(try self.updateWithJSONDictionary(jsonDictionary))
        }

        return result
    }
}
