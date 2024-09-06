//
//  WeatherController.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/06.
//

import SwiftUI

final class WeatherController: ObservableObject {
    @Published var weatherCondition: WeatherCondition = .sunny // 初期状態は晴れ
    @Published var minTemperature: Int = 0 // 最低気温
    @Published var maxTemperature: Int = 0 // 最高気温
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
                    self?.weatherCondition = weatherResponse.weatherCondition
                    self?.minTemperature = weatherResponse.minTemperature
                    self?.maxTemperature = weatherResponse.maxTemperature
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
