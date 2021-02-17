//
//  LocalizedNumberFormatterError.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/09.
//

import Foundation

enum LocalizedNumberFormatterError: Error {
    /***
     🙅🏻‍♀️ 올바르지 않은 숫자 포멧
     1. decimal/grouping separator 외에 숫자가 아닌 문자가 포함된 경우
        - 10️⃣0️⃣0️⃣ (이모지 포함)
        - looo (알파벳 LOOO)
        - 100-100 (특수문자 포함)
     2. decimal separator가 한 개 이상 들어간 경우
        - 🇺🇸 en_US ) 1.0.2 (.이 두 개)
     3. grouping separator와 decimal separator의 순서가 뒤집힌 경우
        - 🇺🇸 en_US ) 1,000.12 (o)
        - 🇺🇸 en_US ) 1.000,12 (x)
     **/
    
    case invaildCharacters
    case moreThanOneDecimalSeparator
    case reverseGroupingSeparatorAndDecimalSeparator
    
}
