//
//  LocalizedNumberFieldApp.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/08.
//

import SwiftUI

@main
struct LocalizedNumberFieldApp: App {
    
    @StateObject var sampleModel = SampleFieldModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sampleModel)
        }
    }
}
