//
//  NSURL+Extensions.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

extension NSURL {
    func addComponent(withName name: String, value: String) -> NSURL? {
        let urlComponents = NSURLComponents(URL: self, resolvingAgainstBaseURL: true)

        var queryItems = [NSURLQueryItem(name: name, value: value)]
        if let originalQueryItem = urlComponents?.queryItems {
            queryItems.insertContentsOf(originalQueryItem, at: 0)
        }

        urlComponents?.queryItems = queryItems

        return urlComponents?.URL
    }
}
