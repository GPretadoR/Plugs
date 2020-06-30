//
//  Utils.swift
//  LiveResults
//
//  Created by Garnik Ghazaryan on 10/7/18.
//  Copyright © 2018 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class Utils {
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    static func locale(for fullCountryName: String) -> String {
        let locales: String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }

    static func code(forCountry: String) -> String {
        var countryCode: String = ""
        if let path = Bundle.main.path(forResource: "country", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResultArr: [[String: AnyObject]] = jsonResult as? Array {
                    for dict in jsonResultArr where (dict["Name"] as? String) == forCountry {
                        guard let code = dict["Code"] as? String else { return "" }
                        countryCode = code
                    }
                }
            } catch {
                // handle error
            }
        }
        return countryCode
    }

    static func readJson(fileName: String) -> [String: Any] {
        do {
            if let file = Bundle.main.path(forResource: fileName, ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    return object
                } else if let object = json as? [Any] {
                    return [fileName: object]
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return ["": ""]
    }

    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    static func addUniqueObserver(observer: Any, selector: Selector, name: NSNotification.Name, object: Any?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }

    static func getDateBasedAppVersion() -> String {
        var versionString = ""
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        let yearString = df.string(from: Date())
        guard let yearInt = Int(yearString) else {
            return "1.0.0"
        }
        let versionYear = yearInt - 2018
        versionString.append(String(versionYear))
        df.dateFormat = "M"
        versionString.append("." + df.string(from: Date()))
        df.dateFormat = "d"
        versionString.append("." + df.string(from: Date()))

        return versionString
    }

    static func getBundleVersion() -> String {
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return build
        }
        return "1.0.0"
    }

    static func getBundleShortVersion() -> String {
        if let build = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return build
        }
        return "1.0.0"
    }

    static var avarageSpeed: Double {
        return (15.0 * 1000.0 / 3600)
    }
}
