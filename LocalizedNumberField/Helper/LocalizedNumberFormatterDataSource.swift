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
    var amount: String { get set }
}
