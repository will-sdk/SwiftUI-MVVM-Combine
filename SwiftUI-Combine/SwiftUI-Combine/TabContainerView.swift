//
//  TabContainerView.swift
//  SwiftUI-Combine
//
//  Created by Willy on 22/11/2022.
//

import SwiftUI

struct TabContainerView: View {
    @StateObject private var tabContainerViewModel = TabContacinerViewModel()
    
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedTab) {
            ForEach(tabContainerViewModel.tabItemViewModels, id: \.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }
                    .tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .history:
            Text("History")
        case .ticketList:
            Text("Ticket List")
        case . setting:
            Text("Settings")
        }
    }
}

final class TabContacinerViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .ticketList
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "book", title: "History Ticket", type: .history),
        .init(imageName: "list.bullet", title: "Ticket List", type: .ticketList),
        .init(imageName: "gear", title: "Settings", type: .setting)
    ]
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case history
        case ticketList
        case setting
    }
}
