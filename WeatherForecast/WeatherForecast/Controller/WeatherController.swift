//
//  WeatherController.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/06.
//

import SwiftUI

final class WeatherController: ObservableObject {
    @Published var weatherCondition: WeatherCondition = .sunny // 初期状態は晴れ
    @Published var errorMessage: String? // エラーメッセージを表示するためのプロパティ
    @Published var isErrorPresented: Bool = false
    
    // 天気情報をAPIから取得し、状態を更新するメソッド
    func reloadWeather() {

        let area = "tokyo"
        
        YumemiWeatherAPIService.reloadWeather(for: area) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherCondition):
                    self?.weatherCondition = weatherCondition
                    print(self?.weatherCondition ?? "")
                    self?.errorMessage = nil // エラーがなければメッセージをクリア
                case .failure(let error):
                    // エラーが発生した場合、エラーメッセージを更新
                    self?.errorMessage = "天気の取得に失敗しました: \(error.localizedDescription)"
                    print(self?.errorMessage ?? "")
                    self?.isErrorPresented = true
                }
            }
        }
    }
}

