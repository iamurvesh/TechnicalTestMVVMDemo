//
//  LogInVC.swift
//  Technical Test
//
//  Created by Urvesh on 12/05/22.
//

import UIKit

class LogInVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    
    var viewModel = LogInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initConfig()
    }

    

}

//MARK: - Init Config Method
extension LogInVC {
    
    private func initConfig() {
        self.viewModel.viewController = self
        [self.txtEmail,self.txtPassword].forEach { textField in
            textField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(textField.text ?? "")
        self.viewModel.isvalidInput()
    }
}

//MARK: - UIButton Action
extension LogInVC {
    
    @IBAction func btnSubmit(_ sender: Any) {
        if let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: "myTabbarControllerID") {
            kAppDelegate.window?.rootViewController = initialViewController
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
    
}
