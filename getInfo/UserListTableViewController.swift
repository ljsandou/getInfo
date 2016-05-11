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
  
  // MARK: - Table view data source
  
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
}
