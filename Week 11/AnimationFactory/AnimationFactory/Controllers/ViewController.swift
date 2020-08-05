// 2020.08.05 | AnimationFactory - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


class ViewController: UIViewController {

  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var changePositionOffsetConstraint: NSLayoutConstraint!
  @IBOutlet weak var changeColorOffsetConstraint: NSLayoutConstraint!
  @IBOutlet weak var changeShapeOffsetConstraint: NSLayoutConstraint!
  
  private var isMenuOpened = false {
    didSet {
      isMenuOpened ? homeButton.setImage(UIImage(named: "Play.png"), for: .normal) : homeButton.setImage(UIImage(named: "Home.png"), for: .normal)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @IBAction func homeButtonDidTap(_ sender: UIButton) {
    isMenuOpened.toggle()
    animateMenuButtons()
    
  }
  
  func animateMenuButtons() {
    UIView.animate(
      withDuration: 1/3,
      delay: 0,
      options: .curveEaseIn,
      animations: {
        self.changePositionOffsetConstraint.constant = self.isMenuOpened ? 15 : -60
        self.changeColorOffsetConstraint.constant = self.isMenuOpened ? 15 : -60
        self.changeShapeOffsetConstraint.constant = self.isMenuOpened ? 15 : -60
        self.view.layoutIfNeeded()
      }
    )
  }
  
}
