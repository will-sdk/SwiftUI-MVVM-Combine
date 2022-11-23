//
//  DropdownItemProtocol.swift
//  SwiftUI-Combine
//
//  Created by Willy on 10/11/2022.
//

import Foundation

protocol DropdownItemProtocol {
    var options: [DropdownOption] { get }
    var hraderTitle: String { get }
    var dropdownTitle: String { get }
    var isSelected: Bool { get set }
    var selectedOption: DropdownOption { get set }
}

protocol DropdowmOptionProtocol {
    var toDropdownOption: DropdownOption { get }
}

struct DropdownOption {
    enum DropdownOptionType {
        case text(String)
        case number(Int)
    }
    let type: DropdownOptionType
    let formatted: String
}
