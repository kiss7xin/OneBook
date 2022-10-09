//
//  FindResponds.swift
//  OneBook
//
//  Created by weixin on 2021/9/9.
//

import UIKit

class FindResponds {
    func findRespondsList(responder: UIResponder, index:Int = 0) {
        if let next = responder.next {
            let nextIndex = index + 1
            print("index=\(index),responder=\(next)")
            findRespondsList(responder: next, index: nextIndex)
        }
    }
}
