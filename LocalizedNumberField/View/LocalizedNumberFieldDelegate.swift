//
//  LocalizedNumberFieldDelegate.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/22.
//

 protocol LocalizedNumberFieldDelegate {
    
    func textFieldDidEndEditing(
        from fromText: String,
        to toText: String,
        formatter: LocalizedNumberFormatter,
        error: LocalizedNumberFormatterError?
    )
    
}
