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
    case error(LocalizedNumberFormatterError)
    
    var description: String {
        switch self {
        case .none:
            return "none"
        case .success(let from, let to):
            return "\(from) -> \(to)"
        case .error(let error):
            return "\(error.message)"
        }
    }
    
    var index: Int {
        switch self {
        case .error(_):
            return -1
        case .none:
            return 0
        case .success(_, _):
            return 1
        }
    }
    
    var isError: Bool {
        return -1 == index
    }
    
}
