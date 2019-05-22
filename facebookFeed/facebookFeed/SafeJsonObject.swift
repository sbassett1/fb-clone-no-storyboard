//
//  SafeJsonObject.swift
//  facebookFeed
//
//  Created by Stephen Bassett on 6/7/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//

import Foundation
import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let selectorString = "set\(key.prefix(1).uppercased())\(String(key.dropFirst())):"
        let selector = Selector(selectorString)
        if responds(to: selector) {        //(AnyClass.self as? AnyClass, selector) {
            super.setValue(value, forKey: key)
        }
    }
}
