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
        
        if let savedValue = NSUserDefaults.standardUserDefaults().stringForKey("answerKey") {
            print(savedValue)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        scheduleLocal()
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
        
        let givenAnswer = _lblAnswer.text!.toInt()
        
        var message = ""
        
        if givenAnswer == expectedAnswer {
            message = "Correct"
            getNewQuestion()
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
        
        _lblAnswer.text = " "
    }
    
    // MARK: Functions
    func getNewQuestion(){
        
        questionValue = Int.random(1, 3)
        
        switch questionValue {
        case 1: // Addition
            
            _lblEquation.text = "+"
            
            firstNumber = Int.random(0, 99)
            secondNumber = Int.random(0, 99)
            
            _lblFirstNumber.text = firstNumber.description
            _lblSecondNumber.text = secondNumber.description
            expectedAnswer = firstNumber + secondNumber
            break
        case 2: // Subtraction
            _lblEquation.text = "-"
            
            firstNumber = Int.random(0, 99)
            secondNumber = Int.random(0, 99)
            
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
            
            firstNumber = Int.random(0, 99)
            secondNumber = Int.random(0, 9)
            
            _lblFirstNumber.text = firstNumber.description
            _lblSecondNumber.text = secondNumber.description
            expectedAnswer = firstNumber * secondNumber
            break
        default:
            _lblEquation.text = ""
            break
        }
    }
    
    func scheduleLocal() {
        
        print(Randoms.randomDateWithinDaysBeforeToday(1))
        
        let now: NSDateComponents = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: NSDate())
        
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date = cal.dateBySettingHour(now.hour, minute: now.minute + 1, second: 0, ofDate: NSDate(), options: NSCalendarOptions())
        
        let sound = "sound.aif"
        let category = "CATEGORY_ID"
        
        print("Firing at \(now.hour):\(now.minute+1)")
        
        NSUserDefaults.standardUserDefaults().setObject(expectedAnswer, forKey: "expectedAnswerKey")
        
        let strMessage = _lblFirstNumber.text! + _lblEquation.text! + _lblSecondNumber.text!
        
        scheduleLocalNotification(strMessage, date: date!, sound: sound, category: category)
    }

}

