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
        } catch {
            completion(.failure(error))
        }
    }
}


extension YumemiWeatherError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidParameterError:
            return NSLocalizedString("無効なパラメータが指定されました。再度お試しください。", comment: "")
        case .unknownError:
            return NSLocalizedString("不明なエラーが発生しました。再度お試しください。", comment: "")
        }
    }
}
