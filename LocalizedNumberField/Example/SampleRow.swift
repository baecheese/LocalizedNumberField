//
//  SampleRow.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/23.
//

import SwiftUI

struct SampleRow: View {
    
    var dataSource: LocalizedNumberFieldViewModel
    @State private var isCommit: Bool = false
    
    private var title: String {
        return "🌎 from \(dataSource.formatter.fromLocale.identifier) to \(dataSource.formatter.toLocale.identifier)"
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20.0, weight: .bold, design: .rounded))
            LocalizedNumberFieldView(dataSource: dataSource, isCommit: $isCommit)
            Text(" result: \(isCommit ? dataSource.result.description : "none")")
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
