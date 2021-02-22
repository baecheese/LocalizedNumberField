//
//  Locale.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/10.
//

import Foundation

extension Locale {
    
    /// 123,456,789.123
    static var en_US: Locale {
        return Locale(identifier: "en_US")
    }
    
    /// 123,456,789.123
    static var ko_KR: Locale {
        return Locale(identifier: "ko_KR")
    }
    
    /// 123 456 789,123
    static var fr_GP: Locale {
        return Locale(identifier: "fr_GP")
    }
    
    /// १२३,४५६,७८९.१२३
    static var ne: Locale {
        return Locale(identifier: "ne")
    }
    
    /// ١٢٣٬٤٥٦٬٧٨٩٫١٢٣
    static var ar: Locale {
        return Locale(identifier: "ar")
    }
    
    /// 123’456’789.123
    static var it_CH: Locale { // Italian (Switzerland)
        return Locale(identifier: "it_CH")
    }
    
}
