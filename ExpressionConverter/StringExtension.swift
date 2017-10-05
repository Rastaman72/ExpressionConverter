//
//  ParseText.swift
//  ZPP
//
//  Created by Michal Niemiec on 15/12/2016.
//  Copyright © 2016 Niemiec. All rights reserved.
//

import Foundation

var mathOperator = ["^" : 4,
                    "*" : 3,
                    "/" : 3,
                    "-" : 2,
                    "+" : 2,
                    "(" : 1,
                    ")" : 1]

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    mutating func parentheses() {
        while (self.contains("(")) {
            var array = self.components(separatedBy: " ")
            let open = array.index { (element) -> Bool in
                element == "("
            }
            let close = array.index { (element) -> Bool in
                element == ")"
            }
            
            let insideArray = array[open! + 1...close! - 1]
            var inside = [String]()
            for element in insideArray {
                inside.append(element)
            }
            
            
            var result = ""
            for element in inside {
                if inside.count > 1 {
                    for symbol in ["*","/","-","+"] {
                        while inside.contains(symbol) {
                            result = element.makeMath(forSymbol: symbol, forString: inside.joined(separator: " "))
                            if result != inside.joined(separator: " "){
                                inside = result.components(separatedBy: " ")
                            }
                        }
                    }
                } else {
                    let subRange = open!...close!
                    array.replaceSubrange(subRange, with: [String(format:"%.0f",Float(result)!)])
                    self = array.joined(separator: " ")
                    break
                }
            }
            
        }
    }
    
    func replaceElements(withResult result: String, forArray array: inout [String], mathSymbol symbol: String) {
        let leftIndex = array.index(before: array.index(of: symbol)!)
        let rightIndex = array.index(after: array.index(of: symbol)!)
        let subRange = leftIndex...rightIndex
        array.replaceSubrange(subRange, with: [String(format:"%.0f",Float(result)!)])
        
    }
    
    mutating func addition()  {
        while (self.contains("+")) {
            let resultToUse = self.makeMath(forSymbol: "+", forString: self)
            self = resultToUse
        }
    }
    
    mutating func subtraction() {
        while (self.contains("-")) {
            let resultToUse = self.makeMath(forSymbol: "-", forString: self)
            self = resultToUse
        }
    }
    
    mutating func multiplication() {
        while (self.contains("*")) {
            let resultToUse = self.makeMath(forSymbol: "*", forString: self)
            self = resultToUse
        }
        
    }
    
    mutating func division() {
        while (self.contains("/")) {
            let resultToUse = self.makeMath(forSymbol: "/", forString: self)
            self = resultToUse
        }
    }
    
    mutating func makePrefixMath() {
        let mathSymbols = ["*","/","-","+"]
        
        while self.characters.count > 2 {
            for element in self.components(separatedBy: " "){
                print(element+" -----")
                if mathSymbols.contains(element) {
                    self = makeMath(forSymbol: element, forString: self)
                    break
                }
            }
        }
        
    }
    
    mutating func makePostfixMath() {
        let mathSymbols = ["*","/","-","+"]
        
        while self.characters.count > 2 {
            for element in self.components(separatedBy: " "){
                print(element+" -----")
                if mathSymbols.contains(element) {
                    self = makeMath(forSymbol: element, forString: self)
                    break
                }
            }
        }
    }
    
    func makeMath(forSymbol symbol: String, forString string: String) -> (String) {
        
        var array = string.components(separatedBy: " ")
        if let element = array.first(where: { (symbolToFind) -> Bool in
            symbolToFind == symbol
        }) {
            
            // Infix
            let leftIndex = array.index(before: array.index(of: element)!)
            let valueLeft = array[leftIndex]
            let rightIndex = array.index(after: array.index(of: element)!)
            let valueRight = array[rightIndex]
            
            
            //            Prefix
            //            let leftIndex = array.index(before: array.index(of: element)!)
            //            let valueLeft = array[leftIndex]
            //            let rightIndex = array.index(before: array.index(of: element)!)-1
            //            let valueRight = array[rightIndex]
            
            
            //            Postfix
            //  let leftIndex = array.index(before: array.index(of: element)!) - 1
            //let valueLeft = array[leftIndex]
            //let rightIndex = array.index(before: array.index(of: element)!)
            //let valueRight = array[rightIndex]
            
            
            var result = 0.0
            switch symbol {
            case "*":
                result = Double(String(valueLeft))! * Double(String(valueRight))!
            case "/":
                result = Double(String(valueLeft))! / Double(String(valueRight))!
            case "+":
                result = Double(String(valueLeft))! + Double(String(valueRight))!
            case "-":
                result = Double(String(valueLeft))! - Double(String(valueRight))!
                
            default:
                break
            }
            
            let subRange = rightIndex - 1...array.index(of: element)!
            array.replaceSubrange(subRange, with: [String(format:"%.0f",result)])
            return array.joined(separator: " ")
        }
        return string
    }
}

