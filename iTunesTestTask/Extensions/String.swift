//
//  String.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 17.10.2024.
//

import Foundation


extension String {
    
    enum ValidTypes {
        case name
        case email
        case password
    }
    
    // - Задаем допустимые параметры для ввода
    enum RegEx: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    
    // - Метод проверяет, валидно ли вводимое значение или нет
    func isValid(validType: ValidTypes) -> Bool {
        
        // - Фильтруем строку и проверяем ее значения 
        let format = "SELF MATCHES %@"
        var regEx = ""
        
        switch validType {
        case .name: regEx = RegEx.name.rawValue
        case .email: regEx = RegEx.email.rawValue
        case .password: regEx = RegEx.password.rawValue
        }
        
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
    
}
