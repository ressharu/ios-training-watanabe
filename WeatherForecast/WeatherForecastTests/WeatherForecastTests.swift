//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by 渡邉 華輝 on 2024/09/12.
//

import XCTest
import SwiftUI
import ViewInspector

@testable import WeatherForecast

final class WeatherForecastTests: XCTestCase {
    
    var weatherController: WeatherControllerImpl!
    
    override func setUpWithError() throws {
        weatherController = WeatherControllerImpl()
    }
    
    override func tearDownWithError() throws {
        weatherController = nil
    }
    
    func testWeatherImage(for condition: WeatherCondition) throws {
        weatherController.weatherResponse.weatherCondition = condition
        let view = ForecastView(weatherController: self.weatherController)
        let image = try view.inspect().find(viewWithAccessibilityIdentifier: condition.ImageName)
        XCTAssertNotNil(image, "天気が\(condition.rawValue)のときに\(condition.ImageName)の画像が表示されるべきです")
    }
    
    func testSunnyWeatherImage() throws {
        try testWeatherImage(for: .sunny)
    }

    func testCloudyWeatherImage() throws {
        try testWeatherImage(for: .cloudy)
    }

    func testRainyWeatherImage() throws {
        try testWeatherImage(for: .rainy)
    }
    
    func testEncodeWeatherRequest() throws {
        let weatherRequest = WeatherRequest(area: "tokyo", date: "2024-09-06T12:00:00+09:00")
        let encodedString = YumemiWeatherAPIService.encodeWeatherRequest(weatherRequest)
        let expectedJSONString = """
            {"area":"tokyo","date":"2024-09-06T12:00:00+09:00"}
            """
        
        let encodedData = encodedString?.data(using: .utf8)
        let encodedDictionary = try XCTUnwrap(encodedData.flatMap { try? JSONSerialization.jsonObject(with: $0) as? NSDictionary })
        
        let expectedData = expectedJSONString.data(using: .utf8)!
        let expectedDictionary = try JSONSerialization.jsonObject(with: expectedData) as? NSDictionary
        
        XCTAssertEqual(encodedDictionary, expectedDictionary, "WeatherRequestのエンコードが正しくありません")
    }
    
    // デコードのテスト
    func testDecodeWeatherResponse() throws {
        let jsonString = """
            {"max_temperature":30,"date":"2024-09-06","min_temperature":20,"weather_condition":"sunny"}
            """
        let expectedResponse = WeatherResponse(
            maxTemperature: 30,
            date: "2024-09-06",
            minTemperature: 20,
            weatherCondition: .sunny
        )
        let decodedResponse = YumemiWeatherAPIService.decodeWeatherResponse(jsonString)
        XCTAssertEqual(decodedResponse?.maxTemperature, expectedResponse.maxTemperature, "最高気温が一致しません")
        XCTAssertEqual(decodedResponse?.minTemperature, expectedResponse.minTemperature, "最低気温が一致しません")
        XCTAssertEqual(decodedResponse?.date, expectedResponse.date, "日付が一致しません")
        XCTAssertEqual(decodedResponse?.weatherCondition, expectedResponse.weatherCondition, "天気の状態が一致しません")
    }
}
