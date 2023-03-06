//
//  ModelOptionResponse.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

struct ModelOptionResponse: Codable {
    let text: String
    let finishReason: String

    private enum CodingKeys: String, CodingKey {
        case text
        case finishReason = "finish_reason"
    }
}
