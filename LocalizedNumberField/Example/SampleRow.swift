//
//  SampleRow.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/23.
//

import SwiftUI

struct SampleRow: View {
    
    var dataSource: LocalizedNumberFieldViewModel
    
    /// textfield endEditing 일 때 상태 받는 곳
    @State private var endEditing: Bool = false
    
    private var title: String {
        return "🌎 from \(dataSource.formatter.fromLocale.identifier) to \(dataSource.formatter.toLocale.identifier)"
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20.0, weight: .bold, design: .rounded))
            HStack {
                Spacer()
                LocalizedNumberFieldView(dataSource: dataSource, endEditing: $endEditing)
                Button(
                    action: {
                        hideKeyboard()
                    },
                    label: {
                        Text("Button")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(5.0)
                    }
                )
                .background(Color.yellow)
                Spacer()
            }
            Text("   result: \(endEditing ? dataSource.result.description : "none")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18.0, weight: .light, design: .rounded))
            Spacer()
        }
    }
    
}

struct SampleRow_Previews: PreviewProvider {
    
    static let sampleData = SampleFieldModel()
    
    static var previews: some View {
        SampleRow(dataSource: sampleData.fieldViewModels[0])
            .environmentObject(sampleData)
    }
}
