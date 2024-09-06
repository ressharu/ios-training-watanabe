//
//  YumemiWeatherAPIService.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import Foundation
import YumemiWeather

final class YumemiWeatherAPIService {
    // リロード用の新しいメソッドを定義
    static func reloadWeather(for area: String, completion: @escaping (Result<WeatherCondition, Error>) -> Void) {
        do {
            let weatherConditionString = try YumemiWeather.fetchWeatherCondition(at: area)
            let weatherCondition = WeatherCondition(rawValue: weatherConditionString) ?? .sunny
            completion(.success(weatherCondition))
        } catch let error as YumemiWeatherError {
            completion(.failure(error))
        } catch {
            completion(.failure(error))
        }
    }
}
