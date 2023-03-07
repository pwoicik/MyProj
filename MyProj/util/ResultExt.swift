//
//  Result.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Foundation

extension Result {
    func getOrNil() -> Success? {
        try? get()
    }
}
