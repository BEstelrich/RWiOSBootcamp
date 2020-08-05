// 2020.08.05 | AnimationFactory - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


class ViewController: UIViewController {

  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var animatedView: UIView!
  @IBOutlet weak var notificationView: UIView!
  @IBOutlet weak var notificationTitleLabel: UILabel!
  @IBOutlet weak var notificationDescriptionLabel: UILabel!
  @IBOutlet var homeButtonOffsetArrayOfConstraints: [NSLayoutConstraint]!
  
  private let propertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .linear)

  private var isMenuOpened = false {
    didSet {
      isMenuOpened ? homeButton.setImage(UIImage(named: "Play.png"), for: .normal) : homeButton.setImage(UIImage(named: "Home.png"), for: .normal)
    }
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @IBAction func homeButtonDidTap(_ sender: UIButton) {
    animateMenuButtons()
    startAnimations()
  }
  
  
  @IBAction func changePositionButtonDidTap(_ sender: UIButton) {
    addTransformingAnimation()
    showAnimationNotification(for: .transforming)
  }
  
  
  @IBAction func changeColorButtonDidTap(_ sender: UIButton) {
    addAppearanceAnimation()
    showAnimationNotification(for: .appearance)
  }
  
  
  @IBAction func changeShapeButtonDidTap(_ sender: UIButton) {
    addShapeAnimation()
    showAnimationNotification(for: .shape)
  }

  
  func animateMenuButtons() {
    isMenuOpened.toggle()
    UIView.animate(
      withDuration: 1/3,
      delay: 0,
      options: .curveEaseIn,
      animations: {
        self.homeButtonOffsetArrayOfConstraints.forEach { constraint in
          constraint.constant = self.isMenuOpened ? 15 : -60
        }
        self.view.layoutIfNeeded()
      }
    )
  }
  
  
  func startAnimations() {
    if !isMenuOpened {
      propertyAnimator.startAnimation()
      
      propertyAnimator.addCompletion { _ in
        let reversePropertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .linear)
        reversePropertyAnimator.addAnimations {
          self.resetAnimatedView()
        }
        reversePropertyAnimator.startAnimation()
      }
    }
  }
  
  
  func resetAnimatedView() {
    self.animatedView.transform = .identity
    self.animatedView.backgroundColor = .systemGreen
    self.animatedView.alpha = 1
    self.animatedView.layer.cornerRadius = 0
  }
  
  
  func addTransformingAnimation() {
    propertyAnimator.addAnimations {
      let transform = CGAffineTransform(translationX: 100, y: 150).rotated(by: .pi/2).scaledBy(x: 1.5, y: 1.5)
      self.animatedView.transform = transform
    }

  }
  
  
  func addAppearanceAnimation() {
    propertyAnimator.addAnimations {
      self.animatedView.backgroundColor = UIColor.systemRed
      self.animatedView.alpha = 0.5
    }
  }
  
  
  func addShapeAnimation() {
    propertyAnimator.addAnimations {
      self.animatedView.layer.cornerRadius = 50
    }
  }
  
  
  func showAnimationNotification(for animation: Style) {
    notificationView.layer.cornerRadius = 15

    switch animation {
    case .transforming:
      notificationTitleLabel.text = "Transforming animation added"
      notificationDescriptionLabel.text = "Object position, scale and rotation modifications has been scheduled to be animated."
      
    case .appearance:
      notificationTitleLabel.text = "Appearance animation added"
      notificationDescriptionLabel.text = "Object background and opacity modifications has been scheduled to be animated."
      
    case .shape:
      notificationTitleLabel.text = "Shape animation added"
      notificationDescriptionLabel.text = "Object shape modification has been scheduled to be animated."
    }
    
    UIView.animate(withDuration: 4,
                   delay: 0,
                   options: [.curveLinear],
                   animations: {
                    self.notificationView.isHidden = false
                    self.notificationView.transform = CGAffineTransform(translationX: 0, y: 1)
                    self.view.layoutIfNeeded()
    }) { _ in
      self.notificationView.transform = .identity
      self.notificationView.isHidden = true
    }
  }
  
}

enum Style: String {
  case transforming = "Transforming"
  case appearance = "Appearance"
  case shape = "Shape"
}
