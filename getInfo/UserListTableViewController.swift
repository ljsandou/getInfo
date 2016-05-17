//
//  UserListTableViewController.swift
//  getInfo
//
//  Created by 三斗 on 5/10/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
  var dataList = [[String:String]]()
  var canExpansion = true
  var isExpanded = false
  @IBOutlet weak var refreshControler: UIRefreshControl!
  enum Cell:Int{
    case ExpandCell,userListCell
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView(frame: CGRect.zero)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    Public_Func.sharedInstance.getInfoList("getResult.php", parameter: nil) { (data) in
      dispatch_async(dispatch_get_main_queue(), {
        self.dataList = data
        print(self.dataList)
        self.tableView.reloadData()
      })
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source and delegate
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if isExpanded{
      return 2
    }else{
      return 1
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch Cell(rawValue: section)!{
    case .ExpandCell: return 1
    case .userListCell:return dataList.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch Cell(rawValue: indexPath.section)!{
    case .ExpandCell:
      let cell = tableView.dequeueReusableCellWithIdentifier("expandCell", forIndexPath: indexPath) as! expandTableViewCell
      cell.expandLabel.text = "文章列表"
      return cell
    case.userListCell:
      let cell = tableView.dequeueReusableCellWithIdentifier("userListCell", forIndexPath: indexPath) as! UserListTableViewCell
      cell.titleLabel.text = dataList[indexPath.row]["title"]
      cell.introLabel.text = dataList[indexPath.row]["intro"]
      let imageUrl =  dataList[indexPath.row]["imageUrl"]
      cell.userHeadimageView.setImageWithURL(NSURL(string:Define.imageIp + imageUrl!)!)
      return cell
    }
  }
  
  
  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    //sleep(2)
    refreshControler.endRefreshing()
     NSNotificationCenter.defaultCenter().postNotificationName("getRefresh", object: self, userInfo: nil)
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 0{
      if isExpanded == true {
        isExpanded = false
      }else if isExpanded == false{
        isExpanded = true
      }
      tableView.reloadData()
    }else{
      print("aaa")
    }
    
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    var rotation = CATransform3DMakeRotation(CGFloat(M_PI)/2, 0, 0.7, 0.4)
    rotation.m34 = 1.0 / -600
    cell.layer.shadowColor = UIColor.blackColor().CGColor
    cell.layer.shadowOffset = CGSizeMake(10,10)
    cell.alpha = 0
    cell.layer.transform = rotation
    cell.layer.anchorPoint = CGPointMake(0, 0.5)
    UIView.animateWithDuration(0.8) {
      cell.layer.transform = CATransform3DIdentity
      cell.alpha = 1
      cell.layer.shadowOffset = CGSizeMake(0, 0)
    }
  }
}
