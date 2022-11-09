//
//  ContentView.swift
//  SwiftUI-Combine
//
//  Created by Willy on 08/11/2022.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive = false
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.18)
                    Text("Tickets")
                        .font(.system(size: 64,
                                      weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: SelectTeam(), isActive: $isActive) {
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(spacing: 15) {
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("Search Tickets")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }.padding(15)
                            .buttonStyle(PrimaryButtonStyle())
                    }
                }.frame(
                    maxWidth: .infinity,
                    maxHeight:  .infinity
                )
                .background(Image("stadium")
                    .resizable()
                    .aspectRatio(
                        contentMode: .fill
                    ).overlay(Color.black.opacity(0.4))
                    .frame(width: proxy.size.width)
                    .edgesIgnoringSafeArea(.all)
                )
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 8")
        LandingView().previewDevice("iPhone 11 Pro")
        LandingView().previewDevice("iPhone 14")
    }
}
