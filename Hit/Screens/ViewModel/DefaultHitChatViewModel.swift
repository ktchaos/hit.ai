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

    private let cellViewModelsRelay: BehaviorRelay<[MessageCellViewModel]> = .init(value: [])

    let cellViewModels: Driver<[MessageCellViewModel]>

    init(chatRepository: ChatRepository = DefaultChatRepository()) {
        self.chatRepository = chatRepository
        self.cellViewModels = cellViewModelsRelay.asDriver()

        bindChatRepository()
    }

    func bindChatRepository() {
        chatRepository.chat.asDriver()
            .drive { [weak self] in
                let cellModels = $0.map { MessageCellViewModel(message: $0.content, type: $0.type) }
                self?.cellViewModelsRelay.accept(cellModels)
            }
            .disposed(by: disposeBag)
    }
}

extension DefaultHitChatViewModel: HitChatViewModelInput {
    func sendMessage(input: String) {
        guard !input.isEmpty else {
            return
        }

        chatRepository.sendMessage(input: input)
    }
}
