//
//  Message.swift
//  Hooligans
//
//  Created by 정명곤 on 2023/10/11.
//

import Foundation

// MARK: - MessageType

enum MessageType {
  case enter
  case talk
}

// MARK: - Message

public struct Message: Codable {
  let type: String
  let roomId: String
  let sender: String
  let message: String
}
