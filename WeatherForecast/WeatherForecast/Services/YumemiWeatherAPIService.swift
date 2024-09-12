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
    static func reloadWeather(request: WeatherRequest, completion: (Result<WeatherResponse, Error>) -> Void) {
        guard let jsonString = try? JSONEncoder().encode(request),
              let jsonStringAsString = String(data: jsonString, encoding: .utf8) else {
            completion(.failure(YumemiWeatherAPIError.invalidRequestDataError))
            return
        }

        fetchWeather(with: jsonStringAsString, completion: completion)
    }

    // 天気情報を取得するメソッド
    static func fetchWeather(with jsonString: String, completion: (Result<WeatherResponse, Error>) -> Void) {
        
        // JSON文字列をData型に変換
        let jsonData = Data(jsonString.utf8)

        // リクエストを `YumemiWeather` API に送る
        do {
            let responseString = try YumemiWeather.fetchWeather(String(data: jsonData, encoding: .utf8) ?? "")
            
            // レスポンスデータをDataに変換
            let responseData = Data(responseString.utf8)
            
            // レスポンスデータをデコード
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(YumemiWeatherAPIError.decodingError))
            }
        } catch {
            completion(.failure(error))
        }
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
