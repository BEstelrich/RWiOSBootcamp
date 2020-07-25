//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import Foundation


struct Clue: Codable, Equatable, Hashable {
  
  let id: Int?
  let answer: String?
  let question: String?
  let value: Int?
  let airdate: String?
  let createdAt: String?
  let updatedAt: String?
  let categoryId: Int?
  let category: Category?
  
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case answer = "answer"
    case question = "question"
    case value = "value"
    case airdate = "airdate"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case categoryId = "category_id"
    case category = "category"
  }
  
  
  static func == (lhs: Clue, rhs: Clue) -> Bool {
    return lhs.question == rhs.question && lhs.answer == rhs.answer
  }
  
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(question)
    hasher.combine(answer)
  }
  
}


struct Category: Codable {
  
  let id: Int?
  let title: String?
  let createdAt: String?
  let updatedAt: String?
  let cluesCount: Int?
  
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case cluesCount = "clues_count"
  }
  
}
