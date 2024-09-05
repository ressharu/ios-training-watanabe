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
    static func reloadWeather(area: String, date: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        // 仮のリクエスト JSON
        let request = WeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONEncoder().encode(request),
              let jsonStringAsString = String(data: jsonString, encoding: .utf8) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format: Unable to convert WeatherRequest to JSON string"])
            completion(.failure(error))
            return
        }

        fetchWeather(with: jsonStringAsString, completion: completion)
    }

    // 天気情報を取得するメソッド
    static func fetchWeather(with jsonString: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        // JSON文字列をData型に変換
        guard let jsonData = jsonString.data(using: .utf8) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format: Unable to convert jsonString to Data"])
            completion(.failure(error))
            return
        }

        // リクエストを `YumemiWeather` API に送る
        do {
            let responseString = try YumemiWeather.fetchWeather(String(data: jsonData, encoding: .utf8) ?? "")
            
            // レスポンスデータをDataに変換
            guard let responseData = responseString.data(using: .utf8) else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert responseString to Data"])
                completion(.failure(error))
                return
            }
            
            // レスポンスデータをデコード
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                print(weatherResponse)
                completion(.success(weatherResponse))
            } catch let decodingError {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode WeatherResponse: \(decodingError.localizedDescription)"])
                completion(.failure(error))
            }
        } catch YumemiWeatherError.invalidParameterError {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid parameter provided to YumemiWeather API"])
            completion(.failure(error))
        } catch YumemiWeatherError.unknownError {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred in YumemiWeather API"])
            completion(.failure(error))
        } catch {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected error occurred: \(error.localizedDescription)"])
            completion(.failure(error))
        }
    }
}
