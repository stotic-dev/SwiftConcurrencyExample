//
//  InputText.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

struct InputText {
    
    let value: String
    let canRegister: Bool
    
    private let canRegisterPredicate = /([a-z]|[A-Z]|[0-9])*/
    
    init(value: String) {
        self.value = value
        self.canRegister = value.isEmpty ? false : value.wholeMatch(of: canRegisterPredicate) != nil
    }
}
