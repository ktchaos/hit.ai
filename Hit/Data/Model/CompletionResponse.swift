//
//  CompletionResponse.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

struct CompletionResponse: Codable {
    let id: String
    let object: String
    let model: String
    let choices: [ModelOptionResponse]
}
