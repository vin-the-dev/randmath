//
//  CommonExtension.swift
//  randmath
//
//  Created by Vineeth Vijayan on 16/04/16.
//  Copyright © 2016 Vineeth Vijayan. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class RoundUIView : UIView {
    
  
//    override func awakeFromNib() {
//        print(self.layer.frame.size)
//        self.layer.cornerRadius = self.layer.frame.height / 2
//        self.clipsToBounds = true
//    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        print(self.layer.frame.size)
//        self.layer.cornerRadius = self.layer.frame.height / 2
//        self.clipsToBounds = true
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
        //fatalError("init(coder:) has not been implemented")
    }
}

class CommonLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if DeviceType.IS_IPHONE_4_OR_LESS {
            self.font = self.font.fontWithSize(20)
        }
        if DeviceType.IS_IPHONE_5 {
            self.font = self.font.fontWithSize(25)
        }
        if DeviceType.IS_IPHONE_6 {
            self.font = self.font.fontWithSize(30)
        }
        if DeviceType.IS_IPHONE_6P {
            self.font = self.font.fontWithSize(35)
        }
    }
}

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

