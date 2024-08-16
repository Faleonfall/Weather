//
//  HomeView.swift
//  Weather
//
//  Created by Volodymyr Kryvytskyi on 16.08.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
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
            
            VStack {
                Text("Berlin")
                    .font(.largeTitle)
                
                VStack {
                    Text("25°" + "\n" + "Clear")
                    
                    Text("H:29°   L:18°")
                        .font(.title3.weight(.semibold))
                }
                
                Spacer()
            }
            .padding(.top, 51)
        }
    }
}

#Preview {
    HomeView()
}
