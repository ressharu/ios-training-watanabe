//
//  YumemiWeatherAPIService.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import Foundation
import YumemiWeather

protocol WeatherAPIServiceDelegate: AnyObject {
    func didReceiveWeatherResponse(_ response: WeatherResponse)
    func didFailWithError(_ error: Error)
}

final class YumemiWeatherAPIService {
    weak var delegate: WeatherAPIServiceDelegate?
    // リロード用のメソッド
    func reloadWeather(request: WeatherRequest) {
        guard let jsonString = encodeWeatherRequest(request) else {
            delegate?.didFailWithError(YumemiWeatherAPIError.invalidRequestDataError)
            return
        }
        fetchWeather(with: jsonString)
    }
    
    // 天気情報を取得するメソッド
    func fetchWeather(with jsonString: String) {
        let jsonData = Data(jsonString.utf8)
        Task {
            do {
                let responseString = try YumemiWeather.syncFetchWeather(String(data: jsonData, encoding: .utf8) ?? "")
                guard let weatherResponse = decodeWeatherResponse(responseString) else {
                    delegate?.didFailWithError(YumemiWeatherAPIError.decodingError)
                    return
                }
                delegate?.didReceiveWeatherResponse(weatherResponse)
            } catch {
                delegate?.didFailWithError(error)
            }
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
