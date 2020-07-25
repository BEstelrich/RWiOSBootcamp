//
//  NetworkingService.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import UIKit


class NetworkService {
  
  static let shared = NetworkService()
  private let cache = NSCache<NSString, UIImage>()
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
    
    guard let categoryCluesCount = category.cluesCount else {
      completion(nil, .invalidURL)
      return
    }
    
    let offset = categoryCluesCount >= 10 ? categoryCluesCount - 10 : 0
    
    guard let url = URL(string: "https://www.jservice.io/api/clues?category=\(categoryId)&offset=\(offset)") else {
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
        completion(cluesData, nil)
      } catch {
        completion(nil, .invalidData)
      }
    }
    task.resume()
  }
  
  
  func downloadImage(from stringURL: String, completion: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: stringURL)

    if let image = cache.object(forKey: cacheKey) {
      completion(image)
      return
    }

    guard let url = URL(string: stringURL) else {
      completion(nil)
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self,
        error == nil,
        let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode),
        let data = data,
        let image = UIImage(data: data) else {
          completion(nil)
          return
      }
      self.cache.setObject(image, forKey: cacheKey)
      completion(image)
    }
    task.resume()
  }
  
}
