# LocalizedNumberField

![iOS](https://img.shields.io/badge/iOS-14.1-yellow)
![Swift5.0](https://img.shields.io/badge/swift-5.0-brightgreen)
![Swift-ui](https://img.shields.io/badge/UI-SwiftUI-9cf)
![MIT](https://img.shields.io/badge/licenses-MIT-blue)

글로벌 서비스를 개발하며, 국가와 언어 별로 상이한 숫자 표기 체계를 경험했습니다. 
유저의 다양한 입력 환경에 대응할 수 있는 구현 방식이 무엇인지 고민하고,
이에 대해 정리한 공간입니다.

## 🌷 Blog Post
> * 1편 - [[Localized Number] 1편: 글로벌 서비스 숫자 표기에 대한 고민](https://velog.io/@baecheese/Localized-Number-%EA%B8%80%EB%A1%9C%EB%B2%8C-%EC%84%9C%EB%B9%84%EC%8A%A4-%EC%88%AB%EC%9E%90-%ED%91%9C%EA%B8%B0%EC%97%90-%EB%8C%80%ED%95%9C-%EA%B3%A0%EB%AF%BC-%EB%8B%A4%EC%96%91%ED%95%9C-%EC%88%AB%EC%9E%90%EC%99%80-%EC%86%8C%EC%88%AB%EC%A0%90-%EC%B2%9C%EB%8B%A8%EC%9C%84-%ED%91%9C%EA%B8%B0-1)
> * 2편 - [[Localized Number] 2편: NumberFormatter를 이용한 국가별 숫자 표기 변환](https://velog.io/@baecheese/Localized-Number-NumberFormatter%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EA%B5%AD%EA%B0%80%EB%B3%84-%EC%88%AB%EC%9E%90-%ED%91%9C%EA%B8%B0-%EB%B3%80%ED%99%98-2)
> * 3편 - [[Localized Number] 3편: NumberFormatter의 제약사항과 보완점](https://velog.io/@baecheese/Localized-Number-%EA%B5%AD%EA%B0%80%EC%96%B8%EC%96%B4-%EB%B3%84-%EC%88%AB%EC%9E%90-%EB%B3%80%ED%99%98-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-%EB%A7%8C%EB%93%A4%EA%B8%B0-3)
> * 4편 - [[Localized Number] 4편: LocalizedNumberFormatter 구현하기](https://velog.io/@baecheese/Localized-Number-4%ED%8E%B8-LocalizedNumberFormatter-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)
> * 5편 - [[Localized Number] 5편: LocalizedNumberField 라이브러리 만들기](https://velog.io/@baecheese/Localized-Number-5%ED%8E%B8-LocalizedNumberField-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-%EB%A7%8C%EB%93%A4%EA%B8%B0)

## 🔍 Features
### Support
* iOS 14.1
* Swift 5.0
* SwiftUI
* Swift Package Manager

### Preview
#### Screenshot
![](https://images.velog.io/images/baecheese/post/e7b82625-87ce-471a-adfe-559d4a3e71bf/IMG_1212.PNG)
* 숫자 변환 필드 리스트 구현

#### Detail
![](https://images.velog.io/images/baecheese/post/826e6867-ca72-4ec1-a375-103521548f7c/ezgif-2-616bfc5d268f.gif)
* from locale, to locale 설정 -> textfield input -> Button -> to locale 숫자 포맷으로 변환
    - `en_US(English, United States)` 숫자에서 `ar(Arabic)` 숫자로 변경

### Exmaple
#### 1. LocalizedNumberFieldDataSource 준비
``` swift
final class SampleFieldModel: ObservableObject {

    @Published var fieldViewModels: [LocalizedNumberFieldViewModel] = [
        LocalizedNumberFieldViewModel(
            index: 0,
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.ko_KR),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            index: 1,
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.fr_GP),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            index: 2,
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.ne),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            index: 3,
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.ar),
            keyboardType: .default
        ),
        LocalizedNumberFieldViewModel(
            index: 4,
            placeHolder: "숫자를 입력해주세요",
            text: "",
            formatter: LocalizedNumberFormatter(from: .en_US, to: Locale.it_CH),
            keyboardType: .default
        )
    ]
}
```
* 사용자 input과 숫자 변환에 따라 결과가 공유되어야 합니다.
* Sample Data Array는`@Published` Attributed로 지정합니다.
    - https://developer.apple.com/documentation/combine/published
    - https://developer.apple.com/tutorials/swiftui/handling-user-input
* Sample Data
    - from locale : `en_US`
    - to locale: `ko_KR`, `fr_GP`, `ne`, `ar`, `it_CH` 

#### 2. EnvironmentObject로 Sample Data 설정
##### @main
``` swift 
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
```
* 메인에서 샘플데이터를 environmentObject로 설정

##### ContentView
``` swift
struct ContentView: View {
    
    @EnvironmentObject var modelData: SampleFieldModel
    
    var body: some View {
        SampleList()
            .environmentObject(modelData)
    }
}
```
* 메인에서 넘긴 SampleModel을 최상위뷰에서 `@EnvironmentObject` Attribute로 설정.
    - https://developer.apple.com/documentation/swiftui/environmentobject

#### SampleList
``` swift
import SwiftUI

struct SampleList: View {
    
    @EnvironmentObject var modelData: SampleFieldModel
    
    var body: some View {
        List {
            ForEach(modelData.fieldViewModels) {
                SampleRow(dataSource: $0)
                    .environmentObject(modelData)
                    .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
```

#### 3. SampleRow - LocalizedNumberFieldView 사용

##### SampleRow
``` swift
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
                // ⭐️ use it!
                LocalizedNumberFieldView(dataSource: dataSource, endEditing: $endEditing)
                Button(
                    action: {
                        hideKeyboard() // extension 참고
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
             // textfield endEditing되면 변환 결과 보여주기
            Text("   result: \(endEditing ? dataSource.result.description : "none")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18.0, weight: .light, design: .rounded))
            Spacer()
        }
    }
    
}
```
* Button 누르면 Hide Keyboard (Finish Editing)

##### Extension
``` swift
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
```

##### LocalizedNumberFieldView
``` swift
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
```
1. **유저가 textfield editing을 끝냈을 때**, input 값을 `func validate(text: String) throws`를 통해 변환
> **onEditingChanged**
The action to perform when the user begins editing text and after the user finishes editing text. The closure receives a Boolean value that indicates the editing status: true when the user begins editing, **false when they finish**.
- https://developer.apple.com/documentation/swiftui/textfield/init(_:text:oneditingchanged:oncommit:)-588cl

2. DataSource에 변환결과(`LocalizedNumberFormatterResult`) 업데이트
3. SampleRow에서 `@State private var endEditing: Bool`이 업데이트
4. SampleRow에서 Text로 업데이트

#### 참고
* SwiftUI Tutorials
    - https://developer.apple.com/tutorials/swiftui/
