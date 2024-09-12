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
}
