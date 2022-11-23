//
//  Ticket.swift
//  SwiftUI-Combine
//
//  Created by Willy on 17/11/2022.
//

import Foundation

struct Ticket: Codable {
    let team: String
    let amount: Int
    let userId: String
    let startDate: Date
}
