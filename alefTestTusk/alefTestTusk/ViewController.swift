//
//  ViewController.swift
//  alefTestTusk
//
//  Created by Никита Чирухин on 10.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }


    override func loadView() {
        let view = View()
        self.view = view
    }
    
    
}

//MARK: - ViewController private methods
extension ViewController {
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

