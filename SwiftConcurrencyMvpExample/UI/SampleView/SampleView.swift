//
//  SampleView.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

import UIKit

final class SampleView: UIView {
    
    // MARK: - factory method

    static func make(delegate: UITextFieldDelegate,
                     didChangeTextFiledSelector: Selector,
                     tappedButtonSelector: Selector) -> SampleView {
        
        let view = SampleView()
        view.setupView(delegate: delegate,
                       didChangeTextFiledSelector: didChangeTextFiledSelector,
                       tappedButtonSelector: tappedButtonSelector)
        return view
    }
    
    // MARK: ui component
    
    private var registerButton: UIButton!
    private var alertMessage: UIView!
    private var textFiled: UITextField!
    
    // MARK: - public method
    
    func updateRegisterButtonState(isEnable: Bool) {
        
        registerButton.isEnabled = isEnable
    }
    
    func hiddenAlertMessage(isHidden: Bool) {
        
        alertMessage.isHidden = isHidden
    }
    
    func clearTextFiled() {
        
        textFiled.text = ""
        textFiled.resignFirstResponder()
    }
}

// MARK: make ui method

private extension SampleView {
    
    func setupView(delegate: UITextFieldDelegate,
                   didChangeTextFiledSelector: Selector,
                   tappedButtonSelector: Selector) {
        
        let containerView = makeContainer()
        addContainerView(containerView)
        
        let searchBar = makeSearchBar(delegate: delegate,
                                      didChangeTextFiledSelector: didChangeTextFiledSelector,
                                      tappedButtonSelector: tappedButtonSelector)
        containerView.addArrangedSubview(searchBar)
        containerView.addArrangedSubview(.makeSpacer(8))
        
        alertMessage = makeAlertMessageLabel()
        containerView.addArrangedSubview(alertMessage)
    }
    
    func makeContainer() -> UIStackView {
        
        let containerView = UIStackView()
        containerView.axis = .vertical
        return containerView
    }
    
    func addContainerView(_ containerView: UIStackView) {
        
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    func makeSearchBar(delegate: UITextFieldDelegate,
                       didChangeTextFiledSelector: Selector,
                       tappedButtonSelector: Selector) -> UIView {
        
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 16
        container.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.textFiled = UITextField()
        self.textFiled.delegate = delegate
        self.textFiled.borderStyle = .roundedRect
        self.textFiled.layer.borderColor = UIColor.black.cgColor
        self.textFiled.layer.borderWidth = 0.5
        self.textFiled.addTarget(delegate, action: didChangeTextFiledSelector, for: .editingChanged)
        
        container.addArrangedSubview(self.textFiled)
        
        registerButton = UIButton()
        registerButton.setTitle("登録", for: .normal)
        registerButton.backgroundColor = .black
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitleColor(.gray, for: .disabled)
        registerButton.addTarget(delegate, action: tappedButtonSelector, for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        container.addArrangedSubview(registerButton)
        
        return container
    }
    
    func makeAlertMessageLabel() -> UIView {
        
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "登録できない文字です！"
        return label
    }
}
