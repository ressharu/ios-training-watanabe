//
//  WeatherCondition.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/05.
//

import SwiftUI

enum WeatherCondition: String, Codable {
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
    
    var ImageName:  String  {
        switch self {
        case .sunny:
            return "sunny"
        case .cloudy:
            return "cloudy"
        case .rainy:
            return "rainy"
        }
    }
}
