//
//  LocalizedNumberFieldView.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/21.
//

import SwiftUI

struct LocalizedNumberFieldView: View {
    
    @EnvironmentObject var modelData: SampleFieldModel
    
    var dataSource: LocalizedNumberFieldViewModel
    @State private var textfieldBorderColor: UIColor = .systemFill
    @State private var isLoading: Bool = false
    @State private var  log: String = ""
    
    var index: Int {
        var index: Int = 0
        for viewModel in modelData.fieldViewModels {
            guard dataSource.id != viewModel.id else { break }
            index += 1
        }
        return index
    }
    
    private var currentText: String {
        dataSource.text
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    dataSource.placeHolder,
                    text: $modelData.fieldViewModels[index].text,
                    onEditingChanged: {
                        self.log += "\nonEditingChanged (\($0)) :\(currentText)"
                        if false == $0 {
                            textfieldBorderColor = .systemFill
                        }
                    },
                    onCommit: {
                        self.log += "\nonCommit :\(currentText)"
//                        try? validate(text: text)
                    }
                )
                .keyboardType(dataSource.keyboardType)
                .border(Color(textfieldBorderColor), width: 1)
            }
        }
    }
    
    func validate(text: String) throws {
//        do {
//            let localizedNumber = try dataSource.formatter.localizedNumberString(from: text, style: .decimal)
//            self.text = localizedNumber
//            self.delegate?.textFieldDidEndEditing(from: text, to: self.text, formatter: dataSource.formatter, error: nil)
//        } catch {
//            textfieldBorderColor = .systemRed
//            self.delegate?.textFieldDidEndEditing(from: text, to: self.text, formatter: dataSource.formatter, error: (error as? LocalizedNumberFormatterError) ?? LocalizedNumberFormatterError.unknown)
//            throw error
//        }
    }
    
    
    
}

struct LocalizedNumberField_Previews: PreviewProvider {
    
    static let sampleData = SampleFieldModel()
    
    static var previews: some View {
        VStack {
            LocalizedNumberFieldView(dataSource: sampleData.fieldViewModels[0])
                .environmentObject(sampleData)
        }
    }
}
