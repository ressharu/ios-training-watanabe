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
    
    func testSunnyWeatherImage() throws {
        weatherController.weatherResponse.weatherCondition = .sunny
        let view = ForecastView(weatherController: self.weatherController)
        
        let image = try view.inspect().find(viewWithAccessibilityIdentifier: "sunny")
        XCTAssertNotNil(image, "天気が晴れのときに晴れの画像が表示されるべきです")
    }
    
    func testCloudyWeatherImage() throws {
        weatherController.weatherResponse.weatherCondition = .cloudy
        let view = ForecastView(weatherController: self.weatherController)
        
        let image = try view.inspect().find(viewWithAccessibilityIdentifier: "cloudy")
        XCTAssertNotNil(image, "天気が曇りのときに曇りの画像が表示されるべきです")
    }
    
    func testRainyWeatherImage() throws {
        weatherController.weatherResponse.weatherCondition = .rainy
        let view = ForecastView(weatherController: self.weatherController)
        
        let image = try view.inspect().find(viewWithAccessibilityIdentifier: "rainy")
        XCTAssertNotNil(image, "天気が雨のときに雨の画像が表示されるべきです")
    }
    
    func testEncodeWeatherRequest() throws {
        let weatherRequest = WeatherRequest(area: "tokyo", date: "2024-09-06T12:00:00+09:00")
        let encodedString = YumemiWeatherAPIService.encodeWeatherRequest(weatherRequest)
        let expectedJSONString = """
            {"area":"tokyo","date":"2024-09-06T12:00:00+09:00"}
            """
        XCTAssertEqual(encodedString, expectedJSONString, "WeatherRequestのエンコードが正しくありません")
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
