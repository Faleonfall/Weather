//
//  HomeView.swift
//  Weather
//
//  Created by Volodymyr Kryvytskyi on 16.08.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: Background Color
                Color.background
                    .ignoresSafeArea()
                
                // MARK: Background Image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                // MARK: House Image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack(spacing: -10) {
                    Text("Berlin")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                            .multilineTextAlignment(.center)
                        
                        Text("H:29°   L:18°")
                            .font(.title3.weight(.semibold))
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                
                // MARK: Tab Bar
                TabBar(action: {})
                
            }
            .navigationBarHidden(true)
        }
    }
    
    
    private var attributedString: AttributedString {
        var string = AttributedString("25°" + "\n" + "Clear")
        
        if let temp = string.range(of: "25°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    HomeView()
}
