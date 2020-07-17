//
//  SandwichCell.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
import UIKit


class SandwichCell: UITableViewCell {
  
  static let reuseIdentifier = "SandwichCell"
  
  @IBOutlet weak var thumbnail: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var sauceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var ratingNumberLabel: UILabel!
  
  
  func populate(with sandwich: Sandwich) {
    thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    nameLabel.text = sandwich.name
    sauceLabel.text = sandwich.sauceAmount.description
    ratingLabel.text = setRating(sandwich.rating)
    ratingNumberLabel.text = sandwich.rating.description
  }
  
  
  private func setRating(_ rating: Double) -> String {
    switch rating {
    case 0.0...0.9:
      return "☆☆☆☆☆"
    case 1.0...1.9:
      return "★☆☆☆☆"
    case 2.0...2.9:
      return "★★☆☆☆"
    case 3.0...3.9:
      return "★★★☆☆"
    case 4.0...4.9:
      return "★★★★☆"
    case 5.0:
      return "★★★★★"
    default:
      return "☆☆☆☆☆"
    }
  }
  
}
