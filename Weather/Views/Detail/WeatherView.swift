//
//  WeatherView.swift
//  Weather
//
//  Created by Volodymyr Kryvytskyi on 01.09.24.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            
            // MARK: Weather Widgets
            ScrollView(showsIndicators: false, content: {
                VStack(spacing: 20, content: {
                    ForEach(Forecast.cities) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                })
            })
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 65)
            }
            
        }
        .overlay(content: {
            // MARK: Navigation Bar
            NavigationBar()
        })
        .navigationBarHidden(true )
    }
}

#Preview {
    WeatherView()
}
