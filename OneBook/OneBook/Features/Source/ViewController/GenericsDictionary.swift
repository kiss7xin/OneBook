//
//  GenericsDictionary.swift
//  OneBook
//
//  Created by weixin on 2022/3/11.
//

import Foundation
import UIKit
struct GenericsDictionary<Key: Hashable, Value> {
    private var data: [Key: Value]
    
    init(data: [Key: Value]) {
        self.data = data
    }
    
    subscript<T>(key: Key) -> T? {
        return data[key] as? T
    }
}


public final class CIImageKit<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol CIImageDownloadProtocol {
    associatedtype type
    var ci: type { get }
}

public extension CIImageDownloadProtocol {
    var ci: CIImageKit<Self> {
        get {
            return CIImageKit(self)
        }
    }
}

extension UIImageView: CIImageDownloadProtocol {}

extension CIImageKit where Base: UIImageView {
    func setImage(url: URL, placeHolder: UIImage?) {
        
    }
}
