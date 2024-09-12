//
//  YumemiWeatherAPIError.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/10.
//

import Foundation

enum YumemiWeatherAPIError: LocalizedError {
    case invalidRequestDataError
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidRequestDataError:
            return "リクエストのデータが正しくありません。再度お試しください。"
        case .decodingError:
            return "天気情報の読み取りに失敗しました。再度お試しください。"
        case .unknownError:
            return "不明なエラーが発生しました。再度お試しください。"
        }
    }
}
