//
//  RemoteChatDataSource.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import RxSwift

final class RemoteChatDataSource: ChatDataSource {
    private let service: RemoteChatService

    init(service: RemoteChatService = RemoteChatService()) {
        self.service = service
    }

    func sendMessage(input: String) -> RxSwift.Single<CompletionResponse> {
        service.sendMessage(input: input)
    }
}
