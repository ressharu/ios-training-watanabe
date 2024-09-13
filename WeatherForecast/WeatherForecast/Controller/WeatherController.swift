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
        let weatherRequest: WeatherRequest = WeatherRequest(area: "tokyo", date: "2024-09-06T12:00:00+09:00")
        self.isLoading = true
        YumemiWeatherAPIService.reloadWeather(request: weatherRequest) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    self.weatherResponse = weatherResponse
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
}
