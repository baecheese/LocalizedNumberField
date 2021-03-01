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
    
    /// textfield endEditing 일 때 상태 변환
    @Binding var endEditing: Bool
    @State private var textfieldBorderColor: UIColor = .systemFill
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    dataSource.placeHolder,
                    text: $modelData.fieldViewModels[dataSource.index].text,
                    onEditingChanged: { onEditing in
                        if false == onEditing {
                            try? validate(text: dataSource.text)
                        }
                        endEditing = !onEditing
                    }
                )
                .keyboardType(dataSource.keyboardType)
                .border(Color(textfieldBorderColor), width: 1)
            }
        }
    }
    
    /// 변환 결과값
    private func validate(text: String) throws {
        do {
            let localizedNumber = try dataSource.formatter.localizedNumberString(from: text, style: .decimal)
            setResult(text: localizedNumber, result: .success(from: text, to: localizedNumber))
        } catch {
            let formatterError = error as? LocalizedNumberFormatterError
            setResult(text: text, result: .error(formatterError ?? .unknown))
            throw error
        }
    }
    
    private func setResult(text: String, result: LocalizedNumberFormatterResult) {
        dataSource.result = result
        textfieldBorderColor = result.isError ? .systemRed : .systemFill
    }
    
}

struct LocalizedNumberField_Previews: PreviewProvider {
    
    static let sampleData = SampleFieldModel()
    
    static var previews: some View {
        VStack {
            LocalizedNumberFieldView(
                dataSource: sampleData.fieldViewModels[0],
                endEditing: .constant(false)
            )
            .environmentObject(sampleData)
        }
    }
}
