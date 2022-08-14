//
//  LoginResponse+Extension.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import Foundation

extension LoginResponse {
    public func saveToken() {
        let sessionManager = SessionManager()
        sessionManager.setUserToken(session.bearerToken)
    }
}
