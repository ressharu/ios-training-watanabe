//
//  YumemiWeatherAPIService.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import Foundation
import YumemiWeather

final class YumemiWeatherAPIService {
    // リロード用のメソッド
    static func reloadWeather(request: WeatherRequest, completion: (Result<WeatherResponse, Error>) -> Void) {
        guard let jsonString = encodeWeatherRequest(request) else {
            completion(.failure(YumemiWeatherAPIError.invalidRequestDataError))
            return
        }
        fetchWeather(with: jsonString, completion: completion)
    }
    
    // 天気情報を取得するメソッド
    static func fetchWeather(with jsonString: String, completion: (Result<WeatherResponse, Error>) -> Void) {
        let jsonData = Data(jsonString.utf8)
        do {
            let responseString = try YumemiWeather.syncFetchWeather(String(data: jsonData, encoding: .utf8) ?? "")
            guard let weatherResponse = decodeWeatherResponse(responseString) else {
                completion(.failure(YumemiWeatherAPIError.decodingError))
                return
            }
            completion(.success(weatherResponse))
        } catch {
            completion(.failure(error))
        }
    }
    
    //エンコードテスト
    static func encodeWeatherRequest(_ request: WeatherRequest) -> String? {
        guard let jsonData = try? JSONEncoder().encode(request) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    //デコードテスト
    static func decodeWeatherResponse(_ jsonString: String) -> WeatherResponse? {
        let jsonData = Data(jsonString.utf8)
        return try? JSONDecoder().decode(WeatherResponse.self, from: jsonData)
    }
}

extension YumemiWeatherError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidParameterError:
            return String(localized: "無効なパラメータが指定されました。再度お試しください。")
        case .unknownError:
            return String(localized: "不明なエラーが発生しました。再度お試しください。")
        }
    }
}
