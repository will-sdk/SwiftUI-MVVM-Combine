//
//  TicketService.swift
//  SwiftUI-Combine
//
//  Created by Willy on 17/11/2022.
//

import Foundation
import Combine
import FirebaseFirestoreSwift
import FirebaseFirestore

protocol TicketServiceProtocol {
    func create(_ ticket: Ticket) -> AnyPublisher<Void, TicketError>
}

final class TicketService: TicketServiceProtocol {
    private let db = Firestore.firestore()
    func create(_ ticket: Ticket) -> AnyPublisher<Void, TicketError> {
        return Future<Void, TicketError> { promise in
            do {
                _ = try self.db.collection("tickets").addDocument(from: ticket) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
                promise(.success(()))
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
}
