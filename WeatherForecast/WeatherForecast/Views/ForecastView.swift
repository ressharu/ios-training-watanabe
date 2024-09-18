//
//  ContentView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import SwiftUI

struct ForecastView<WeatherController: ForecastViewControllerProtocol>: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var weatherController: WeatherController
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Image(weatherController.weatherResponse.weatherCondition.ImageName)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(1.0, contentMode: .fit)
                        .foregroundStyle(weatherController.weatherResponse.weatherCondition.color)
                        .accessibilityIdentifier(weatherController.weatherResponse.weatherCondition.ImageName)
                    HStack(spacing: 0) {
                        Text("\(weatherController.weatherResponse.minTemperature)")
                            .foregroundStyle(Color.blue)
                            .frame(maxWidth: .infinity)
                        Text("\(weatherController.weatherResponse.maxTemperature)")
                            .foregroundStyle(Color.red)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
                    .overlay(alignment: .top) {
                        HStack(spacing: 0) {
                            Button("Close") {
                                dismiss()
                            }
                            .frame(maxWidth: .infinity)
                            Button("Reload") {
                                weatherController.reloadWeather()
                            }
                            .frame(maxWidth: .infinity)
                            .alert("Error", isPresented: $weatherController.hasError, presenting: weatherController.errorMessage) { _ in
                                Button("OK") {
                                }
                            } message: { errorMessage in
                                
                                Text(errorMessage)
                            }
                        }
                        .padding(.top, 80)
                        .frame(width: geometry.size.width / 2)
                    }
            }
            .frame(width: geometry.size.width / 2, height: geometry.size.height)
            .frame(maxWidth: .infinity)
        }
    }
}
