//
//  NavigationBar.swift
//  Weather
//
//  Created by Volodymyr Kryvytskyi on 01.09.24.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // MARK: Back Button
                Button(
                    action: {
                        dismiss()
                    },
                    label: {
                        HStack(spacing: 5) {
                            // MARK: Back Button Icon
                            Image(systemName: "chevron.left")
                                .font(.system(size: 23).weight(.medium))
                                .foregroundColor(.secondary)
                            
                            Text("Weather")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        .frame(height: 44)
                    })
                
                Spacer()
                
                // MARK: More Button
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 28))
                    .frame(width: 44, height: 44, alignment: .trailing)
            }
            .frame(height: 52)
        }
        .frame(height: 200, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 49)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationBar()
}
