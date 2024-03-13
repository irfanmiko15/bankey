//
//  LocalState.swift
//  bankey
//
//  Created by Irfan Dary Sujatmiko on 08/03/24.
//

import Foundation

public class LocalState{
    private enum Keys: String{
        case hasOnboard
    }
    
    public static var hasOnboarded : Bool{
        get{
            return UserDefaults.standard.bool(forKey: Keys.hasOnboard.rawValue)
        }set(newValue){
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboard.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
