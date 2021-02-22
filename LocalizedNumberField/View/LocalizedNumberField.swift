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
    @State private var textfieldBorderColor: UIColor = .systemFill
    @State private var isLoading: Bool = false
    
    var delegate: LocalizedNumberFieldDelegate?
    @State private var  log: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    placeHolder,
                    text: $text,
                    onEditingChanged: {
                        self.log += "\nonEditingChanged (\($0)) :\(text)"
                        if false == $0 {
                            textfieldBorderColor = .systemFill
                        }
                    },
                    onCommit: {
                        self.log += "\nonCommit :\(text)"
                        try? validate(text: text)
                    }
                )
                .keyboardType(keyboardType)
                .border(Color(textfieldBorderColor), width: 1)
//                Text(log)
            }
        }
    }
    
    func validate(text: String) throws {
        do {
            let localizedNumber = try formatter.localizedNumberString(from: text, style: .decimal)
            self.text = localizedNumber
            self.delegate?.textFieldDidEndEditing(from: text, to: self.text, formatter: formatter, error: nil)
        } catch {
            textfieldBorderColor = .systemRed
            self.delegate?.textFieldDidEndEditing(from: text, to: self.text, formatter: formatter, error: (error as? LocalizedNumberFormatterError) ?? LocalizedNumberFormatterError.unknown)
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
