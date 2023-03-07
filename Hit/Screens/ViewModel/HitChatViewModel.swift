//
//  HitChatViewModel.swift
//  Hit
//
//  Created by Catarina Serrano on 04/03/23.
//

import RxCocoa

protocol HitChatViewModelInput {
    func sendMessage(input: String)
}

protocol HitChatViewModelOutput {
    var chat: Driver<[Message]> { get }
}

protocol HitChatViewModel {
    var input: HitChatViewModelInput { get }
    var output: HitChatViewModelOutput { get }
}

extension HitChatViewModel where Self: HitChatViewModelInput & HitChatViewModelOutput {
    var input: HitChatViewModelInput { self }
    var output: HitChatViewModelOutput { self }
}
