//
//  Array+Extension.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 11.07.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}

extension Array {
    mutating func takeRandomly(numberOfElements n: Int) -> ArraySlice<Element> {
        assert(n <= self.count)
        for i in stride(from: self.count - 1, to: self.count - n - 1, by: -1) {
            let randomIndex = Int(arc4random_uniform(UInt32(i + 1)))
            self.swapAt(i, randomIndex)
        }
        return self.suffix(n)
    }
}
