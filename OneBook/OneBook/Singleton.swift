//
//  Singleton.swift
//  OneBook
//
//  Created by weixin on 2021/6/17.
//

import Foundation

public final class Singleton {
    public static let shared = Singleton()
    private init() {}
}
