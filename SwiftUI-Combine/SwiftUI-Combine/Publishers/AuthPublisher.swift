//
//  AuthPublisher.swift
//  SwiftUI-Combine
//
//  Created by Willy on 21/11/2022.
//

import Combine
import FirebaseAuth

extension Publishers {
    struct AuthPublisher: Publisher {
        typealias Output = User?
        typealias Failure = Never
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Self.Output == S.Input {
            let authSubscription = AuthSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubscription)
        }
    }
    
    class AuthSubscription<S: Subscriber>: Subscription where S.Input == User?, S.Failure == Never {
        
        private var subscriber: S?
        private var handler: AuthStateDidChangeListenerHandle?
        
        init(subscriber: S) {
            self.subscriber = subscriber
            handler = Auth.auth().addStateDidChangeListener{ auth, user in
                _ = subscriber.receive(user)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
}
