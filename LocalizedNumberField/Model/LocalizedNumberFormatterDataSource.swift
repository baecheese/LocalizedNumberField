//
//  LocalizedNumberFormatterDataSource.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/09.
//

import Foundation

protocol LocalizedNumberFormatterDataSource {
    
    var fromLocale: Locale { get }
    var toLocale: Locale { get }
    
    func number(from value: String) throws -> NSNumber
    func localizedNumberString(from value: String, style: NumberFormatter.Style) throws -> String
}
