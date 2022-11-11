//
//  SelectTeamViewModel.swift
//  SwiftUI-Combine
//
//  Created by Willy on 10/11/2022.
//

import SwiftUI

final class SelectTeamViewModel: ObservableObject {
    @Published var dropdowns: [SelectPartViewModel] = [
        .init(type: .team),
        .init(type: .amount)
    ]
    
    enum Action {
        case selectOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropdownIndex != nil
    }
    
    var selectedDropdownIndex: Int? {
        dropdowns.enumerated().first(where: { $0.element.isSelected })?.offset
    }
    
    var displayOptions: [DropdownOption] {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return [] }
        return dropdowns[selectedDropdownIndex].options
    }
    
    func send(action: Action) {
        switch action {
        case let .selectOption(index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOption()
            dropdowns[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }
    
    func clearSelectedOption() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].options.indices.forEach { index in
            dropdowns[selectedDropdownIndex].options[index].isSelected = false
        }
    }
    
    func clearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].isSelected = false
    }
}

extension SelectTeamViewModel {
    struct SelectPartViewModel: DropdownItemProtocol {
        var options: [DropdownOption]
        
        var hraderTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            options.first(where: { $0.isSelected})?.formatted ?? ""
        }
        
        var isSelected: Bool = false
        
        private let type: SelectPartType
        init(type: SelectPartType) {
            switch type {
            case .team:
                self.options = TeamOption.allCases.map { $0.toDropdownOption }
            case .amount:
                self.options = AmountOption.allCases.map { $0.toDropdownOption }
            }
            self.type = type
        }
        
        enum SelectPartType: String, CaseIterable {
            case team = "Team"
            case amount = "Amount"
        }
        
        enum TeamOption: String, CaseIterable, DropdowmOptionProtocol {
            case cfc = "Chelsea"
            case liverpool = "LiverPool"
            case manu = "Manchester United"
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized,
                      isSelected: self == .cfc)
            }
        }
        
        enum AmountOption: Int, CaseIterable, DropdowmOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)",
                      isSelected: self == .one)
            }
        }
    }
}





