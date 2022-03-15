//
//  CustomTextField.swift
//  alefTestTusk
//
//  Created by Никита Чирухин on 11.03.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeHolder: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        setupView(textFieldPlaceHolder: placeHolder, keyboard: keyboardType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - private methods
extension CustomTextField: UITextFieldDelegate {
    private func setupView(textFieldPlaceHolder: String, keyboard: UIKeyboardType) {

        translatesAutoresizingMaskIntoConstraints = false
        placeholder = textFieldPlaceHolder
        textAlignment = .center
        delegate = self
        keyboardType = keyboard
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
}
