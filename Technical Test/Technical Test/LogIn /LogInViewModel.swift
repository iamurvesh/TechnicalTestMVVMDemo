//
//  LogInViewModel.swift
//  Technical Test
//
//  Created by Urvesh on 12/05/22.
//

import UIKit

class LogInViewModel {

    var viewController : LogInVC?


    func isvalidInput() {
        if let vc = self.viewController {
            if vc.txtEmail.isValidEmail() && vc.txtPassword.isValidPassword() {
                self.viewController?.btnSubmit.isEnabled = true
                return
            }
        }
        self.viewController?.btnSubmit.isEnabled = false
    }
    
}
