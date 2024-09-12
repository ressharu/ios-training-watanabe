//
//  ClosedView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/10.
//

import SwiftUI

struct ClosedView: View {
    @State private var isPresented = false
    
    var body: some View {
        Color.black
            .background(.black)
            .task(id: isPresented) {
                    isPresented = true
            }
            .fullScreenCover(isPresented: $isPresented) {
                ForecastView()
            }
    }
}
