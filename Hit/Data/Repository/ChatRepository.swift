//
//  ChatRepository.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import RxSwift

protocol ChatRepository {
    var response: Property<[CompletionResponse]> { get }

    func sendMessage(input: String)
}
