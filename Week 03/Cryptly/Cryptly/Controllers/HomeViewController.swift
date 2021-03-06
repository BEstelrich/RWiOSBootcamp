/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
import UIKit


class HomeViewController: UIViewController {
  
//  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1: WidgetView!
  @IBOutlet weak var view2: WidgetView!
  @IBOutlet weak var view3: WidgetView!
  @IBOutlet weak var view4: WidgetView!
  @IBOutlet weak var view5: WidgetView!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var view4TextLabel: UILabel!
  @IBOutlet weak var view4TitleLabel: UILabel!
  @IBOutlet weak var view5TextLabel: UILabel!
  @IBOutlet weak var view5TitleLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  /// This variable stores theme selection between relaunches.
  lazy var userSettings = UserDefaults.standard
  
  lazy var cryptoData: [CryptoCurrency]? = {
    guard let validGeneratedData = DataGenerator.shared.generateData() else { return nil }
    return validGeneratedData
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setView4Data()
    setView5Data()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
    restoreStatus(for: themeSwitch)
    setTheme(with: themeSwitch)
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  
  
  func setupLabels() {
    view1TextLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    view2TextLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    view3TextLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    view4TextLabel.font = UIFont.systemFont(ofSize: 25, weight: .black)
    view5TextLabel.font = UIFont.systemFont(ofSize: 25, weight: .black)
  }
  
  
  func setView1Data() {
    view1TextLabel.text = cryptoData?.reduce(into: [], { (result, cryptoCurrency) in
      result.append(cryptoCurrency.name)
    }).joined(separator: ", ")
  }
  
  
  func setView2Data() {
    view2TextLabel.text = cryptoData?.reduce(into: [], { (result, cryptoCurrency) in
      if cryptoCurrency.currentValue > cryptoCurrency.previousValue {
        result.append(cryptoCurrency.name)
      }
    }).joined(separator: ", ")
  }
  
  
  func setView3Data() {
    view3TextLabel.text = cryptoData?.reduce(into: [], { (result, cryptoCurrency) in
      if cryptoCurrency.currentValue < cryptoCurrency.previousValue {
        result.append(cryptoCurrency.name)
      }
    }).joined(separator: ", ")
  }
  
  
  func setView4Data() {
    view4TextLabel.text = cryptoData?.filter({ cryptoCurrency -> Bool in
      cryptoCurrency.currentValue < cryptoCurrency.previousValue
    }).map({ (cryptoCurrency) -> Double in
      cryptoCurrency.currentValue - cryptoCurrency.previousValue
      }).min()?.description
  }
  
  
  func setView5Data() {
    view5TextLabel.text = cryptoData?.filter({ cryptoCurrency -> Bool in
      cryptoCurrency.currentValue > cryptoCurrency.previousValue
    }).map({ (cryptoCurrency) -> Double in
      cryptoCurrency.currentValue - cryptoCurrency.previousValue
      }).max()?.description
  }

  
  /// Restores the ThemeSwitch last position.
  func restoreStatus(for themeSwitch: UISwitch) {
    themeSwitch.isOn = userSettings.bool(forKey: "DarkTheme")
  }
  
  
  func setTheme(with themeSwitch: UISwitch) {
    themeSwitch.isOn ? ThemeManager.shared.set(theme: DarkTheme()) : ThemeManager.shared.set(theme: LightTheme())
    
    userSettings.set(themeSwitch.isOn, forKey: "DarkTheme")
  }
  
  
  /// Defines all view parameters for any theme application.
  func applyTheme(_ currentTheme: Theme?) {
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: currentTheme?.textColor ?? .black]
    
    view1.backgroundColor = currentTheme?.widgetBackgroundColor
    view2.backgroundColor = currentTheme?.widgetBackgroundColor
    view3.backgroundColor = currentTheme?.widgetBackgroundColor
    view4.backgroundColor = currentTheme?.widgetBackgroundColor
    view5.backgroundColor = currentTheme?.widgetBackgroundColor
    
    view1.layer.borderColor = currentTheme?.borderColor.cgColor
    view2.layer.borderColor = UIColor.systemGreen.cgColor
    view3.layer.borderColor = UIColor.systemRed.cgColor
    view4.layer.borderColor = UIColor.systemRed.cgColor
    view5.layer.borderColor = UIColor.systemGreen.cgColor
    
    view1.layer.borderWidth = 4
    view2.layer.borderWidth = 4
    view3.layer.borderWidth = 4
    view4.layer.borderWidth = 4
    view5.layer.borderWidth = 4
    
    view1TextLabel.textColor = currentTheme?.textColor
    view2TextLabel.textColor = currentTheme?.textColor
    view3TextLabel.textColor = currentTheme?.textColor
    view4TitleLabel.textColor = currentTheme?.textColor
    view4TextLabel.textColor = .systemRed
    view5TitleLabel.textColor = currentTheme?.textColor
    view5TextLabel.textColor = .systemGreen
    
    view.backgroundColor = currentTheme?.backgroundColor
    navigationController?.navigationBar.barStyle = currentTheme?.statusBarTint ?? .black
    navigationController?.navigationBar.barTintColor = currentTheme?.backgroundColor
  }
  
  
  @IBAction func switchPressed(_ sender: UISwitch) {
    setTheme(with: sender)
  }
  
}


extension HomeViewController: Themable {
  
  func registerForTheme() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(themeChanged),
                                           name: Notification.Name.init("themeChanged"),
                                           object: nil)
  }
  
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }

  
  @objc func themeChanged() {
    applyTheme(ThemeManager.shared.currentTheme)
  }
  
}
