//
//  ConcurrencyViewPresenter.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/06.
//

import Foundation

struct ConcurrencyViewPresenter {
        
    private let continuation: AsyncStream<ViewState>.Continuation
    
    // MARK: - dependency
    
    private let userDefaults: UserDefaults
    
    // MARK: - store property
    
    private var inputText: InputText = .init(value: "")
    
    // MARK: - initialize method
    
    init(continuation: AsyncStream<ViewState>.Continuation, userDefaults: UserDefaults) {
        
        self.continuation = continuation
        self.userDefaults = userDefaults
        
        self.continuation.yield(.initial)
    }
    
    // MARK: - public method
    
    mutating func didChangeText(_ text: String) {
        
        inputText = InputText(value: text)
        continuation.yield(.init(isEnableRegisterButton: inputText.canRegister,
                                 isHiddenAlertMessage: inputText.canRegister,
                                 shouldClearTextFieldValue: false))
    }
    
    func tappedRegisterButton() {
        
        userDefaults.set(inputText.value, forKey: "registered_text")
        continuation.yield(.registered)
    }
    
    func onDisappear() {
        
        continuation.finish()
    }
}

extension ConcurrencyViewPresenter {
    
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
