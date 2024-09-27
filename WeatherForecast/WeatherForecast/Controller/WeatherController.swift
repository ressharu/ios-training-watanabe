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

final class WeatherControllerImpl: ForecastViewControllerProtocol, WeatherAPIServiceDelegate {
    @Published var weatherResponse: WeatherResponse = WeatherResponse(
        maxTemperature: 0,
        date: "",
        minTemperature: 0,
        weatherCondition: .sunny
    )
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
    
    private let yumemiWeatherAPIService = YumemiWeatherAPIService()
    
    init() {
        yumemiWeatherAPIService.delegate = self
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.reloadWeather()
        }
    }
    
    deinit {
        print("WeatherController deinit")
    }
    
    // 天気情報をAPIから取得し、状態を更新するメソッド
    func reloadWeather() {
        let weatherRequest: WeatherRequest = WeatherRequest(area: "tokyo",
            date: "2024-09-06T12:00:00+09:00"
        )
        self.isLoading = true
        yumemiWeatherAPIService.reloadWeather(request: weatherRequest)
    }
    
    func didReceiveWeatherResponse(_ response: WeatherResponse) {
        DispatchQueue.main.async {
            self.weatherResponse = response
            self.errorMessage = nil
            self.isLoading = false
        }
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
