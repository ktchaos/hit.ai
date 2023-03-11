//
//  Property.swift
//  RxProperty
//
//  Created by Yasuhiro Inami on 2017-03-11.
//  Copyright © 2017 Yasuhiro Inami. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift

final class Property<Element> {
    private let behaviorRelay: BehaviorRelay<Element>

    /// Gets current value.
    var value: Element {
        self.behaviorRelay.value
    }

    /// Initializes with initial value.
    init(_ value: Element) {
        self.behaviorRelay = BehaviorRelay(value: value)
    }

    /// Initializes with `BehaviorRelay`.
    init(_ behaviorRelay: BehaviorRelay<Element>) {
        self.behaviorRelay = behaviorRelay
    }

    /// Initializes with `initial` element and then `observable`.
    init(initial: Element, then observable: RxSwift.Observable<Element>) {
        self.behaviorRelay = BehaviorRelay(value: initial)

        _ = observable
            .bind(to: self.behaviorRelay)
            // .disposed(by: disposeBag)    // Comment-Out: Don't dispose when `property` is deallocated
    }

    /// Observable that synchronously sends current element and then changed elements.
    /// This is same as `ReactiveSwift.Property<T>.producer`.
    func asObservable() -> RxSwift.Observable<Element> {
        return self.behaviorRelay.asObservable()
    }

    func asDriver() -> Driver<Element> {
        return self.behaviorRelay.asDriver()
    }

    /// Observable that only sends changed elements, ignoring current element.
    /// This is same as `ReactiveSwift.Property<T>.signal`.
    var changed: RxSwift.Observable<Element> {
        self.asObservable().skip(1)
    }
}
