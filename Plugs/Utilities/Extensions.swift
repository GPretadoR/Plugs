//
//  Extensions.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 2/10/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import UIKit

extension Collection {
    var nonEmpty: Self? {
        return isEmpty ? nil : self
    }
    
    func element(at index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Date {
    static var dateFormatddMMyyyy: String {
        return "dd-MM-yyyy"
    }

    static var dateFormatddMMyy: String {
        return "dd-MM-yy"
    }

    static var dateFormatddMMyyyySlashed: String {
        return "dd/MM/yyyy"
    }

    static var dateFormatddMMyyyySlashedAndTime: String {
        return "dd/MM/yyyy HH:mm:ss"
    }
    
    static var dateFormatddMMyySlashed: String {
        return "dd/MM/yy"
    }

    static var dateFormatMMMddyyTextual: String {
        return "MMM dd, yyyy"
    }

    static var dateFormatFull: String {
        return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }

    static var timeFormatFull: String {
        return "HH:mm:ss.SSSZ"
    }

    static func stringDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    static func stringFrom(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    static func dateFrom(string stringDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: stringDate)
    }

    static func dateFrom(string stringDate: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: stringDate)
    }

    static func dateString(fromDateString: String, fromFormat: String, toFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        guard let date = formatter.date(from: fromDateString) else { return nil }
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }

    static func formattedTime(timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let time: Date = formatter.date(from: timeString)!
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }

    private func randomNumberBetween(top: Double, bottom: Double) -> Double {
        var range = top - bottom
        if bottom > top {
            range = bottom - top
        }
        return Double(arc4random()) / Double(UINT32_MAX) * range
    }

    // Date + DateComponents
    static func + (_ lhs: Date, _ rhs: DateComponents) -> Date {
        return Calendar.current.date(byAdding: rhs, to: lhs)!
    }

    // DateComponents + Dates
    static func + (_ lhs: DateComponents, _ rhs: Date) -> Date {
        return rhs + lhs
    }

    // Date - DateComponents
    static func - (_ lhs: Date, _ rhs: DateComponents) -> Date {
        return lhs + (-rhs)
    }

    static func - (_ lhs: Date, _ rhs: Date) -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                               from: rhs,
                                               to: lhs)
    }
}

extension DateComponents {
    var fromNow: Date {
        return Calendar.current.date(byAdding: self,
                                     to: Date())!
    }

    var ago: Date {
        return Calendar.current.date(byAdding: -self,
                                     to: Date())!
    }

    static func + (_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
        return DateComponents.combineComponents(lhs, rhs)
    }

    static func - (_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
        return DateComponents.combineComponents(lhs, rhs, multiplier: -1)
    }

    static func combineComponents(_ lhs: DateComponents, _ rhs: DateComponents, multiplier: Int = 1)
        -> DateComponents {
        var result = DateComponents()
        result.second = (lhs.second ?? 0) + (rhs.second ?? 0) * multiplier
        result.minute = (lhs.minute ?? 0) + (rhs.minute ?? 0) * multiplier
        result.hour = (lhs.hour ?? 0) + (rhs.hour ?? 0) * multiplier
        result.day = (lhs.day ?? 0) + (rhs.day ?? 0) * multiplier
        result.weekOfYear = (lhs.weekOfYear ?? 0) + (rhs.weekOfYear ?? 0) * multiplier
        result.month = (lhs.month ?? 0) + (rhs.month ?? 0) * multiplier
        result.year = (lhs.year ?? 0) + (rhs.year ?? 0) * multiplier
        return result
    }

    static prefix func - (components: DateComponents) -> DateComponents {
        var result = DateComponents()
        if components.second != nil { result.second = -components.second! }
        if components.minute != nil { result.minute = -components.minute! }
        if components.hour != nil { result.hour = -components.hour! }
        if components.day != nil { result.day = -components.day! }
        if components.weekOfYear != nil { result.weekOfYear = -components.weekOfYear! }
        if components.month != nil { result.month = -components.month! }
        if components.year != nil { result.year = -components.year! }
        return result
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF)
    }

    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        var hexColor = hex
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        }
        if hexColor.count == 6 {
            hexColor.append("FF")
        }
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }

        return nil
    }
    
    var hexValue: String {
        guard let components = self.cgColor.components, components.count >= 3 else { return "" }
        
        let r: CGFloat = components[0]
        let g: CGFloat = components[1]
        let b: CGFloat = components[2]
        
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
protocol ViewBuilder: class {
    
}
extension UIView: ViewBuilder {
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func asImageSnapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }

    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func addCornerRadiusAndShadow(cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float) {
        layer.cornerRadius = cornerRadius
        if shadowOffset != .zero {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = shadowOpacity
        }
    }

    func addCornerRadius(cornerRadius: CGFloat) {
        self.addCornerRadiusAndShadow(cornerRadius: cornerRadius, shadowColor: .clear, shadowOffset: .zero, shadowRadius: .zero, shadowOpacity: .zero)
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    class func instanceFromNib(name: String) -> UIView {
        guard let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { return UIView() }
        return view
    }
}

extension ViewBuilder where Self: UIView {
    init(builder: (Self) -> Void) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        builder(self)
    }
}

extension UIImage {
    func scaledWithMaxWidthOrHeightValue(value: CGFloat) -> UIImage? {
        let width = size.width
        let height = size.height

        let ratio = width / height

        var newWidth = value
        var newHeight = value

        if ratio > 1 {
            newWidth = width * (newHeight / height)
        } else {
            newHeight = height * (newWidth / width)
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0)

        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func scaled(withScale scale: CGFloat) -> UIImage? {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }

    func merge(image: UIImage, atRect: CGRect, margin: CGSize, vertically: Bool) -> UIImage {
        let topImage = self
        let bottomImage = image

        let selfSize = self.size

        var size = CGSize.zero
        if vertically {
            size = CGSize(width: selfSize.width, height: selfSize.height + atRect.size.height + margin.height)
        } else {
            size = CGSize(width: selfSize.width + atRect.size.width + margin.width, height: selfSize.height)
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        topImage.draw(in: CGRect(x: 0, y: 0, width: selfSize.width, height: selfSize.height))

        bottomImage.draw(in: atRect, blendMode: .normal, alpha: 1)

        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

extension Int {
    var toTimeStamp: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1d:%02d:%02d", h, m, s) : String(format: "%02d:%02d", m, s)
    }

    var toLabeledTimeStamp: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1dh %02dm %02ds", h, m, s) : String(format: "%02dm %02ds", m, s)
    }

    var toKiloMeters: Double {
        return Double(self) / 1000.0
    }

    var minutes: DateComponents {
        var comps = DateComponents()
        comps.minute = self
        return comps
    }

    var hours: DateComponents {
        var comps = DateComponents()
        comps.hour = self
        return comps
    }

    var days: DateComponents {
        var comps = DateComponents()
        comps.day = self
        return comps
    }

    var weeks: DateComponents {
        var comps = DateComponents()
        comps.day = 7 * self
        return comps
    }

    var months: DateComponents {
        var comps = DateComponents()
        comps.month = self
        return comps
    }

    var years: DateComponents {
        var comps = DateComponents()
        comps.year = self
        return comps
    }
}

extension UInt {
    var toTimeStamp: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1d:%02d:%02d", h, m, s) : String(format: "%02d:%02d", m, s)
    }

    var toKiloMeters: Double {
        return Double(self) / 1000.0
    }
}

extension Double {
    var toMeters: Int {
        return Int(self * 1000)
    }

    var toKiloMeters: Double {
        return self / 1000.0
    }

    var toRadians: Double { return self * .pi / 180 }
    var toDegrees: Double { return self * 180 / .pi }
}

extension CGFloat {
    var toRadians: CGFloat { return self * .pi / 180 }
    var toDegrees: CGFloat { return self * 180 / .pi }
}

extension Data {
    mutating func append(string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        append(data!)
    }
}

extension NSMutableAttributedString {
    // Set part of string as URL
    public func setSubstringAsLink(substring: String, linkURL: String) -> Bool {
        let range = mutableString.range(of: substring)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.link, value: linkURL, range: range)
            return true
        }
        return false
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension CharacterSet {
    static func isLettersOnly(text: String) -> Bool {
        let set = CharacterSet(charactersIn: "0123456789!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢՜՝։…՛★–«»՚՞")
        if text.rangeOfCharacter(from: set) != nil {
            return false
        }
        return true
    }
}

enum FileWriteError: Error {
    case directoryDoesntExist
    case convertToDataIssue
}

protocol FileWriter {
    var fileName: String { get }
    func write(_ text: String) throws
}

extension FileWriter {
    var fileName: String { return "File.txt" }

    func write(_ text: String) throws {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileWriteError.directoryDoesntExist
        }

        let encoding = String.Encoding.utf8

        guard let data = text.data(using: encoding) else {
            throw FileWriteError.convertToDataIssue
        }

        let fileUrl = dir.appendingPathComponent(fileName)

        if let fileHandle = FileHandle(forWritingAtPath: fileUrl.path) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        } else {
            try text.write(to: fileUrl, atomically: false, encoding: encoding)
        }
    }
}
