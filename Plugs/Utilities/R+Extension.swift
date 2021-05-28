//
//  R+Extension.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 2/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import Rswift

extension R {
    
    enum Languages: String {
        case ar, en, nl, ja, ko, vi, ru, sv, fr, es, pt, it, de, da, fi, nb, tr, el, id, ms, th, hi, hu, hy, pl, cs, sk, uk, hr, ca, ro, he, ur, fa, ku, arc
        case enGB = "en-GB"
        case enAU = "en-AU"
        case enCA = "en-CA"
        case enIN = "en-IN"
        case frCA = "fr-CA"
        case esMX = "es-MX"
        case ptBR = "pt-BR"
        case zhHans = "zh-Hans"
        case zhHant = "zh-Hant"
        case zhHK = "zh-HK"
    }
    
    static var defaultLanguage: Languages {
        get {
            guard let lang = UserDefaults.standard.value(forKey: "AppleLanguage") as? String else {
                let code = Locale.preferredLanguages[0]
                let language = Languages(rawValue: code) ?? .en
                R.setDefaultLanguage(language)
                return language
            }
            return Languages(rawValue: lang) ?? .en
        }
        set {
            R.setDefaultLanguage(newValue)
        }
    }
    
    static func setDefaultLanguage(_ language: Languages) {
        UserDefaults.standard.set(language.rawValue, forKey: "AppleLanguage")
        UserDefaults.standard.synchronize()
    }
}

extension StringResource {
    
    public func localizedCustomizable() -> String {
        let text = localized()
        return text
    }
    
    public func localizedCustomizable(key: String) -> String {
        let text = localized()
        return text
    }
    
    public func localized() -> String {
        guard
            let basePath = bundle.path(forResource: "Base", ofType: "lproj"),
            let baseBundle = Bundle(path: basePath)
            else {
                return self.key
        }
        
        let fallback = baseBundle.localizedString(forKey: key, value: key, table: tableName)
        
        let language = R.defaultLanguage.rawValue
        
        guard
            let localizedPath = bundle.path(forResource: language, ofType: "lproj"),
            let localizedBundle = Bundle(path: localizedPath)
            else {
                return fallback
        }
        
        return localizedBundle.localizedString(forKey: key, value: fallback, table: tableName)
    }
    
    public func localized(_ language: String) -> String {
        guard
            let basePath = bundle.path(forResource: "Base", ofType: "lproj"),
            let baseBundle = Bundle(path: basePath)
            else {
                return self.key
        }
        
        let fallback = baseBundle.localizedString(forKey: key, value: key, table: tableName)
        
        guard
            let localizedPath = bundle.path(forResource: language, ofType: "lproj"),
            let localizedBundle = Bundle(path: localizedPath)
            else {
                return fallback
        }
        
        return localizedBundle.localizedString(forKey: key, value: fallback, table: tableName)
    }
}
