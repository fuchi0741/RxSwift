import UIKit
import RxSwift
import RxCocoa

let disposeBug = DisposeBag()

print("(1)PublishSubject")
let publishSubject = PublishSubject<String>()
publishSubject.onNext("テキスト")
publishSubject.onNext("テキスト2")


publishSubject.subscribe { event in
    print(event)
}

publishSubject.onNext("テキスト3")
publishSubject.onNext("テキスト4")

publishSubject.dispose()

publishSubject.onNext("テキスト5")

print("(2)BehaviorSubject")
let behaviorSubject = BehaviorSubject(value: "初期値")

behaviorSubject.onNext("ラストテキスト")

behaviorSubject.subscribe { event in
    print(event)
}

print("(3)ReplaySubject")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("テキスト1")
replaySubject.onNext("テキスト2")
replaySubject.onNext("テキスト3")

print("1回目")
replaySubject.subscribe {
    print($0)
}

replaySubject.onNext("テキスト4")
replaySubject.onNext("テキスト5")
replaySubject.onNext("テキスト6")

print("2回目")

replaySubject.subscribe {
    print($0)
}

print("EOL")
