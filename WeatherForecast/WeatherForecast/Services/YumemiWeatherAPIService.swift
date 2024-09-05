//
//  YumemiWeatherAPIService.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import Foundation
import YumemiWeather

class YumemiWeatherAPIService {
    // リロード用の新しいメソッドを定義
    static func reloadWeather(completion: @escaping (WeatherCondition) -> Void) {
        fetchWeatherCondition(completion: completion)
    }
    // 天気情報を取得するメソッド
    private static func fetchWeatherCondition(completion: @escaping (WeatherCondition) -> Void) {
        let weatherConditionString = YumemiWeather.fetchWeatherCondition()
        
        let weatherCondition = WeatherCondition(rawValue: weatherConditionString) ?? .sunny
        print(weatherCondition)
        completion(weatherCondition)
    }
}
