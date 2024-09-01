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
