//
//  OpenAIAPIConstants.swift
//  Hit
//
//  Created by Catarina Serrano on 05/03/23.
//

import Foundation

struct OpenAIAPIConstants {
    static let baseURL = URL(string: "https://api.openai.com/v1")
    static let completionPath = "/completions"
    ///  To use this app, you must replace the tokenAPI variable below for a API key that you will have to generate at openAI platform, you can find a simple tutorial at the Read.me file
    static let tokenAPI = ""
}
