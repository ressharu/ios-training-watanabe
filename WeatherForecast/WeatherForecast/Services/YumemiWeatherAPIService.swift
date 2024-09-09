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
    static func reloadWeather(for area: String, completion: (Result<WeatherCondition, Error>) -> Void) {
        do {
            let weatherConditionString = try YumemiWeather.fetchWeatherCondition(at: area)
            let weatherCondition = WeatherCondition(rawValue: weatherConditionString) ?? .sunny
            completion(.success(weatherCondition))
        } catch let error as YumemiWeatherError {
            // NSErrorを作成してエラーメッセージを提供
            let errorMessage = NSError(domain: "YumemiWeatherAPI", code: error._code, userInfo: [
                NSLocalizedDescriptionKey: "天気情報の取得中にエラーが発生しました。再度お試しください。"
            ])
            completion(.failure(errorMessage))
        } catch {
            completion(.failure(error))
        }
    }
}
