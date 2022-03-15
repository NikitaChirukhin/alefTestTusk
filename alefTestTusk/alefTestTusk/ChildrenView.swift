//
//  ChildrenAddView.swift
//  alefTestTusk
//
//  Created by Никита Чирухин on 11.03.2022.
//

import UIKit

protocol ChildrenViewProtocol: AnyObject {
    func deleteButtonTap()
}

class ChildrenView: UIView {
    
    private lazy var nameTextField = CustomTextField(placeHolder: "Имя ребенка", keyboardType: .default)
    private lazy var ageTextField = CustomTextField(placeHolder: "Возраст", keyboardType: .numberPad)
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ChildrenViewProtocol?
    
    init(){
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Private Methods ChildrenAddView
extension ChildrenView {
    
    private func setupView() {
        addSubview(nameTextField)
        addSubview(ageTextField)
        addSubview(deleteButton)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
            
            ageTextField.topAnchor.constraint(equalTo: topAnchor),
            ageTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -5),
            ageTextField.widthAnchor.constraint(equalToConstant: 70),
            
            nameTextField.topAnchor.constraint(equalTo: topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: ageTextField.leadingAnchor, constant: -5)
        ])
    }
    
    @objc func deleteButtonTap() {
        isHidden = true
        nameTextField.text = ""
        ageTextField.text = ""
        delegate?.deleteButtonTap()
    }
}
