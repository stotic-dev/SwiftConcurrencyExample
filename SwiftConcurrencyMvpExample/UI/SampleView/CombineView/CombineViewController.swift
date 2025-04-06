//
//  CombineViewController.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

import Combine
import UIKit

final class CombineViewController: UIViewController {
    
    // MARK: - factory method
    
    static func make() -> UIViewController {
        
        let vc = CombineViewController()
        
        let presenter = CombineViewPresenter(userDefaults: .standard)
        vc.presenter = presenter
        
        let sampleView = SampleView.make(delegate: vc,
                                         didChangeTextFiledSelector: #selector(didChangeTextFiled),
                                         tappedButtonSelector: #selector(tappedRegisterButton))
        vc.sampleView = sampleView
        vc.view.addSubview(sampleView)
        sampleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sampleView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            sampleView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            sampleView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            sampleView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor)
        ])
        
        return vc
    }
    
    // MARK: - property
    
    private var sampleView: SampleView!
    private var presenter: CombineViewPresenter!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - lifecycle method
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        publishedState()
    }
}

extension CombineViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension CombineViewController {
    
    func publishedState() {
        
        presenter.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
                
                guard let self else { return }
                self.sampleView.updateRegisterButtonState(isEnable: viewState.isEnableRegisterButton)
                self.sampleView.hiddenAlertMessage(isHidden: viewState.isHiddenAlertMessage)
                
                if viewState.shouldClearTextFieldValue {
                    
                    self.sampleView.clearTextFiled()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc func tappedRegisterButton() {
        
        presenter.tappedRegisterButton()
    }
    
    @objc func didChangeTextFiled(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        presenter.didChangeText(text)
    }
}
