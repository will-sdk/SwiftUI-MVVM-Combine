//
//  SelectMatch.swift
//  SwiftUI-Combine
//
//  Created by Willy on 09/11/2022.
//

import SwiftUI

struct SelectMatch: View {
    var body: some View {
        VStack {
            Spacer()
            //DropdownView()
            Spacer()
            Button(action: {}) {
                Text("Select")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 15)
            Button(action: {}) {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
        }.navigationTitle("Select Match")
            .padding(.bottom, 15)
    }
}

struct SelectMatch_Previews: PreviewProvider {
    static var previews: some View {
        SelectMatch()
    }
}
