//
//  NavVC.swift
//  getInfo
//
//  Created by 三斗 on 5/17/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class NavVC: UINavigationController {
  var notifactionView = UIView()
  var notifationLabel = UILabel()
  var refreshAmount = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //navigationBar.translucent = false
    //setNotifaction()
    // Do any additional setup after loading the view.
  }
  
  func setAnimate(){
    UIView.animateWithDuration(1, animations: {
      self.notifactionView.transform  = CGAffineTransformMakeTranslation(0, 30)
    }) { (finish) in
      sleep(2)
      UIView.animateWithDuration(1, animations: {
        self.notifactionView.transform  = CGAffineTransformIdentity
        }, completion: { (finish) in
          UIView.animateWithDuration(0.5, animations: {
            self.notifationLabel.alpha = 0
            self.notifactionView.alpha = 0
          })
      })
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NavVC.setNotifaction(_:)), name: "getRefresh", object: nil)
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setNotifaction(notifaction:NSNotification){
    
    if let dict = notifaction.userInfo as? [String:String]{
        refreshAmount = Int(dict["data"]!)!
      }
      if refreshAmount > 0 {
        notifactionView = UIView(frame: CGRectMake(0,self.navigationBar.frame.height - 10,view.frame.width,30))
        notifactionView.backgroundColor = UIColor.orangeColor()
        view.addSubview(notifactionView)
        self.notifactionView.alpha = 0.8
        navigationBar.layer.zPosition = 50
        
        notifationLabel = UILabel(frame: CGRectMake(0,10,view.frame.width,10))
        notifationLabel.text = "刷新了\(refreshAmount)条数据"
        notifationLabel.textAlignment = .Center
        notifationLabel.textColor = UIColor.whiteColor()
        //notifationLabel.backgroundColor ＝ .whiteColor()
        notifactionView.addSubview(notifationLabel)
        
        setAnimate()
    }
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "getRefresh", object: nil)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
