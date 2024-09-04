//
//  YumemiWeatherAPIService.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import Foundation

class YumemiWeatherAPIService {

    // 天気情報を取得するメソッド
    static func fetchWeather(with jsonString: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        // JSON文字列をData型に変換
        guard let jsonData = jsonString.data(using: .utf8) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"])
            completion(.failure(error))
            return
        }

        // リクエストURLを指定（仮のエンドポイント）
        guard let url = URL(string: "https://api.example.com/weather") else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        // リクエストの設定
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // URLSessionを使った通信処理
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // ネットワークエラーのチェック
            if let error = error {
                completion(.failure(error))
                return
            }

            // レスポンスのステータスコードを確認
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server responded with status code: \(httpResponse.statusCode)"])
                completion(.failure(error))
                return
            }

            // データがnilの場合
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from the server"])
                completion(.failure(error))
                return
            }

            // レスポンスデータをデコード
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
