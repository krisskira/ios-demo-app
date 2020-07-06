//
//  StringExtension.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import Foundation

extension String {
    public func localize(tableName: String? = nil) -> String {
        NSLocalizedString(self, tableName: tableName, bundle: .main, value: self, comment: self)
    }
}
