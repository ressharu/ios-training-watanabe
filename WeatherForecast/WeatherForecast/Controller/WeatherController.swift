//
//  WeatherController.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/06.
//

import SwiftUI

final class WeatherController: ObservableObject {
    @Published var weatherResponse: WeatherResponse = WeatherResponse(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: .sunny)
    @Published var errorMessage: String? // エラーメッセージを表示するためのプロパティ
    @Published var isErrorPresented: Bool = false
    
    // 天気情報をAPIから取得し、状態を更新するメソッド
    func reloadWeather() {

        let area = "tokyo"
        let date = "2024-09-06T12:00:00+09:00"
        
        YumemiWeatherAPIService.reloadWeather(area: area, date: date) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    self?.weatherResponse = weatherResponse
                    self?.errorMessage = nil // エラーがなければメッセージをクリア
                case .failure(let error):
                    self?.errorMessage = String(error.localizedDescription)
                    print(self?.errorMessage ?? "")
                    self?.isErrorPresented = true
                }
            }
        }
    }
}
