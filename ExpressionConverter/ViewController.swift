//
//  ViewController.swift
//  ZPP
//
//  Created by Michal Niemiec on 15/12/2016.
//  Copyright © 2016 Niemiec. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var postfixLabel: UILabel!
    @IBOutlet weak var infixLabel: UILabel!
    @IBOutlet weak var prefixLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var valueToConvertTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = "Put your expression using letters and one of operator from list below :\n +, -, /, *, (, )"
    }
    @IBAction func makeMagicPressed(_ sender: Any) {
        
        let decimalCharacters = NSCharacterSet.decimalDigits
        let decimalRange = valueToConvertTextField.text?.rangeOfCharacter(from: decimalCharacters, options: String.CompareOptions.literal, range: nil)
        if decimalRange == nil {
            
            var valueWithSpace = ""
            if let text = valueToConvertTextField.text?.removingWhitespaces() {
                var valueToConvert = text
                var arrayOfValuesToConvert = [String]()
                
                for character in valueToConvert.characters {
                    arrayOfValuesToConvert.append(String(character))
                }
                valueWithSpace = arrayOfValuesToConvert.joined(separator: " ")
            }
            
            let isPrefix = valueWithSpace.isPrefix()
            let isPostfix = valueWithSpace.isPostfix()
            let isInfix = valueWithSpace.isInfix()
            
            
            if isPostfix != nil && isPrefix != nil && isInfix != nil{
                if isPrefix == false && isPostfix == false && isInfix == true {
                    convertInfixTo(valueWithSpace)
                }
                    
                else if isPrefix == true && isPostfix == false{
                    convertPrefixTo(valueWithSpace)
                }
                    
                else if isPrefix == false && isPostfix == true{
                    convertPostfixTo(valueWithSpace)
                }
                else {
                    showAlert()
                }
            } else {
                showAlert()
            }
        } else {
            showAlert()
            
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController.init(title: "ERROR", message: "Exspression is invalid", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Ok", style: .destructive, handler: { (action) in
        })
        alert.addAction(alertAction)
        self.show(alert, sender: nil)
    }
    
    func convertInfixTo(_ valueWithSpace: String) {
        
        // prefix
        var prefix = valueWithSpace
        prefix.convertInfixToPrefix()
        prefix = prefix.replacingOccurrences(of: " ", with: "")
        prefixLabel.text = prefix
        
        // postfix
        var postfix = valueWithSpace
        postfix.convertInfixToPostfix()
        postfix = postfix.replacingOccurrences(of: " ", with: "")
        postfixLabel.text = postfix
        
        // infix
        let valueWithSpac = valueWithSpace.replacingOccurrences(of: " ", with: "")
        infixLabel.text = valueWithSpac
    }
    
    func convertPostfixTo(_ valueWithSpace: String) {
        
        // prefix
        var prefix = valueWithSpace
        prefix.convertPostfixToPrefix()
        prefix = prefix.replacingOccurrences(of: " ", with: "")
        prefixLabel.text = prefix
        
        // postfix
        let valueWithoutSpace = valueWithSpace.replacingOccurrences(of: " ", with: "")
        postfixLabel.text = valueWithoutSpace
        
        // infix
        var infix = valueWithSpace
        infix.convertPostfixToInfix()
        infix = infix.replacingOccurrences(of: " ", with: "")
        infixLabel.text = infix
    }
    
    func convertPrefixTo(_ valueWithSpace: String) {
        
        // prefix
        let valueWithoutSpace = valueWithSpace.replacingOccurrences(of: " ", with: "")
        prefixLabel.text = valueWithoutSpace
        
        // postfix
        var postfix = valueWithSpace
        postfix.convertPrefixToPostfix()
        postfix = postfix.replacingOccurrences(of: " ", with: "")
        postfixLabel.text = postfix
        
        // infix
        var infix = valueWithSpace
        infix.convertPrefixToInfix()
        infix = infix.replacingOccurrences(of: " ", with: "")
        infixLabel.text = infix
    }
}


