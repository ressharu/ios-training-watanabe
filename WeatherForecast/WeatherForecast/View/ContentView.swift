//
//  ContentView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 80) {
                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "globe")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                    
                    HStack(spacing: 0) {
                        Text("UILabel")
                            .foregroundStyle(Color.blue)
                            .frame(maxWidth: .infinity)
                        Text("UILabel")
                            .foregroundStyle(Color.red)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(spacing: 0) {
                    Button("Close") {
                        // TODO: ここに機能を追加
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button("Reload") {
                        // TODO: ここに機能を追加
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(width: geometry.size.width / 2, height: geometry.size.height)
            .frame(maxWidth: .infinity)
            
        }
    }
}

#Preview {
    ContentView()
}
