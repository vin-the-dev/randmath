//
//  ViewController.swift
//  randmath
//
//  Created by Vineeth Vijayan on 16/04/16.
//  Copyright © 2016 Vineeth Vijayan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _commonRoundView: RoundUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        
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


}

