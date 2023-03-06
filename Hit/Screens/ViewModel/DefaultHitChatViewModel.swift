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
    private let responseCompletionRelay: BehaviorRelay<[String]> = .init(value: [])

    let responseCompletion: Driver<[String]>

    init(chatRepository: ChatRepository = DefaultChatRepository()) {
        self.chatRepository = chatRepository
        self.responseCompletion = responseCompletionRelay.asDriver()

        bindChatRepository()
    }

    func bindChatRepository() {
        chatRepository.response.asObservable()
            .subscribe(onNext: {
                print("[DEBUG] ", $0)
            })
            .disposed(by: disposeBag)
    }
}

extension DefaultHitChatViewModel: HitChatViewModelInput {
    func sendMessage(input: String) {
        chatRepository.sendMessage(input: input)
    }
}
