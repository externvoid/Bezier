//
//  ViewController.swift
//  Bezier
//
//  Created by AppWizard on 2015/04/17.
//  Copyright (c) 2015年 htanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var appDelegate: AppDelegate = UIApplication.shared.delegate
    as! AppDelegate
  override func viewDidLoad() {
    super.viewDidLoad()
    let screenWidth = self.view.bounds.width
    let screenHeight = self.view.bounds.height
    let testDraw = TestDraw(frame: CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight - 140))
    self.view.backgroundColor = UIColor.blue
    testDraw.backgroundColor = UIColor.yellow
    self.view.addSubview(testDraw)
//    self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

