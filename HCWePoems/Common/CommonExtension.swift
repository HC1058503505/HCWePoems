//
//  CommonExtension.swift
//  HCWePoems
//
//  Created by cgtn on 2019/9/6.
//  Copyright © 2019 cgtn. All rights reserved.
//

import Foundation

extension String {
    func pregReplace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return self
        }
        
        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: count), withTemplate: "")
    }
}
