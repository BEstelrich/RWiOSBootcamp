//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import Foundation


class Networking {
  
  static let shared = Networking()
  private init() {}
  
  
  func getRandomCategory(completion: @escaping ([Clue]?, ErrorMessage?) -> Void) {
    guard let url = URL(string: "https://www.jservice.io/api/random") else {
      completion(nil, .invalidURL)
      return
    }
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    
    let task = session.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        completion(nil, .unableToComplete)
        return
      }
      
      guard let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode) else {
          completion(nil, .invalidResponse)
          return
      }
      
      guard let data = data else {
        completion(nil, .invalidData)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let randomCategoryData = try decoder.decode([Clue].self, from: data)
        completion(randomCategoryData, nil)
      } catch {
        completion(nil, .invalidData)
      }
    }
    task.resume()
  }
  
  
  func getAllCluesInCategory(_ category: Category, completion: @escaping ([Clue]?, ErrorMessage?) -> Void) {
    guard let categoryId = category.id else {
        completion(nil, .invalidURL)
        return
    }
    
    guard let url = URL(string: "https://www.jservice.io/api/clues?category=\(categoryId)") else {
      completion(nil, .invalidURL)
      return
    }
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    
    let task = session.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        completion(nil, .unableToComplete)
        return
      }
      
      guard let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode) else {
          completion(nil, .invalidResponse)
          return
      }
      
      guard let data = data else {
        completion(nil, .invalidData)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let cluesData = try decoder.decode([Clue].self, from: data)
        print("Clues data: \(cluesData)")
        print("Clues data count: \(cluesData.count)")
        completion(cluesData, nil)
      } catch {
        completion(nil, .invalidData)
      }
    }
    task.resume()
  }
  
}
