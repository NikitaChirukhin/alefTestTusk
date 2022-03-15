//
//  View.swift
//  alefTestTusk
//
//  Created by Никита Чирухин on 10.03.2022.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func childrenButtonTap()
}

class View: UIView {
    
    weak var delegate: ViewDelegate?
    
    private let textFieldHeight: CGFloat = 40
    
    private lazy var childrenCount = 0
    
    private lazy var surnameTextField = CustomTextField(placeHolder: "Фамилия", keyboardType: .default)
    private lazy var firstnameTextField = CustomTextField(placeHolder: "Имя", keyboardType: .default)
    private lazy var secondnameTextField = CustomTextField(placeHolder: "Отчество", keyboardType: .default)
    private lazy var ageTextField = CustomTextField(placeHolder: "Возраст", keyboardType: .phonePad)
    private lazy var childrenViews = [ChildrenView]()
    
    private lazy var childrenStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var heightConstraintChildrenStackView = childrenStackView.heightAnchor.constraint(equalToConstant: textFieldHeight)
    
    private lazy var childrenAddButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(childrenButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var topAnchorConstraintChildrenAddButton = childrenAddButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 40)
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemFill
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(clearButtonTap), for: .touchUpInside)
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Private Method
extension View {
    
    private func setupView(){
        backgroundColor = .systemBackground
        
        addSubview(surnameTextField)
        addSubview(firstnameTextField)
        addSubview(secondnameTextField)
        addSubview(ageTextField)
        
        for _ in 1...5 {
            childrenViews.append(createChildrenTextField())
            if let view = childrenViews.last {
                view.isHidden = true
                childrenStackView.addArrangedSubview(view)
            }
        }
        
        addSubview(childrenStackView)
        addSubview(childrenAddButton)
        addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            surnameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            surnameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            firstnameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10),
            firstnameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstnameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            firstnameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            secondnameTextField.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: 10),
            secondnameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            secondnameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            secondnameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            ageTextField.topAnchor.constraint(equalTo: secondnameTextField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ageTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            topAnchorConstraintChildrenAddButton,
            childrenAddButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            childrenAddButton.widthAnchor.constraint(equalToConstant: 30),
            childrenAddButton.heightAnchor.constraint(equalToConstant: 30),
            
            childrenStackView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 25),
            childrenStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            childrenStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            heightConstraintChildrenStackView,
            
            clearButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            clearButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            clearButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    

    
    private func createChildrenTextField() -> ChildrenView {
        let childrenView = ChildrenView()
        childrenView.delegate = self
        return childrenView
    }
    
    @objc private func childrenButtonTap() {
        
        for i in childrenCount...4 {
            childrenViews[i].isHidden = true
        }
        
        for i in 0...childrenCount {
            childrenViews[i].isHidden = false
        }
        
        if childrenCount == 4 {
            childrenAddButton.isHidden = true
        }
        
        childrenCount += 1

        topAnchorConstraintChildrenAddButton.constant = textFieldHeight * CGFloat(childrenCount) + 10 * CGFloat(childrenCount - 1) + 40
        heightConstraintChildrenStackView.constant = textFieldHeight * CGFloat(childrenCount) + 10 * CGFloat(childrenCount - 1)
        childrenStackView.layoutIfNeeded()
        childrenAddButton.layoutIfNeeded()
    }
    
    @objc private func clearButtonTap() {
        surnameTextField.text = ""
        firstnameTextField.text = ""
        secondnameTextField.text = ""
        ageTextField.text = ""
        if childrenCount != 0 {
            for i in 0...childrenCount - 1 {
                childrenViews[i].deleteButtonTap()
            }
        }
    }
}

//MARK: - ChildrenViewDelegate
extension View: ChildrenViewProtocol {
    func deleteButtonTap() {
        
        childrenCount -= 1
        
        if childrenCount < 5 {
            childrenAddButton.isHidden = false
        }
        
        topAnchorConstraintChildrenAddButton.constant = textFieldHeight * CGFloat(childrenCount) + 10 * CGFloat(childrenCount - 1) + 40
        heightConstraintChildrenStackView.constant = textFieldHeight * CGFloat(childrenCount) + 10 * CGFloat(childrenCount - 1)
        childrenStackView.layoutIfNeeded()
    }
}
