//
//  CombineViewPresenter.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

import Foundation

final class CombineViewPresenter: ObservableObject {
    
    // MARK: - publish property
    
    @Published var viewState: ViewState = .initial
    
    private var inputText: InputText = .init(value: "")
    
    // MARK: - dependency
    
    private let userDefaults: UserDefaults
    
    // MARK: - initialize
    
    init(userDefaults: UserDefaults) {
        
        self.userDefaults = userDefaults
    }
    
    // MARK: - public method
    
    func didChangeText(_ text: String) {
        
        inputText = InputText(value: text)
        viewState = .init(isEnableRegisterButton: inputText.canRegister,
                          isHiddenAlertMessage: inputText.canRegister,
                          shouldClearTextFieldValue: false)
    }
    
    func tappedRegisterButton() {
        
        userDefaults.set(inputText.value, forKey: "registered_text")
        viewState = .registered
    }
}

extension CombineViewPresenter {
    
    struct ViewState: Equatable {
        
        let isEnableRegisterButton: Bool
        let isHiddenAlertMessage: Bool
        let shouldClearTextFieldValue: Bool
        
        static let initial = ViewState(isEnableRegisterButton: false,
                                       isHiddenAlertMessage: true,
                                       shouldClearTextFieldValue: false)
        
        static let registered = ViewState(isEnableRegisterButton: false,
                                          isHiddenAlertMessage: true,
                                          shouldClearTextFieldValue: true)
    }
}
