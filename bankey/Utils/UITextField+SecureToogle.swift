//
//  UITextField+SecureToogle.swift
//  bankey
//
//  Created by Irfan Dary on 20/03/24.
//

import Foundation
import UIKit

let passwordToogleButton = UIButton(type: .custom)

extension UITextField{
    func enablePasswordToogle(){
        passwordToogleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToogleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToogleButton.addTarget(self, action: #selector(tooglePasswordView), for: .touchUpInside)
        rightView = passwordToogleButton
        rightViewMode = .always
    }
    
    @objc func tooglePasswordView(_ sender:Any){
        isSecureTextEntry.toggle()
        passwordToogleButton.isSelected.toggle()
    }
}
