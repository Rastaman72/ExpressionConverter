//
//  StringInfixToExtension.swift
//  ZPP
//
//  Created by Michal Niemiec on 21/12/2016.
//  Copyright © 2016 Niemiec. All rights reserved.
//

import Foundation
extension String {
    mutating func convertInfixToPrefix() {
        var stringToConvert = self.components(separatedBy: " ")
        stringToConvert = stringToConvert.reversed()
        var resultArray = [String]()
        for element in stringToConvert {
            if element == "(" {
                resultArray.append(")")
            } else if element == ")" {
                resultArray.append("(")
            } else {
                resultArray.append(element)
            }
        }
        self = resultArray.joined(separator: " ")
        self.convertInfixToPostfix()
        self = self.components(separatedBy: " ").reversed().joined(separator: " ")
    }
    
    mutating func convertInfixToPostfix() {
        var resultString = ""
        var operatorsToUse = [String]()
        let stringToConvert = self.components(separatedBy: " ")
        
        for element in stringToConvert {
            
            
            if mathOperator.keys.contains(element) == false {
                resultString.append(element)
                resultString.append(" ")
                
            }
                
            else if element == "(" {
                operatorsToUse.append(element)
            }
                
            else if element == ")" {
                var top = operatorsToUse.last!
                operatorsToUse.removeLast()
                while top != "(" {
                    resultString.append(top)
                    resultString.append(" ")
                    top = operatorsToUse.last!
                    operatorsToUse.removeLast()
                }
            }
                
            else {
                while operatorsToUse.count > 0 &&
                    mathOperator[operatorsToUse.last!]! >= mathOperator[element]! {
                        resultString.append(operatorsToUse.last!)
                        resultString.append(" ")
                        
                        operatorsToUse.removeLast()
                }
                operatorsToUse.append(element)
            }
        }
        
        while operatorsToUse.count > 0 {
            resultString.append(operatorsToUse.last!)
            resultString.append(" ")
            
            operatorsToUse.removeLast()
        }
        
        resultString.remove(at: resultString.index(before: resultString.endIndex))
        self = resultString
    }
}
