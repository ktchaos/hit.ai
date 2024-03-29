//
//  DefaultChatRepository.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

final class DefaultChatRepository: ChatRepository {
    private let remoteDataSource: RemoteChatDataSource
    private let disposeBag = DisposeBag()
    private let chatRelay: BehaviorRelay<[Message]> = .init(value: [])

    let chat: Property<[Message]>

    init(remoteDataSource: RemoteChatDataSource = RemoteChatDataSource()) {
        self.remoteDataSource = remoteDataSource
        self.chat = Property(chatRelay)
    }

    func sendMessage(input: String) {
        let userMessage: Message = UserMessage(type: .user, content: input)
        let loadingStateMessage: Message = UserMessage(type: .loading, content: "")
        chatRelay.accept(self.chatRelay.value + [userMessage, loadingStateMessage])

        remoteDataSource.sendMessage(input: input)
            .subscribe(onSuccess: { [weak self] in
                guard let self, let content = $0.choices.first?.text else {
                    return
                }

                let formattedText = self.removeReturnsOnString(content)
                let modelMessage: Message = ModelResponseMessage(type: .model, content: formattedText)
                let newChatValue = self.chatRelay.value.filter { !($0.type == .loading) }
                self.chatRelay.accept(newChatValue + [modelMessage])
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Helpers
extension DefaultChatRepository {
    private func removeReturnsOnString(_ input: String) -> String {
        let newString = input.replacingOccurrences(of: "\n", with: "")
        return newString
    }
}
