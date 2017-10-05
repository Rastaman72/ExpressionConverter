//
//  StringExtensionType.swift
//  ZPP
//
//  Created by Michal Niemiec on 04/01/2017.
//  Copyright © 2017 Niemiec. All rights reserved.
//

import Foundation

extension String {
    func checkIfIsValidPrefix() -> Int {
        var stackCounter = 0
        var selfArray = self.components(separatedBy: " ")
        let operators = selfArray.filter { (element) -> Bool in
            return mathOperator.keys.contains(element)
        }
        while selfArray.count > 2 {
            if stackCounter != operators.count && selfArray.count < 3 {
                return 0
            }
            for element in selfArray {
                
                let testIndex = selfArray.index(of: element)
                if testIndex!+2 < selfArray.count {
                    if !mathOperator.keys.contains(selfArray[testIndex! + 1]) {
                        if !mathOperator.keys.contains(selfArray[testIndex! + 2]) {
                            let rangeToRemove = testIndex!...testIndex!+1
                            selfArray.removeSubrange(rangeToRemove)
                            stackCounter += 1
                            break
                        }
                    }
                }
                if element == selfArray.last
                {
                    return 0
                }
            }
        }
        if selfArray.count == 1 {
            return 1
        }
        return 0
    }
    
    func isPrefix() -> Bool? {
        
        var tempValue = self
        tempValue = tempValue.replacingOccurrences(of: "(", with: "")
        tempValue = tempValue.replacingOccurrences(of: ")", with: "")
        
        var selfArray = tempValue.components(separatedBy: " ")
        selfArray = selfArray.filter() {$0 != ""}
        
        if mathOperator.keys.contains(selfArray.first!) {
            
            let result = checkIfIsValidPrefix()
            if result == 1 {
                
                while selfArray.count > 2 {
                    let firstOperand = selfArray.first { (elementToTest) -> Bool in
                        return mathOperator.keys.contains(elementToTest)
                    }
                    let testIndex = selfArray.index(of: firstOperand!)
                    if testIndex!+2 < selfArray.count {
                        
                        if !mathOperator.keys.contains(selfArray[testIndex! + 1]) {
                            if !mathOperator.keys.contains(selfArray[testIndex! + 2]) {
                                
                                return true
                            }
                            else {
                                selfArray = Array(selfArray[testIndex! + 1...selfArray.count - 1])
                            }
                        } else {
                            selfArray = Array(selfArray[testIndex! + 1...selfArray.count - 1])
                        }
                    } else {
                        return false
                    }
                }
                return false
            } else {
                return nil
            }
        } else {
            return false
        }
    }
    
    func isInfix() -> Bool? {
        var tempValue = self
        tempValue = tempValue.replacingOccurrences(of: "(", with: "")
        tempValue = tempValue.replacingOccurrences(of: ")", with: "")
        
        var selfArray = tempValue.components(separatedBy: " ")
        selfArray = selfArray.filter() {$0 != ""}
        
        let second = selfArray[1]
        let last = selfArray.last!
        
        if mathOperator.keys.contains(second) && !mathOperator.keys.contains(last) {
            return true
        }
        
        return false
    }
    
    func checkIfIsValidPostfix() -> Int {
        
        var tempValue = self
        tempValue = tempValue.replacingOccurrences(of: "(", with: "")
        tempValue = tempValue.replacingOccurrences(of: ")", with: "")
        
        var selfArray = tempValue.components(separatedBy: " ")
        
        selfArray = selfArray.filter() {$0 != ""}
        var stackCounter = 0
        for element in selfArray {
            if !mathOperator.keys.contains(element) {
                stackCounter += 1
            } else {
                stackCounter -= 1
            }
        }
        return stackCounter
    }
    
    mutating func isPostfix() -> Bool? {
        let result = checkIfIsValidPostfix()
        if result == 1 {
            
            var tempValue = self
            tempValue = tempValue.replacingOccurrences(of: "(", with: "")
            tempValue = tempValue.replacingOccurrences(of: ")", with: "")
            
            var selfArray = tempValue.components(separatedBy: " ")
            selfArray = selfArray.filter() {$0 != ""}
            
            var testIndex = 0
            
            while selfArray.count != 2 {
                
                if testIndex+2 < selfArray.count {
                    if !mathOperator.keys.contains(selfArray[testIndex + 1]) && mathOperator.keys.contains(selfArray[testIndex + 2])
                    {
                        
                        if selfArray.count <= 3 {
                            return true
                        }
                        else {
                            selfArray.remove(at: testIndex + 2)
                            selfArray.remove(at: testIndex + 1)
                            testIndex = 0
                        }
                        
                    } else {
                        testIndex += 1
                    }
                } else {
                    return false
                }
            }
            return false
        } else {
            return nil
        }
    }
}
