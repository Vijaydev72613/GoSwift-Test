//
//  Extensions.swift
//  MiddleTon
//
//  Created by Vijay on 5/21/15.
//  Copyright (c) 2015 MT. All rights reserved.
//

import UIKit

// MARK: - NSDate -

extension NSDate {
	
	func stringWithDateFormat(dateFormat: String = "yyyy-MM-dd HH:mm:SS ZZZZ") -> String {
		let formatter = NSDateFormatter()
		formatter.dateFormat = dateFormat
		return formatter.stringFromDate(self)
	}
	
	func dateByRoundingOffMinute(minuteUnit : NSTimeInterval) -> NSDate {
		let dateComponents = NSCalendar.currentCalendar().components( [NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Day], fromDate: self)
		var minutes = dateComponents.minute
		let quotient = Int((minutes/Int(minuteUnit)) + 1)
		minutes = quotient * Int(minuteUnit)
		dateComponents.minute = minutes
		dateComponents.second = 0
		return NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
	}

}

// MARK: - String -

extension String {
	
	// MARK: - Convenience

	func localize(comment : String = "") -> String {
		return NSLocalizedString(self, comment: comment)
	}
	
	func localizedAlertOK() -> String {
		return localize("Alert OK")
	}
    
    func currencyFormatted(showSymbol : Bool = true) -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = showSymbol ? .CurrencyStyle : .DecimalStyle
        numberFormatter.locale = NSLocale(localeIdentifier: "en_IN")
        numberFormatter.maximumFractionDigits = 0
        let finalString = String(format: "%.0f", Float(self)!)
        let formattedString = numberFormatter.stringFromNumber(Float(finalString)!)!
        return formattedString
    }
    
    func currencyToNumber() -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.maximumFractionDigits = 0
        let formattedString = numberFormatter.numberFromString(self)!
        return "\(formattedString)"
    }
	
	func dateFromStringWithFormat(dateFormat : String = "yyyy-MM-dd HH:mm:SS ZZZZ") -> NSDate? {
		let formatter = NSDateFormatter()
		formatter.dateFormat = dateFormat
		return formatter.dateFromString(self)
	}
    
    func getCGFloat() -> CGFloat {
        
        if let n = NSNumberFormatter().numberFromString(self) {
            return CGFloat(n)
        }
        
        return 0
    }
    
    func masked() -> String {
        if characters.count > 5 {
            let range = startIndex.advancedBy(2)..<endIndex.predecessor().predecessor()
            var replacementString = "X"
            for _ in 1...range.count {
                replacementString += "X"
            }
            let finalString = stringByReplacingCharactersInRange(range, withString: replacementString)
            return finalString
        }
        return self
    }
    
    func emailValidation() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluateWithObject(self)
        return isValid
    }
	
}

// MARK: - NSDictionary -

extension NSDictionary {
    
    func getString(key : String) -> String? {
        
        if let v = self[key] as? String {
            return v
        }
        
        if let v = self[key] as? Int {
            return String(v)
        }
        
        if let v = self[key] as? Float {
            return String(v)
        }
        
        return nil
        
    }
    
    func getInt(key : String) -> Int {
        
        if let v = self[key] as? String {
            if v.characters.count > 0 {
                return Int(v)!
            }
            else {
                return 0
            }
        }
        
        return 0
    }
    
    func getFloat(key : String) -> Float {
        
        if let v = self[key] as? String {
            if v.characters.count > 0 {
                return Float(v)!
            }
            else {
                return 0
            }
        }
        
        return 0
    }
    
    func getBool(key : String) -> Bool {
        
        if let v = self[key] as? String {
            return (v == "1")
        }
        else if let v = self[key] as? Int {
            return (v == 1)
        }
        
        return false
    }
    func getDate(key : String, format : String = "MM/dd/yyyy hh:mm:ss a") -> NSDate? {
        
        if let v = self[key] as? String {
            return v.dateFromStringWithFormat(format)
        }
        
        return nil
    }
    
}












