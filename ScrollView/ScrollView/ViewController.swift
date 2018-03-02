//
//  ViewController.swift
//  ScrollView
//
//  Created by Buzoianu Stefan on 01/03/2018.
//  Copyright © 2018 Buzoianu Stefan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let showKeyboard: (Notification) -> Void = { notification in
            self.KeyboardWillShow(notification)
        }
        
        let hideKeyboard: (Notification) -> Void = { notification in
            self.KeyboardWillHide(notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow,
                                               object: nil,
                                               queue: nil,
                                               using: showKeyboard)
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide,
                                               object: nil,
                                               queue: nil,
                                               using: hideKeyboard)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didTap(gesture:UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func KeyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, // asta e un dictionar de forma [cheie:valoare],
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                print("no value!")
                return
        }
        let contentInset = UIEdgeInsets(top:0, left: 0, bottom: frame.height + 10, right:0)
        userScrollView.contentInset = contentInset
        userScrollView.scrollIndicatorInsets = contentInset
    }

    func KeyboardWillHide(_ notification: Notification) {
        userScrollView.contentInset = UIEdgeInsets.zero
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

