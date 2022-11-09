//
//  SelectTeam.swift
//  SwiftUI-Combine
//
//  Created by Willy on 09/11/2022.
//

import SwiftUI

struct SelectTeam: View {
    @State private var isActive = false
    var body: some View {
        ScrollView {
            VStack {
                DropdownView()
                DropdownView()
                Spacer()
                NavigationLink(destination: SelectMatch(),
                               isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    }
                }
                
            }.navigationTitle("Select Team")
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 15)
        }
    }
}
