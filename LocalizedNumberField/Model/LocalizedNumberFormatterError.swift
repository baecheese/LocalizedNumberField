//
//  LocalizedNumberFormatterError.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/09.
//

import Foundation

enum LocalizedNumberFormatterError: Error {
    case invaildCharacters
    case moreThanOneDecimalSeparator
    case reverseSeparator
    case notConvertedNSNumberToLocalizedString
    case unknown
    
    
    var message: String {
        switch self {
        case .invaildCharacters:
            return "올바르지 않은 문자가 포함되어있습니다."
        case .moreThanOneDecimalSeparator:
            return "소숫점 기호가 한 개 이상입니다."
        case .reverseSeparator:
            return "그룹 구분 기호와 소숫점 기호가 반대로 되어있습니다."
        case .notConvertedNSNumberToLocalizedString:
            return "현지화 문자로 변환 되지 않는 숫자입니다."
        case .unknown:
            return "알 수 없는 에러입니다."
        }
    }
}
