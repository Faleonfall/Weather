import SwiftUI

struct TabBar: View {
    @Environment(WeatherStore.self) var store

    var action: () -> Void

    var body: some View {
        ZStack {
            // MARK: - Arc Shape
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay {
                    Arc()
                        .stroke(Color.tabBarBorder, lineWidth: 0.5)
                }

            // MARK: - Tab Items
            HStack {
                Button(
                    action: {
                        action()
                    },

                    label: {
                        Image(systemName: "mappin.and.ellipse")
                            .frame(width: 44, height: 44)
                    }
                )

                Spacer()

                Button {
                    withAnimation(.easeInOut) {
                        store.isShowingCityList = true
                    }
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

#Preview {
    TabBar(action: {})
        .environment(WeatherStore())
}
