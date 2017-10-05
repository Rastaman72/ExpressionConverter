//
//  StringPostfixToExtension.swift
//  ZPP
//
//  Created by Michal Niemiec on 21/12/2016.
//  Copyright © 2016 Niemiec. All rights reserved.
//

import Foundation
extension String {
    mutating func convertPostfixToInfix() {
        var elementToUse = [String]()
        var stringToConvert = self.components(separatedBy: " ")
        
        for element in stringToConvert {
            
            if mathOperator.keys.contains(element) == false {
                elementToUse.append(element)
            } else {
                
                if elementToUse.count < 2 {
                    self = "ERROR"
                    return
                }
                else if elementToUse.count >= 2{
                    var element1 = elementToUse[elementToUse.count - 2]
                    var element2 = elementToUse[elementToUse.count - 1]
                    
                    elementToUse.remove(at: elementToUse.count - 2)
                    elementToUse.remove(at: elementToUse.count - 1)
                    
                    
                    var newElement = ""
                    if mathOperator[element]! > 2 {
                        if element1.characters.count != 1 {
                            element1 = "( " + element1 + " )"
                        }
                        
                        if element2.characters.count != 1 {
                            element2 = "( " + element2 + " )"
                        }
                        
                        newElement = String(format: "%@ %@ %@", element1,element,element2)
                    } else {
                        newElement = String(format: "%@ %@ %@", element1,element,element2)
                        
                    }
                    
                    elementToUse.append(newElement)
                    
                }
            }
            
            if elementToUse.count == 1 && stringToConvert.count == 1{
                self = elementToUse.first!
            }
            
            stringToConvert.removeFirst()
        }
    }
    
    
    mutating func convertPostfixToPrefix() {
        self.convertPostfixToInfix()
        if self != "ERROR" {
            self.convertInfixToPrefix()
        }
    }
}
