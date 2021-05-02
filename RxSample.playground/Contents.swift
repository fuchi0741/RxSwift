import UIKit
import RxSwift
import RxCocoa

let disposeBug = DisposeBag()

print("(1)--------------------")
let subject = PublishSubject<String>()
subject.onNext("テキスト")
subject.onNext("テキスト2")


subject.subscribe { event in
    print(event)
}

subject.onNext("テキスト3")
subject.onNext("テキスト4")

subject.dispose()

subject.onNext("テキスト5")

print("EOL")
