//
//  SampleList.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/23.
//

import SwiftUI

struct SampleList: View {
    
    @EnvironmentObject var modelData: SampleFieldModel
    
    var body: some View {
        List {
            ForEach(modelData.fieldViewModels) {
                LocalizedNumberFieldView(dataSource: $0)
            }
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleList()
            .environmentObject(SampleFieldModel())
    }
}
