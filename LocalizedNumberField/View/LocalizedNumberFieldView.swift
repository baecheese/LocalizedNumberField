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
    
    @Binding var isCommit: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    dataSource.placeHolder,
                    text: $modelData.fieldViewModels[dataSource.index].text,
                    onEditingChanged: { onEditing in
                        guard isCommit && onEditing else { return }
                        isCommit.toggle()
                    },
                    onCommit: {
                        try? validate(text: dataSource.text)
                        isCommit.toggle()
                    }
                )
                .keyboardType(dataSource.keyboardType)
                .border(Color(textfieldBorderColor), width: 1)
            }
        }
    }
    
    private func validate(text: String) throws {
        do {
            let localizedNumber = try dataSource.formatter.localizedNumberString(from: text, style: .decimal)
            setResult(text: localizedNumber, result: .success(from: text, to: localizedNumber))
        } catch {
            dataSource.text = text
            setResult(text: text, result: .error(error))
            throw error
        }
    }
    
    private func setResult(text: String, result: LocalizedNumberFormatterResult) {
        dataSource.text = text
        dataSource.result = result
        textfieldBorderColor = result.isError ? .systemRed : .systemFill
    }
    
}

struct LocalizedNumberField_Previews: PreviewProvider {
    
    static let sampleData = SampleFieldModel()
    
    static var previews: some View {
        VStack {
            LocalizedNumberFieldView(dataSource: sampleData.fieldViewModels[0], isCommit: .constant(false))
                .environmentObject(sampleData)
        }
    }
}
