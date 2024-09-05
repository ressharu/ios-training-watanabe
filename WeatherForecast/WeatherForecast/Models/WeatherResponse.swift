//
//  WeatherResponse.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

struct WeatherResponse: Codable {
    let condition: String

    enum CodingKeys: String, CodingKey {
        case condition = "sunny"
    }
}
