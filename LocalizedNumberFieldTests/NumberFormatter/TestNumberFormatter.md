# TestNumberFormatter.swift 테스트 결과 정리
## 테스트 주제 : 설정한 국가와 다른 국가의 Number String을 넣었을 때, 올바른 값으로 변환이 될까? 

|                                       | Number        | en_US           | ne              | ur_IN           | fr_FR           |
|---------------------------------------|---------------|-----------------|-----------------|-----------------|-----------------|
| only number                           | 123           | 123             | १२३             | ۱۲۳             | 123             |
| decimal separator                     | 123.4         | 123.4           | १२३.४           | ۱۲۳٫۴           | 123,4           |
| grouping separator                    | 123456789     | 123,456,789     | १२३,४५६,७८९     | ۱۲۳٬۴۵۶٬۷۸۹     | 123 456 789     |
| all | 123456789.123 | 123,456,789.123 | १२३,४५६,७८९.१२३ | ۱۲۳٬۴۵۶٬۷۸۹٫۱۲۳ | 123 456 789,123 |

올바른 숫자 포멧이긴 하나, 
NumberFormatter에 Locale로 설정한 국가와 다른 국가의 포멧일 경우, 
어디까지 보장이 되나 테스트해봤습니다.

선정 기준은 숫자 표기가 다르거나 grouping/decimal separator가 다른 것들입니다.

##### NumberFormatter Locale이 en_US인데, 다른 국가 숫자 포멧을 넣었을 경우
| NumberFormatter Locale | Input Number String Format | Input Number String Format | Input Number String Format |
|------------------------|----------------------------|----------------------------|----------------------------|
| en_US                  | ne                         | ur_IN                      | fr_FR                      |
| 123                    | o                          | o                          | o                          |
| 123.4                  | o                          | x (to number = nil)        | x (to number = nil)        |
| 123,456,789            | o                          | o                          | o                          |
| 123,456,789.123        | o                          | x (to number = nil)        | x (to number = nil)        |
* ne의 경우, NSNumber로 올바르게 변경이 된다.
    * en과 ne은 decimal/grouping separator가 같다.
    * en과 ne은 숫자 표기가 다르다.
* ur_IN 포멧의 숫자가 소숫점이 있을 경우, NSNumber로 변경 되지 않는다.
    * en과 ur_IN는 숫자 표기와 decimal/grouping separator 모두 다르다.
* fr_FR 포멧의 숫자가 소숫점이 있을 경우, NSNumber로 변경 되지 않는다.
    * en과 fr_FR는 숫자 표기가 같다.
    * en과 fr_FR는 decimal/grouping separator 모두 다르다.

##### NumberFormatter Locale이 ne인데, 다른 국가 숫자 포멧을 넣었을 경우
| NumberFormatter Locale | Input Number String Format | Input Number String Format | Input Number String Format |
|------------------------|----------------------------|----------------------------|----------------------------|
| ne                     | en_US                      | ur_IN                      | fr_FR                      |
| १२३                    | o                          | o                          | o                          |
| १२३.४                  | o                          | x (to number = nil)        | x (to number = nil)        |
| १२३,४५६,७८९            | o                          | o                          | o                          |
| १२३,४५६,७८९.१२३        | o                          | x (to number = nil)        | x (to number = nil)        |
* en의 경우, NSNumber로 올바르게 변경이 된다.
    * ne과 en은 decimal/grouping separator가 같다.
    * ne과 en은 숫자 표기가 다르다.
* ur_IN과 fr_FR가 소숫점이 있을 경우, NSNumber로 변경 되지 않는다.
    * ne와 ur_IN는 숫자 표기와 decimal/grouping separator 모두 다르다.
    * ne와 fr_FR는 숫자 표기와 decimal/grouping separator 모두 다르다.
    
##### NumberFormatter Locale이 ur_IN인데, 다른 국가 숫자 포멧을 넣었을 경우
| NumberFormatter Locale | Input Number String Format | Input Number String Format | Input Number String Format |
|------------------------|----------------------------|----------------------------|----------------------------|
| ur_IN                  | en_US                      | ne                         | fr_FR                      |
| ۱۲۳                    | o                          | o                          | o                          |
| ۱۲۳٫۴                  | x (to number = nil)        | x (to number = nil)        | o                          |
| ۱۲۳٬۴۵۶٬۷۸۹            | x (to number = nil)        | x (to number = nil)        | o                          |
| ۱۲۳٬۴۵۶٬۷۸۹٫۱۲۳        | x (to number = nil)        | x (to number = nil)        | o                          |
* en의 경우, NSNumber로 올바르게 변경이 된다.
    * ne과 en은 decimal/grouping separator가 같다.
    * ne과 en은 숫자 표기가 다르다.
* ur_IN과 fr_FR의 경우, 숫자만 있으면 변환이 잘 된다.
* ur_IN과 fr_FR에서 decimal separator 또는 grouping separator가 있으면, NSNumber로 변경 되지 않는다.
    * ne와 ur_IN는 숫자 표기와 decimal/grouping separator 모두 다르다.
    * ne와 fr_FR는 숫자 표기와 decimal/grouping separator 모두 다르다.


##### NumberFormatter Locale이 fr_FR인데, 다른 국가 숫자 포멧을 넣었을 경우
| NumberFormatter Locale | Input Number String Format | Input Number String Format | Input Number String Format |
|------------------------|----------------------------|----------------------------|----------------------------|
| fr_FR                  | en_US                      | ne                         | ur_IN                      |
| 123                    | o                          | o                          | o                          |
| 123,4                  | x (to number = nil)        | x (to number = nil)        | o                          |
| 123 456 789            | x (to number = nil)        | x (to number = nil)        | o                          |
| 123 456 789,123        | x (to number = nil)        | x (to number = nil)        | o                          |
* ur_IN의 경우, NSNumber로 올바르게 변경된다.
    * fr_FR와 ur_IN는 숫자 표기와 decimal/grouping separator 모두 다르다.
* en_US과 ne의 경우, 숫자만 있으면 변환이 잘 된다.
* en_US과 ne에서 decimal separator 또는 grouping separator가 있으면, NSNumber로 변경 되지 않는다.
    * fr_FR와 en_US은 숫자 표기는 같으나 decimal/grouping separator 모두 다르다.
    * fr_FR와 ne은 숫자 표기와 decimal/grouping separator 모두 다르다.
