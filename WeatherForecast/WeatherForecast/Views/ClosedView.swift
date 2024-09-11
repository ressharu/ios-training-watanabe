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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showClosedView = true
                }
            }
            .onChange(of: showClosedView) {
                if !showClosedView {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showClosedView = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showClosedView) {
                ForecastView(showClosedView: $showClosedView)
            }
    }
}
