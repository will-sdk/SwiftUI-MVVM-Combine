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
    func create(_ ticket: Ticket) -> AnyPublisher<Void, Error>
}

final class TicketService: TicketServiceProtocol {
    private let db = Firestore.firestore()
    func create(_ ticket: Ticket) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("tickets").addDocument(from: ticket) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
