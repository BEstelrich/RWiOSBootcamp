// 2020.08.05 | AnimationFactory - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


class ViewController: UIViewController {
  
  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var animatedView: UIView!
  @IBOutlet weak var notificationView: UIView!
  @IBOutlet weak var notificationLabel: UILabel!
  @IBOutlet var homeButtonOffsetArrayOfConstraints: [NSLayoutConstraint]!
  
  private let animations = AnimationsHelper()
  
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
    animations.animateMenuButtons(with: homeButtonOffsetArrayOfConstraints, when: isMenuOpened)
    animations.startAnimations(in: animatedView, when: isMenuOpened)
  }
  
  
  @IBAction func transformButtonDidTap(_ sender: UIButton) {
    animations.addTransformationAnimation(to: animatedView)
    animations.showNotification(with: notificationLabel, category: .transformation, in: notificationView)
  }
  
  
  @IBAction func appearanceButtonDidTap(_ sender: UIButton) {
    animations.addAppearanceAnimation(to: animatedView)
    animations.showNotification(with: notificationLabel, category: .appearance, in: notificationView)
  }
  
  
  @IBAction func shapeButtonDidTap(_ sender: UIButton) {
    animations.addShapeAnimation(to: animatedView)
    animations.showNotification(with: notificationLabel, category: .shape, in: notificationView)
  }
  
}
