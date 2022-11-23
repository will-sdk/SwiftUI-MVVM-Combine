//
//  TicketError.swift
//  SwiftUI-Combine
//
//  Created by Willy on 18/11/2022.
//

import Foundation

enum TicketError: LocalizedError {
case auth(description: String?)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "Something went wrong"
        }
    }
}
