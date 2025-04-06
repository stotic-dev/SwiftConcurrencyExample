//
//  RootViewController.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

import UIKit

final class RootViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
    }
}

private extension RootViewController {
    
    func setupView() {
        
        view.backgroundColor = .white
        
        let containerView = UIStackView()
        containerView.axis = .vertical
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        containerView.addArrangedSubview(makeNavigationToCombineViewButton())
        containerView.addArrangedSubview(.makeSpacer(16))
        containerView.addArrangedSubview(makeNavigationToConcurrencyViewButton())
    }
    
    func makeNavigationToCombineViewButton() -> UIButton {
        
        let button = makeButton("Navigation to CombineView")
        button.backgroundColor = .red
        button.addTarget(self,
                         action: #selector(tappedNavigationToCombineViewButton),
                         for: .touchUpInside)
        return button
    }
    
    func makeNavigationToConcurrencyViewButton() -> UIButton {
        
        let button = makeButton("Navigation to ConcurrencyView")
        button.backgroundColor = .cyan
        button.addTarget(self,
                         action: #selector(tappedNavigationToConcurrencyViewButton),
                         for: .touchUpInside)
        return button
    }
    
    func makeButton(_ title: String) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        return button
    }
}

private extension RootViewController {
    
    @objc func tappedNavigationToCombineViewButton() {
        
        let nextVC = CombineViewController.make()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func tappedNavigationToConcurrencyViewButton() {
        
        let nextVC = ConcurrencyViewController.make()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

