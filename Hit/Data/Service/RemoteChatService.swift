//
//  RemoteChatService.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import Foundation
import Moya
import RxSwift

final class RemoteChatService: ChatService {
    private let provider: MoyaProvider<OpenAIAPI>

    init() {
        let authPlugin = AccessTokenPlugin { _ in OpenAIAPIConstants.tokenAPI }
        self.provider = MoyaProvider<OpenAIAPI>(plugins: [authPlugin])
    }

    func sendMessage(input: String) -> Single<CompletionResponse> {
        return provider.rx.request(.completions(input: input))
            .map {
                do {
                    let completionResponse = try $0.map(CompletionResponse.self)
                    return completionResponse
                } catch {
                    // TODO: Handle error
                }

                return CompletionResponse(id: "", object: "", model: "", choices: [])
            }
    }
}

