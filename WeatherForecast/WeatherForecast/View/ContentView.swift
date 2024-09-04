//
//  ContentView.swift
//  WeatherForecast
//
//  Created by 渡邉 華輝 on 2024/09/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.5)

            HStack {
                Text("UILabel")
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: .infinity)
                Text("UILabel")
                    .foregroundColor(Color.red)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        
        Spacer().frame(height: 80)
        
        HStack {
            Button(action: {
                // ここに機能を追加
            }) {
                Text("Close")
                    .foregroundColor(Color.blue)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                // ここに機能を追加
            }) {
                Text("Relord")
                    .foregroundColor(Color.blue)
            }
            .frame(maxWidth: .infinity)
        }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
    }
}

#Preview {
    ContentView()
}
