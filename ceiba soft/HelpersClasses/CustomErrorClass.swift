//
//  CustomError.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import Foundation

class CustomError {

    enum ErrorMessages: String {
        case no_data
        case not_users
        case storage_user_data
    }

    static func build(errorString: ErrorMessages, code: Int? = nil, domain: String? = nil) -> NSError{
        self.build(message: errorString.rawValue.localize(), code: code, domain: domain)
    }

    static func build(message: String, code: Int? = nil, domain: String? = nil ) -> NSError {
        NSError( domain: domain ?? "", code: code ?? 0,
            userInfo: [
                NSLocalizedDescriptionKey:  message
            ]
        )
    }
}
