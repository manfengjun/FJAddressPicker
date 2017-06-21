//
//  RequestModel.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import YYModel
enum ModelType {
    case AddressSection
}
class SJBRequestModel: NSObject {
    class func dataToModel(type:ModelType, response:AnyObject, status:Int, completion:(AnyObject,Int)-> Void) {
        if status == 1 {
            switch type {
            
            default:
                break
            }
            
        }
        else
        {
            completion("error" as AnyObject,status)
        }
    }
    class func dataArrayToModel(type:ModelType, response:AnyObject,  status:Int, completion:(AnyObject,Int)-> Void) {
        let dataArray = NSMutableArray()
        if status == 1 {
            switch type {
            case .AddressSection:
                for item in response as! NSArray {
                    let temmodel = FJAddressModel.yy_model(with: item as! [AnyHashable : Any])
                    if let model = temmodel {
                        dataArray.add(model)
                    }
                }
                break
            default:break
            }
            completion(dataArray,status)
        }
        else
        {
            completion("error" as AnyObject,status)
        }
    }
    // MARK: ------ 地址管理
    /// 地址分级
    ///
    /// - Parameters:
    ///   - level: level description
    ///   - parent_id: parent_id description
    ///   - completion: completion description
    class func pull_fetchAddressSection(level:Int, parent_id:Int,completion:@escaping (AnyObject,Int) -> Void){
        SJBRequest.Get(url: SJBRequestUrl.returnAddressMenuUrl(level: level, parent_id: parent_id)) { (response, status) in
            self.dataArrayToModel(type: .AddressSection, response: response, status: status, completion: completion)
        }
    }
}
