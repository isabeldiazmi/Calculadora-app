//
//  ViewController.swift
//  Calculator
//
//  Created by Isabel Díaz Miranda on 18/12/15.
//  Copyright © 2015 Isabel Díaz Miranda. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController{
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var stack: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var decimalPointWasPressed = false
    var brain = CalculatorBrain()

    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            if digit == "." {
                if !decimalPointWasPressed{
                    display.text = display.text! + "."
                    decimalPointWasPressed = true //doesn't let the user press '.' again
                }
                else {
                   display.text = digit
                }
            }
            else {
                display.text = display.text! + digit
            }
            
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func pi(sender: UIButton) {
        let pi = M_PI
        display.text = "\(pi)"
    }
    
    @IBAction func clear(sender: UIButton) {
        display.text = "0"
    }
    
   
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }
        /*
        stack.text = stack.text! + operation
        if let operation = sender.currentTitle {
            switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+": performOperation {$0 + $1}
            case "−": performOperation {$1 - $0}
            case "√": performOperation2 {sqrt($0)}
            case "sin": performOperation2 {sin($0)}
            case "cos": performOperation2 {cos($0)}
            default: break
            }
        }
        */
    }
    
    /*
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    */
    
    //var operandStack = Array<Double>() //creates empty array
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false //when you press the button you need to refresh the display
        /*
        operandStack.append(displayValue)
        stack.text = stack.text! +
                        " \(displayValue)"
        print("operandStack = \(operandStack)") //it is printed in the console, no the display
        */
        decimalPointWasPressed = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }
        else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false //lets the user press '.' again
        }
    }
}

