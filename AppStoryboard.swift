//
//  AppStoryboard.swift
//  Purchase App
//
//  Created by Mudith Chathuranga on 6/18/18.
//  Copyright © 2018 Chathuranga. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main = "Main"
    case Login = "Signin"
    case Home = "Home"
    case Leads = "Leads"
    case Customers = "Customers"
    case Quotations = "Quotations"
    case Campaign = "Campaign"
    case Activities = "Activities"
    case Settings = "Settings"
    
    
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
    ///// Usage /////
    // let loginVC = LoginVC.instantiate(fromAppStoryboard: .Main)
}

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
