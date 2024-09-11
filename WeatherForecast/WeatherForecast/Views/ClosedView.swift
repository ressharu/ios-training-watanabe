//
//  ClosedView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/10.
//

import SwiftUI

struct ClosedView: View {
    @State private var showClosedView = false
    
    var body: some View {
        VStack {}
            .onAppear {
                isPresented = false
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
    }
}
