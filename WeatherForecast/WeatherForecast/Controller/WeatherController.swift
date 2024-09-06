//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/06.
//

import SwiftUI

final class WeatherController: ObservableObject {
    @Published var weatherCondition: WeatherCondition = .sunny // 初期状態は晴れ
    
    // 天気情報をAPIから取得し、状態を更新するメソッド
    func reloadWeather() {
        YumemiWeatherAPIService.reloadWeather() { [weak self] weatherCondition in
            DispatchQueue.main.async {
                self?.weatherCondition = weatherCondition
            }
        }
    }
}
