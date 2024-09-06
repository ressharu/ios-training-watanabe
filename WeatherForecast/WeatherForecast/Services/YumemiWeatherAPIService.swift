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
    static func reloadWeather(area: String, date: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let request = WeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONEncoder().encode(request),
              let jsonStringAsString = String(data: jsonString, encoding: .utf8) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "リクエストのデータが正しくありません。もう一度試してください。"])
            completion(.failure(error))
            return
        }

        fetchWeather(with: jsonStringAsString, completion: completion)
    }

    // 天気情報を取得するメソッド
    static func fetchWeather(with jsonString: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        // JSON文字列をData型に変換
        guard let jsonData = jsonString.data(using: .utf8) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "システムエラーが発生しました。再度お試しください。"])
            completion(.failure(error))
            return
        }

        // リクエストを `YumemiWeather` API に送る
        do {
            let responseString = try YumemiWeather.fetchWeather(String(data: jsonData, encoding: .utf8) ?? "")
            
            // レスポンスデータをDataに変換
            guard let responseData = responseString.data(using: .utf8) else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "サーバーからのデータの処理に失敗しました。後ほど再度お試しください。"])
                completion(.failure(error))
                return
            }
            
            // レスポンスデータをデコード
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                print(weatherResponse)
                completion(.success(weatherResponse))
            } catch let decodingError {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "天気情報の読み取りに失敗しました。再度お試しください。"])
                completion(.failure(error))
            }
        } catch YumemiWeatherError.invalidParameterError {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "リクエストに無効な情報が含まれています。再度お試しください。"])
            completion(.failure(error))
        } catch YumemiWeatherError.unknownError {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "不明なエラーが発生しました。後ほど再度お試しください。"])
            completion(.failure(error))
        } catch {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "予期しないエラーが発生しました。再度お試しください。"])
            completion(.failure(error))
        }
    }
}
