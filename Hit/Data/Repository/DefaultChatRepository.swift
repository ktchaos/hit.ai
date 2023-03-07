//
//  DefaultChatRepository.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import Foundation
import RxSwift
import RxRelay

final class DefaultChatRepository: ChatRepository {
    private let remoteDataSource: RemoteChatDataSource
    private let disposeBag = DisposeBag()

    private let responsesRelay: BehaviorRelay<CompletionResponse?> = .init(value: nil)
    let response: Property<CompletionResponse?>

    init(remoteDataSource: RemoteChatDataSource = RemoteChatDataSource()) {
        self.remoteDataSource = remoteDataSource
        self.response = Property(responsesRelay)
    }

    func sendMessage(input: String) {
        remoteDataSource.sendMessage(input: input)
            .subscribe(onSuccess: { [weak self] in self?.responsesRelay.accept($0) })
            .disposed(by: disposeBag)
    }
}
