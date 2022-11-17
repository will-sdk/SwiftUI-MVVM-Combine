//
//  SelectTeamViewModel.swift
//  SwiftUI-Combine
//
//  Created by Willy on 10/11/2022.
//

import SwiftUI
import Combine

typealias UserId = String

final class SelectTeamViewModel: ObservableObject {
    @Published var teamDropdown = SelectPartViewModel(type: .team)
    @Published var amountDropdown = SelectPartViewModel(type: .amount)
    
    private let userService: UserServiceProtocol
    private let ticketService: TicketServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createTicket
    }
    
    init(userService: UserServiceProtocol = UserService(),
         ticketService: TicketServiceProtocol = TicketService()) {
        self.userService = userService
        self.ticketService = ticketService
    }
    
    func send(action: Action) {
        switch action {
        case .createTicket:
            currentUserId().flatMap { userId -> AnyPublisher<Void, Error> in
                return self.createTicket(userId: userId)
            }.sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellables)
        }
    }
    
    private func createTicket(userId: UserId) -> AnyPublisher<Void, Error> {
        guard let team = teamDropdown.text,
              let amount = amountDropdown.number else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        
        let ticket = Ticket(team: team,
                            amount: amount,
                            userId: userId,
                            startDate: Date()
        )
        
        return ticketService.create(ticket).eraseToAnyPublisher()
    }
    
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        print("getting user id")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, Error> in
            if let userId = user?.uid {
                print("user is logged in...")
                return Just(userId)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is being logged in aninymously...")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension SelectTeamViewModel {
    struct SelectPartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var hraderTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
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
            self.selectedOption = options.first!
        }
        
        enum SelectPartType: String, CaseIterable {
            case team = "Team"
            case amount = "Amount"
        }
        
        enum TeamOption: String, CaseIterable, DropdowmOptionProtocol {
            case cfc = "Chelsea"
            case liverpool = "LiverPool"
            case manu = "Manchester United"
            case tot = "Tottenham Hotspur"
            case ars = "Arsenal"
            case mancity = "Manchester City"
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized)
            }
        }
        
        enum AmountOption: Int, CaseIterable, DropdowmOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)")
            }
        }
    }
}

extension SelectTeamViewModel.SelectPartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}





