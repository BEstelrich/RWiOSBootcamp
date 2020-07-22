//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue {
  let id: Int
  let answer: String
  let question: String
  let value: Int
  let airdate: String
  let createdAt: String
  let updatedAt: String
  let categoryid: Int
  let gameid: JSONNull?
  let invalidCount: JSONNull?
  let category: Category
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case answer = "answer"
    case question = "question"
    case value = "value"
    case airdate = "airdate"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case categoryid = "category_id"
    case gameid = "game_id"
    case invalidCount = "invalid_count"
    case category = "category"
  }
}

struct Category {
  let id: Int
  let title: String
  let createdAt: String
  let updatedAt: String
  let cluesCount: Int
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case cluesCount = "clues_count"
  }
}


class JSONNull: Codable, Hashable {
  
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }
  
  public init() {}
  
  func hash(into hasher: inout Hasher) {
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}
