// 2020.08.05 | AnimationFactory - ViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


class ViewController: UIViewController {

  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var animatedView: UIView!
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
    showAnimationNotification()
  }
  
  
  @IBAction func changeColorButtonDidTap(_ sender: UIButton) {
    addAppearanceAnimation()
    showAnimationNotification()
  }
  
  
  @IBAction func changeShapeButtonDidTap(_ sender: UIButton) {
    addShapeAnimation()
    showAnimationNotification()
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
    showAnimationNotification()
  }
  
  
  func addShapeAnimation() {
    propertyAnimator.addAnimations {
      self.animatedView.layer.cornerRadius = 50
    }
    showAnimationNotification()
  }
  
  
  func showAnimationNotification() {
    print("Notification added to the queue.")
  }
  
}

