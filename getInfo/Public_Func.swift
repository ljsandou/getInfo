//
//  Public_Func.swift
//  getInfo
//
//  Created by 三斗 on 5/10/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class Public_Func: NSObject {
  static let sharedInstance = Public_Func()
  func getInfoList(url:String,parameter:[String:String]?,handle:[[String:String]] -> Void){
    AFHTTPSessionManager().POST(Define.IP + url, parameters: parameter, success: { (request, json) in
      if let status = json["status"] as? String{
        if status == "success"{
          if let result = json["result"] as? [[String:String]]{
              handle(result)
          }
        }
      }
    }) { (request, error) in
      print(error)
    }
  }
}
struct Define{
  static let netIp = "192.168.100.26"
  static let IP = "http://\(netIp)/interest/"
  static let imageIp = "http://\(netIp)/interest/thumb/"
}
