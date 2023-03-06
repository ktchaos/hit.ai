//
//  OpenAIAPI.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import Foundation
import Moya

enum OpenAIAPI {
    case completions(input: String)
}

extension OpenAIAPI: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        return OpenAIAPIConstants.baseURL ?? URL(fileURLWithPath: "")
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .completions:
            return .bearer
        }
    }

    var path: String {
        switch self {
        case .completions:
            return OpenAIAPIConstants.completionPath
        }
    }

    var method: Moya.Method {
        switch self {
        case .completions:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .completions(let input):
            return .requestParameters(
                parameters: [
                    "model": "text-davinci-003",
                    "prompt": input,
                    "max_tokens": 1000,
                    "temperature": 0.5
                ],
                encoding: JSONEncoding.default
            )
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
