//
//  WeatherCondition.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/05.
//

import SwiftUI

enum WeatherCondition: String {
    case sunny
    case cloudy
    case rainy

    var color: Color {
        switch self {
        case .sunny:
            return .red
        case .cloudy:
            return .gray
        case .rainy:
            return .blue
        }
    }
}
