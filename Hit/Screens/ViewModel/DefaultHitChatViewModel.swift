//
//  DefaultHitChatViewModel.swift
//  Hit
//
//  Created by Catarina Serrano on 04/03/23.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultHitChatViewModel: HitChatViewModel, HitChatViewModelOutput {
    private let chatRepository: ChatRepository
    private let disposeBag = DisposeBag()

    private let chatRelay: BehaviorRelay<[Message]> = .init(value: [])

    let chat: Driver<[Message]>

    init(chatRepository: ChatRepository = DefaultChatRepository()) {
        self.chatRepository = chatRepository
        self.chat = chatRelay.asDriver()

        bindChatRepository()
    }

    func bindChatRepository() {
        chatRepository.response.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self, let content = $0?.choices.first?.text else {
                    return
                }

                let modelMessage: Message = ModelResponseMessage(type: .model, content: content)
                self.chatRelay.accept(self.chatRelay.value + [modelMessage])
            })
            .disposed(by: disposeBag)
    }
}

extension DefaultHitChatViewModel: HitChatViewModelInput {
    func sendMessage(input: String) {
        guard !input.isEmpty else {
            return
        }

        let userMessage: Message = UserMessage(type: .user, content: input)
        chatRelay.accept(self.chatRelay.value + [userMessage])
        chatRepository.sendMessage(input: input)
    }
}
