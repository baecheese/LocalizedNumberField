//
//  LocalizedNumberFieldViewModel.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/21.
//

import UIKit
import SwiftUI

class LocalizedNumberFieldViewModel: LocalizedNumberFieldDataSource, Identifiable {
    
    var index: Int
    var placeHolder: String
    var text: String
    var formatter: LocalizedNumberFormatter
    var keyboardType: UIKeyboardType
    var result: LocalizedNumberFormatterResult = .none
    
    init(
        index: Int,
        placeHolder: String,
        text: String = "",
        formatter: LocalizedNumberFormatter,
        keyboardType: UIKeyboardType = .default
    ) {
        self.index = index
        self.placeHolder = placeHolder
        self.text = text
        self.formatter = formatter
        self.keyboardType = keyboardType
    }
    
}
