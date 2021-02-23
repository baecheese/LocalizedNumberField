//
//  LocalizedNumberFieldApp.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SampleList()
            .environmentObject(SampleFieldModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SampleFieldModel())
    }
}
