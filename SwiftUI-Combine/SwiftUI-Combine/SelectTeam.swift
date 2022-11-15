//
//  SelectTeam.swift
//  SwiftUI-Combine
//
//  Created by Willy on 09/11/2022.
//

import SwiftUI

struct SelectTeam: View {
    @StateObject var viewModel = SelectTeamViewModel()
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.displayOptions.indices.map { index in
                let option = viewModel.displayOptions[index]
                return ActionSheet.Button.default(Text(option.formatted)) {
                    viewModel.send(action: .selectOption(index: index))
                }
            })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createTicket)
                }) {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            .actionSheet(isPresented: Binding<Bool>(
                get: {
                    viewModel.hasSelectedDropdown
                }, set: { _ in })
            ) {
                actionSheet
            }
            .navigationTitle("Select Team")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}
