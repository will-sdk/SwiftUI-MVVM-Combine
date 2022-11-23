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
        Group {
            DropdownView(viewModel: $viewModel.teamDropdown)
            DropdownView(viewModel: $viewModel.amountDropdown)
        }
    }
    
    var mainContentView: some View {
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
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue  != nil)) {
            Alert(title: Text("Error!"),
                  message:  Text($viewModel.error.wrappedValue?.localizedDescription ?? ""), dismissButton: .default(Text("OK"), action: {
                viewModel.error = nil
            }))
        }
        .navigationTitle("Select Team")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
    }
}
