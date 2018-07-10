//
// Created by Marius Ilie on 19/03/2018.
// Copyright (c) 2018 mReady. All rights reserved.
//

import UIKit

//TODO: remove

struct StoryboardReference {
    enum Onboarding: String, StoryboardReferenceRepresentable {
        static var storyboardName: String {
            return "Onboarding"
        }
        
        case loginController = "LoginController"
        case registerController = "RegisterController"
        
        case firstLoginNavigationController = "FirstLoginNavigationController"
        case personalDataController = "PersonalDataController"
        case insertPhoneController = "InsertPhoneController"
    }
    
    enum Main: String, StoryboardReferenceRepresentable {
        static var storyboardName: String {
            return "Main"
        }
        
        case mainTabBarController = "MainTabBarController"
    }
}
