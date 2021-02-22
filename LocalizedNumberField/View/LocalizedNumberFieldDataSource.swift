//
//  LocalizedNumberFieldDataSource.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/21.
//

import UIKit

protocol LocalizedNumberFieldDataSource {
    
    /// you can use `LocalizedStringKey`
    var placeHolder: String { get }
    
    var text: String { get set }
    
    var formatter: LocalizedNumberFormatter { get }
    
    var keyboardType: UIKeyboardType { get }
}
