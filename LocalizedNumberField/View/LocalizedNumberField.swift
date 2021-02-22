//
//  LocalizedNumberField.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/21.
//

import SwiftUI

struct LocalizedNumberField: View, LocalizedNumberFieldDataSource {
    
    @State internal var placeHolder: String
    @State internal var text: String
    @State internal var keyboardType: UIKeyboardType
    @State internal var formatter: LocalizedNumberFormatter
    
    @State private var log: String = "💛log"
    @State private var textfieldBorderColor: UIColor = .systemFill
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    placeHolder,
                    text: $text,
                    onEditingChanged: {
                        if false == $0 {
                            textfieldBorderColor = .systemFill
                        }
                        log += "\nonEditingChanged \($0)"
                    },
                    onCommit: {
                        log += "\nonCommit"
                        try? validate(text: text)
                    }
                )
                .keyboardType(keyboardType)
                .border(Color(textfieldBorderColor), width: 1)
            }
            Label(text, systemImage: "1.circle")
            Label(log, systemImage: "2.circle")
        }
    }
    
    func validate(text: String) throws {
        do {
            let number = try formatter.number(from: text)
            let localizedNumber = try formatter.localizedNumberString(from: text, style: .decimal)
            log += """
            toNumber: \(number)
            localizedNumber: \(localizedNumber)
            -----------------------------------
            """
            self.text = localizedNumber
        } catch {
            textfieldBorderColor = .systemRed
            log += " - error: \n\(error)"
            throw error
        }
    }
    
}

struct LocalizedNumberField_Previews: PreviewProvider {
    
    typealias ViewModel = LocalizedNumberFieldViewModel
    static var previews: some View {
        VStack {
            LocalizedNumberField(
                placeHolder: "input number",
                text: "123",
                keyboardType: .default,
                formatter: LocalizedNumberFormatter(
                    from: Locale.ko_KR,
                    to: Locale.ne
                )
            )
        }
    }
}
