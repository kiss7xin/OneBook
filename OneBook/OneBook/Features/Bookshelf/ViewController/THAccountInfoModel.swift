//
//  THAccountInfoModel.swift
//  OneBook
//
//  Created by weixin on 2021/7/1.
//

import Foundation

class THAccountInfoModel: NSObject,NSCoding,NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var emailToken:String!
    
    func encode(with coder: NSCoder) {
        coder.encode(self.emailToken, forKey: "emailToken")
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.emailToken = coder.decodeObject(forKey: "emailToken") as? String
    }
    
    override init() {
        
    }
}
