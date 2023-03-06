//
//  ChatDataSource.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import RxSwift

protocol ChatDataSource {
    func sendMessage(input: String) -> Single<CompletionResponse>
}
