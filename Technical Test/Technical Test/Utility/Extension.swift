//
//  Extension.swift
//  Technical Test
//
//  Created by Urvesh on 12/05/22.
//

import Foundation
import UIKit

extension UITextField {
    
    /**
     This method is used to validate email field.
     - Returns: Return boolen value to indicate email is valid or not
     */
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{1,}(\\.[A-Za-z]{1,}){0,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
    /**
     This method is used to validate password field.
     - Returns: Return boolen value to indicate password is valid or not
     */
    func isValidPassword() -> Bool {
        let text = self.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard text.count >= 8, text.count <= 15  else {
            return false
        }
        return true
    }
}

// MARK: - UIViewController's Extension
extension UIViewController {
    
    func showAlert(withTitle title: String = "", with message: String, firstButton: String = "Ok", firstHandler: ((UIAlertAction) -> Void)? = nil, secondButton: String? = nil, secondHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstButton, style: .default, handler: firstHandler))
        if secondButton != nil {
            alert.addAction(UIAlertAction(title: secondButton!, style: .default, handler: secondHandler))
        }
        present(alert, animated: true)
    }
}

// MARK: - UserDefaults's Extension
extension UserDefaults {
    class var favouritePostsId: [Int] {
        get {
            if let arr = UserDefaults.standard.value(forKey: "favouritePostsId") as? [Int]  {
                return arr
            }
            return [Int]()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "favouritePostsId")
        }
    }
    
    class var serverPots: [ModelPost] {
        get {
            if let arr = UserDefaults.standard.value(forKey: "serverPots") as? [[String:Any]]  {
                return arr.compactMap(ModelPost.init)
            }
            return [ModelPost]()
        }
        set {
            var arr = [[String:Any]]()
            newValue.forEach({
                arr.append($0.toDictionary())
            })
            UserDefaults.standard.set(arr, forKey: "serverPots")
        }
    }

}

// MARK: - UITableView's Extension
extension UITableView {
    func EmptyMessage(message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.frame.width, height: self.frame.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func registerCell(withNib reuseIdentifier:String) {
        self.register(UINib(nibName: reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }
}
