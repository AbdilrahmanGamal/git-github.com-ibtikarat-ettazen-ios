//
//  extensionString.swift
//  Alhabibshop
//
//  Created by Abdilrahman on 12/6/20.
//  Copyright © 2020 adyas. All rights reserved.
//

import UIKit


extension String {
    
    var color_ : UIColor {
        return UIColor.init(named: self) ?? UIColor.hexColor(hex: self)
    }
    
    var image_ : UIImage? {
        return UIImage(named: self)
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) / 60 % 60)
        let seconds = Int(time) % 60
        let minuteStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"

        if hours == 0 {
            return "\(minuteStr):\(secondsStr)"
        } else{
            return "\(hours):\(minuteStr):\(secondsStr)"
        }
    }
    
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    
    func toDateTime() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
        dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    
    
    func toDateOnly() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    
    
    
    
    func toDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        print(self)
        
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    func toGregorianDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        print(self)
        
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    func toHijriDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        print(self)
        
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    
    
    
    func toTime() -> Date {
        //Create Date Formatter
        let timeFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        timeFormatter.dateFormat = "hh:mm:ss"
        
        //Parse into NSDate
        let timeFromString : Date = timeFormatter.date(from: self)!
        
        //Return Parsed Date
        return timeFromString
    }
    
}
extension String {
    
//    var isValidEmail: Bool {
//        // print("validate calendar: \(testStr)")
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
//    }
    
    var isPhoneNumber: Bool {
        if self.count != 8 {
            return false
        }
        if self.first == "5" && self[1] == "0"  {
            return true
        }
        return false
        
    }
    
    public var initials: String {
        
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        
        if let lastCharacter = words.last?.first {
            finalString.append(String(lastCharacter))
        }
        
        return finalString.uppercased()
    }

    
    var intValue : Int {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        
        return Int(result)!
    }
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with variables: CVarArg...) -> String {
        return String(format: self.localized, arguments: variables)
    }
    
    var englishPhoneNumber : String {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        
        return result
    }
    
    
    func isEmptyOrWhiteSpace()->Bool{
        let str = self
        return str.replacingOccurrences(of: " ", with: "").count == 0
    }
    
    var isValidateValue: Bool {
        if (self.count < 1 ) || (self == "") || (self.replacingOccurrences(of: " ", with: "").count == 0) || self.isEmptyOrWhiteSpace() == true {
            return false
        }
        return true
    }
    
    func isValidEmail() -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var removeWhiteSpaceAndArabicNumbers : String{
        return self.replacingOccurrences(of: " ", with: "").removeArabicNumbers
    }
    var removeArabicNumbers : String{
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
}
