//
//  ClosedView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/10.
//

import SwiftUI

struct ClosedView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {}
            .onAppear {
                isPresented = false
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
    }
}
