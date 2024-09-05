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
    static func reloadWeather(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
            fetchWeatherCondition(completion: completion)
    }
    
    // 天気情報を取得するメソッド（シンプルバージョン）
    private static func fetchWeatherCondition(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let weatherCondition = YumemiWeather.fetchWeatherCondition()
        let weatherResponse = WeatherResponse(condition: weatherCondition)
        completion(.success(weatherResponse))
    }
}
