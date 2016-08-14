//
//  WeatherRecordTests.swift
//  OpenWeatherMap-SampleTests
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap_Sample

class WeatherRecordTests: XCTestCase {

    func test_parseJSON_withValidJSON_shouldSucceed() {
        guard let path = NSBundle(forClass: WeatherRecordTests.self).pathForResource("weatherRecord", ofType: "json") else {
            XCTFail("🔥: Unexpected missing resource file")
            return
        }

        guard let jsonData = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe) else {
            XCTFail("🔥: Unexpected error when reading from resource file")
            return
        }

        guard let jsonDictionary = try? JSONDataParser.parse(withData: jsonData),
            let weatherRecord = try? WeatherRecord.updateWithJSONDictionary(jsonDictionary) else {
            XCTFail("🔥: Unexpected error when parsing and mapping data to a WeatherRecord")
            return
        }

        let expectedMinTemp = 21.93
        let actualMinTemp = weatherRecord.minTemperature
        XCTAssertTrue(actualMinTemp == expectedMinTemp, "Expected minTemperature to be \(expectedMinTemp), but got \(actualMinTemp)")

        let expectedMaxTemp = 22.91
        let actualMaxTemp = weatherRecord.maxTemperature
        XCTAssertTrue(actualMaxTemp == expectedMaxTemp, "Expected maxTemperature to be \(expectedMaxTemp), but got \(actualMaxTemp)")

        let expectedPressure = 1028.36
        let actualPressure = weatherRecord.pressure
        XCTAssertTrue(actualPressure == expectedPressure, "Expected pressure to be \(actualPressure), but got \(expectedPressure)")

        //TODO: Testing the remaining attributes is trivial
    }

    func test_parseJSON_withInvalidJSON_shouldFail() {
        guard let path = NSBundle(forClass: WeatherRecordTests.self).pathForResource("invalidWeatherRecord", ofType: "json") else {
            XCTFail("🔥: Unexpected missing resource file")
            return
        }

        guard let jsonData = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe) else {
            XCTFail("🔥: Unexpected error when reading from resource file")
            return
        }

        do {
            let _ = try JSONDataParser.parse(withData: jsonData)

            XCTFail("🔥: Unexpected success")
        } catch is InvalidJSONDataError {
            // Expected error
        } catch let e {
            XCTFail("🔥: Unexpected error \(e)")
        }

    }
}
