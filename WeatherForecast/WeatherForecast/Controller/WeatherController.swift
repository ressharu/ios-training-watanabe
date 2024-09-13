//
//  WeatherController.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/06.
//

import SwiftUI

protocol ForecastViewControllerProtocol: ObservableObject {
    var weatherResponse: WeatherResponse { get }
    var errorMessage: String? { get }
    var hasError: Bool { get set }
    var isLoading: Bool { get set }
    func reloadWeather()
}

final class WeatherControllerImpl: ForecastViewControllerProtocol {
    @Published var weatherResponse: WeatherResponse = WeatherResponse(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: .sunny)
    @Published var errorMessage: String? {
        didSet {
            self.hasError = (errorMessage != nil)
        }
    }
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false {
        didSet {
            print("isLoading changed to: \(isLoading)")
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.reloadWeather()
        }
    }
    
    // 天気情報をAPIから取得し、状態を更新するメソッド
    func reloadWeather() {
        print("isLoading: \(String(describing: isLoading))")
        
        let weatherRequest: WeatherRequest = WeatherRequest(area: "tokyo", date: "2024-09-06T12:00:00+09:00")
        
        YumemiWeatherAPIService.reloadWeather(request: weatherRequest) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = true
                switch result {
                case .success(let weatherResponse):
                    self?.weatherResponse = weatherResponse
                    self?.errorMessage = nil // エラーがなければメッセージをクリア
                case .failure(let error):
                    self?.errorMessage = String(error.localizedDescription)
                    print(self?.errorMessage ?? "")
                }
                self?.isLoading = false
                print("After isLoading: \(String(describing: self?.isLoading))")
            }
        }
    }
}
