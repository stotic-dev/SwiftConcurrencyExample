//
//  ConcurrencyViewController.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/06.
//

import UIKit

final class ConcurrencyViewController: UIViewController {
    
    // MARK: - factory method
    
    static func make() -> UIViewController {
        
        let vc = ConcurrencyViewController()
        
        let asyncStreamData = AsyncStream<ConcurrencyViewPresenter.ViewState>.makeStream()
        let presenter = ConcurrencyViewPresenter(continuation: asyncStreamData.continuation,
                                                 userDefaults: .standard)
        vc.presenter = presenter
        vc.viewStateStream = asyncStreamData.stream
        
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
    private var presenter: ConcurrencyViewPresenter!
    private var viewStateStream: AsyncStream<ConcurrencyViewPresenter.ViewState>!
    
    // MARK: - lifecycle method
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        Task {
            
            await observeViewState()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        presenter.onDisappear()
    }
}

extension ConcurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension ConcurrencyViewController {
    
    func observeViewState() async {
        
        for await viewState in viewStateStream {
            
            sampleView.updateRegisterButtonState(isEnable: viewState.isEnableRegisterButton)
            sampleView.hiddenAlertMessage(isHidden: viewState.isHiddenAlertMessage)
            
            if viewState.shouldClearTextFieldValue {
                
                sampleView.clearTextFiled()
            }
        }
    }
    
    @objc func tappedRegisterButton() {
        
        presenter.tappedRegisterButton()
    }
    
    @objc func didChangeTextFiled(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        presenter.didChangeText(text)
    }
}
