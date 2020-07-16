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
  
  
  func populate(with sandwich: Sandwich) {
    thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    nameLabel.text = sandwich.name
    sauceLabel.text = sandwich.sauceAmount.description
  }
  
}
