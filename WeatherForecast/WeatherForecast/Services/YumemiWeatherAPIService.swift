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
            // fetchWeatherCondition(at:) を呼び出す
            let weatherConditionString = try YumemiWeather.fetchWeatherCondition(at: area)
            
            // 天気の状態を WeatherCondition に変換
            let weatherCondition = WeatherCondition(rawValue: weatherConditionString) ?? .sunny
            
            // 成功時に結果を completion に渡す
            completion(.success(weatherCondition))
        } catch let error as YumemiWeatherError {
            // YumemiWeatherError 型のエラーをキャッチ
            completion(.failure(error))
        } catch {
            // その他の予期しないエラーをキャッチ
            completion(.failure(error))
        }
    }
}
