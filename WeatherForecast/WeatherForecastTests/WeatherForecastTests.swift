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
}
