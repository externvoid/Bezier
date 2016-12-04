//
//  ViewController.swift
//  Bezier
//
//  Created by AppWizard on 2015/04/17.
//  Copyright (c) 2015年 htanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate
    as! AppDelegate
  override func viewDidLoad() {
    super.viewDidLoad()
    let screenWidth = self.view.bounds.width
    let screenHeight = self.view.bounds.height
    let testDraw = TestDraw(frame: CGRectMake(20, 20, screenWidth - 40, screenHeight - 140))
    self.view.backgroundColor = UIColor.blueColor()
    testDraw.backgroundColor = UIColor.yellowColor()
    self.view.addSubview(testDraw)
//    self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

