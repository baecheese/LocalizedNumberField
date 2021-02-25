//
//  LocalizedNumberFormatterResult.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/23.
//

import Foundation

enum LocalizedNumberFormatterResult {
    case none
    case success(from: String, to: String)
    case error(Error)
    
    var description: String {
        switch self {
        case .none:
            return "hello"
        case .success(let from, let to):
            return "\(from) -> \(to)"
        case .error(let error):
            return "\(error)"
        }
    }
}
