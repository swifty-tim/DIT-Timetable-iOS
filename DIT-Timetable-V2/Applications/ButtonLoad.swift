//
//  ButtonLoad.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

protocol ButtonLoad { }

extension ButtonLoad where Self: UIButton {
    
    func setupButton( className: UIViewController, name: String = "" ) {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    func setupButton( className: UIView, name:String = "" ) {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    private func setup( className: String, tagValue : String ) {
        
        var viewName = ""
        if tagValue.isEmpty {
            viewName = String(self.tag)
        }
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName)
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, _) in dict {
            
            switch key {
            case "title":
                self.setTitle( dict.tryConvertStr(forKey: key) , for: .normal)
                break
            case "backgroundColor":
                self.backgroundColor = RCFileManager.readJSONColor(keyVal:  dict.tryConvertStr(forKey: key) )
                break
            case "fontName":
                fontName = dict.tryConvertStr(forKey: key)
                break
            case "fontSize":
                size = dict.tryConvertCGFloat(forKey: key)
                break
            case "titleColor":
                self.setTitleColor(RCFileManager.readJSONColor(keyVal: dict.tryConvertStr(forKey: key)), for: .normal)
                break
            case "cornerRadius":
                self.layer.cornerRadius = 10
                break
            case "clipsToBounds":
                self.clipsToBounds = dict.tryConvertBool(forKey: key)
            case "isEnabled":
                self.isEnabled = dict.tryConvertBool(forKey: key)
                break
            case "isHidden":
                self.isHidden = dict.tryConvertBool(forKey: key)
                break
            case "isUserInteractionEnabled":
                self.isUserInteractionEnabled = dict.tryConvertBool(forKey: key)
                break
            default: break
            }
        }
        
        if fontName != "" && size != 0.0 {
            self.titleLabel!.font = UIFont(name: fontName, size: size)
        }
    }
    
}
