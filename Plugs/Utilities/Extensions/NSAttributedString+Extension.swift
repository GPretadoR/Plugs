//
//  NSAttributedString+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    // Set part of string as URL
    public func setSubstringAsLink(substring: String, linkURL: String) -> NSMutableAttributedString {
        let range = mutableString.range(of: substring)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.link, value: linkURL, range: range)
            return self
        }
        return self
    }
}
