// 2020.05.30 | BullsEye - InfoViewController.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit
import WebKit

class InfoViewController: UIViewController {
  
  @IBOutlet weak var webView: WKWebView!
  
  let wikipediaRGBWebsite = "https://en.wikipedia.org/wiki/RGB_color_model"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadOnBrowser(fromString: wikipediaRGBWebsite)
  }
  
  
  func loadOnBrowser(fromString string: String) {
    let url = URL(string: string)
    let request = URLRequest(url: url!)
    webView.load(request)
  }
  
  
  @IBAction func closeButtonDidTap(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
}
