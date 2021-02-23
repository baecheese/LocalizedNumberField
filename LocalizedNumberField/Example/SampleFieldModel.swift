//
//  SampleFieldModel.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/23.
//

import Foundation

final class SampleFieldModel: ObservableObject {
    
    @Published var fieldViewModels: [LocalizedNumberFieldViewModel] = [
        LocalizedNumberFieldViewModel(
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.ko_KR),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.fr_GP),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.ne),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.ar),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.it_CH),
            keyboardType: .default
        )
    ]
}
