// 2020.08.06 | AnimationFactory - AnimationHelper.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit

struct AnimationsHelper {
  
  let objectAnimator = UIViewPropertyAnimator(duration: 2, curve: .linear)
  let notificationAnimator = UIViewPropertyAnimator(duration: 4, curve: .linear)
  
  enum Category {
    case transformation
    case appearance
    case shape
  }
  
  
  // MARK: - Object animations.
  func addTransformationAnimation(to view: UIView) {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    let randomXPosition = CGFloat.random(in: 1..<rootViewController!.view.frame.width) - view.center.x
    let randomYPosition = CGFloat.random(in: 1..<rootViewController!.view.frame.height) - view.center.y
    
    objectAnimator.addAnimations {
      let transform = CGAffineTransform(translationX: randomXPosition, y: randomYPosition).rotated(by: .pi/2).scaledBy(x: 1.5, y: 1.5)
      view.transform = transform
    }
  }
  
  
  func addAppearanceAnimation(to view: UIView) {
    objectAnimator.addAnimations {
      view.backgroundColor = UIColor.systemRed
      view.alpha = 0.5
    }
  }
  
  
  func addShapeAnimation(to view: UIView) {
    objectAnimator.addAnimations {
      view.layer.cornerRadius = 50
    }
  }
  
  
  func startAnimations(in view: UIView, when isMenuOpened: Bool) {
    if !isMenuOpened {
      objectAnimator.startAnimation()
      
      objectAnimator.addCompletion { _ in
        let reversePropertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .linear)
        reversePropertyAnimator.addAnimations {
          self.resetAnimatedView(to: view)
        }
        reversePropertyAnimator.startAnimation()
      }
    }
  }
  
  
  func resetAnimatedView(to view: UIView) {
    view.transform = .identity
    view.backgroundColor = .systemGreen
    view.alpha = 1
    view.layer.cornerRadius = 0
  }
  
  
  // MARK: - Menu animation.
  func animateMenuButtons(with constraints: [NSLayoutConstraint], when isMenuOpened: Bool) {
    UIView.animate(
      withDuration: 1/5,
      delay: 0,
      options: .curveEaseIn,
      animations: {
        constraints.forEach { constraint in
          constraint.constant = isMenuOpened ? 15 : -60
        }
        
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController!.view.layoutIfNeeded()
      }
    )
  }
  
  
  // MARK: - Notification animation.
  func showNotification(with label: UILabel, category: Category, in view: UIView) {
    view.layer.cornerRadius = 15
    
    switch category {
    case .transformation:
      label.text = "Transforming animation added"

    case .appearance:
      label.text = "Appearance animation added"

    case .shape:
      label.text = "Shape animation added"
    }

    if notificationAnimator.isRunning {
      notificationAnimator.stopAnimation(true)
    }

    notificationAnimator.addAnimations {
      view.isHidden = false
      view.transform = CGAffineTransform(translationX: 0, y: 1)
    }

    notificationAnimator.startAnimation()

    notificationAnimator.addCompletion { _ in
      view.transform = .identity
      view.isHidden = true
    }
  }
  
}
