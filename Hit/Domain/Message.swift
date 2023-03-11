//
//  Message.swift
//  Hit
//
//  Created by Catarina Serrano on 06/03/23.
//

import Foundation

enum MessageType {
    case user
    case model
    case loading
}

protocol Message {
    var type: MessageType { get }
    var content: String { get }
}
