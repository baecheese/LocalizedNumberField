//
//  SampleRow.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/23.
//

import SwiftUI

struct SampleRow: View {
    
    var dataSource: LocalizedNumberFieldViewModel
    
    private var title: String {
        return """
        🌎 from locale: \(dataSource.formatter.fromLocale.description)
         -> to locale: \(dataSource.formatter.toLocale.description)
        """
    }
    
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15.0, weight: .bold, design: .rounded))
            LocalizedNumberFieldView(dataSource: dataSource)
            Text("  \(dataSource.result.description)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15.0, weight: .light, design: .rounded))
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
