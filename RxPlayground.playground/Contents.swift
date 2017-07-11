//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport

// UIViewを生成する。大きさはPlaygroundなので適当
let view = UIView(frame: CGRect(x:0, y:0, width:360, height:480))
// 背景に薄灰色を表示
view.backgroundColor = UIColor.white
// ライブビューにセット
PlaygroundPage.current.liveView = view


// http://tiny-wing.hatenablog.com/entry/2016/01/16/075011 試したやつ
// 空のObservableを作成
let emptyStream : Observable<Int> = Observable.empty()

let subscription = emptyStream.subscribe { (event) in
    print(event)
}

print("\n一つだけイベントを送信するObservable")

// 一つだけイベントを送信するObservable
let singleElementStream = Observable.just(32)
let subscription2 = singleElementStream
    .subscribe { (event) in
        print(event)
}

print("\n一定数の要素からObservableを作成(of)")

// コレクションからObservableを作成
let stream = Observable.of(0, 1, 2, 10)
let subscription3 = stream
    .subscribe { event in
        print(event)
}

print("\nコレクションからObservableを作成(from)")

let streamFromArray = Observable.from([0, 1, 2, 100,"",true,2.0])
let subscription4 = streamFromArray
    .subscribe { event in
        print(event)
}

print("\ndeffered利用")

let defferedStream = Observable.deferred { () -> Observable<Int> in
    print("作成")
    return Observable.just(32)
}
print("subscription5前")
let subscription5 = defferedStream.subscribe { event in
    print(event)
}

print("\ncombineLatest")

let s = PublishSubject<Int>()
let t = PublishSubject<String>()
// s,t を結合
_ = Observable.combineLatest(s, t) {
    "\($0)\($1)"
    }
    .subscribe {
        print($0)
}

s.onNext(1)
t.onNext("a")
s.onNext(2)
t.onNext("b")
t.onNext("b")
