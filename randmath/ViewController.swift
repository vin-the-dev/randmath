//
//  ViewController.swift
//  randmath
//
//  Created by Vineeth Vijayan on 16/04/16.
//  Copyright © 2016 Vineeth Vijayan. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SwiftRandom

class ViewController: UIViewController {
    
    // MARK: IB Outlets
    
    @IBOutlet weak var _lblFirstNumber: CommonLabel!
    @IBOutlet weak var _lblSecondNumber: CommonLabel!
    @IBOutlet weak var _lblEquation: CommonLabel!
    @IBOutlet weak var _lblAnswer: CommonLabel!
    
    // MARK: Global Variables
    var questionValue = 0
    var firstNumber = 0
    var secondNumber = 0
    var expectedAnswer = 0
    
    // MARK: View Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _lblAnswer.text = " "
        getNewQuestion()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        for tempView in self.view.subviews{
            if tempView.className == "RoundUIView" {
                tempView.layer.cornerRadius = tempView.layer.frame.height / 2
                tempView.clipsToBounds = true
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IB Actions
    @IBAction func numberButtonTapped(sender: UIButton) {
        _lblAnswer.setText(_lblAnswer.text! + sender.tag.description, animated: true, duration: 0.25)
    }
    
    @IBAction func enterButtonTapped(sender: AnyObject) {
        print(_lblAnswer.text)
        let givenAnswer = _lblAnswer.text!.trim()
        
        var message = ""
        
        if givenAnswer == expectedAnswer {
            message = "Correct"
        }
        else{
            message = "Wrong"
        }
        
        
        let alertController = UIAlertController(title: "RandMath", message: message, preferredStyle: .Alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK",
                                     style: .Default,
                                     handler: nil) //You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: Functions
    func getNewQuestion(){
        
        questionValue = Int.random(1, 3)
        firstNumber = Int.random(0, 99)
        secondNumber = Int.random(0, 99)
        
        switch questionValue {
        case 1: // Addition
            _lblEquation.text = "+"
            _lblFirstNumber.text = firstNumber.description
            _lblSecondNumber.text = secondNumber.description
            expectedAnswer = firstNumber + secondNumber
            break
        case 2: // Subtraction
            _lblEquation.text = "-"
            if firstNumber > secondNumber {
                _lblFirstNumber.text = firstNumber.description
                _lblSecondNumber.text = secondNumber.description
                expectedAnswer = firstNumber - secondNumber
            }
            else{
                _lblFirstNumber.text = secondNumber.description
                _lblSecondNumber.text = firstNumber.description
                expectedAnswer = secondNumber - firstNumber
            }
            break
        case 3: // Multiplication
            _lblEquation.text = "x"
            _lblFirstNumber.text = firstNumber.description
            _lblSecondNumber.text = secondNumber.description
            expectedAnswer = firstNumber * secondNumber
            break
        default:
            _lblEquation.text = ""
            break
        }
    }

}

