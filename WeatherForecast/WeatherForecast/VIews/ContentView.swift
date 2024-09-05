//
//  ContentView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import SwiftUI

struct ContentView: View {
    
    @State private var weatherCondition: WeatherCondition = .sunny // 初期状態は晴れ
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Image(weatherCondition.rawValue) // EnumのrawValueを使用して画像名を設定
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(1.0, contentMode: .fit)
                        .foregroundStyle(weatherCondition.color) // Enumのcolorプロパティを使用
                    HStack(spacing: 0) {
                        Text("UILabel")
                            .foregroundStyle(Color.blue)
                            .frame(maxWidth: .infinity)
                        Text("UILabel")
                            .foregroundStyle(Color.red)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
                    .overlay(alignment: .top) {
                        HStack(spacing: 0) {
                            Button("Close") {
                                // TODO: ここに機能を追加
                            }
                            .frame(maxWidth: .infinity)
                            Button("Reload") {
                                reloadWeather()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.top, 80)
                        .frame(width: geometry.size.width / 2)
                    }
            }
            .frame(width: geometry.size.width / 2, height: geometry.size.height)
            .frame(maxWidth: .infinity)
        }
    }

    // 天気情報をAPIから取得し、状態を更新
    func reloadWeather() {
        YumemiWeatherAPIService.reloadWeather() { weatherCondition in
            DispatchQueue.main.async {
                self.weatherCondition = weatherCondition
            }
        }
    }
}

#Preview {
    ContentView()
}
