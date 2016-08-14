//
//  NSDate+Extensions.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

private struct Static {
    static var onceToken: dispatch_once_t = 0
    static var dateFormatter: NSDateFormatter!
}

extension NSDate {
    static func hoursAndMinutes(fromDate date: NSDate) -> String? {
        dispatch_once(&Static.onceToken) {
            Static.dateFormatter = NSDateFormatter()
            Static.dateFormatter.dateFormat = "HH:mm"
        }

        return Static.dateFormatter.stringFromDate(date)
    }
}
