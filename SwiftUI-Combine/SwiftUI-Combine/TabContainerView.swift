//
//  TabContainerView.swift
//  SwiftUI-Combine
//
//  Created by Willy on 22/11/2022.
//

import SwiftUI

struct TabContainerView: View {
    var body: some View {
        TabView {
            
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

struct TabItemViewModel {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case history
        case ticketList
        case setting
    }
}
