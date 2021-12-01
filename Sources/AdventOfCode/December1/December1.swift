//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-01.
//

import Foundation
import Combine

struct December1 {

    private static func evaluatePairs(numbers: [Int]) -> Int {
        let pairs = zip(numbers.dropLast(), numbers.dropFirst())
        return pairs.reduce(0) { partialResult, pair in
            partialResult + (pair.1 > pair.0 ? 1 : 0)
        }
    }

    static func partOne() {
        var lines = [String]()
        while let line = readLine() {
            lines.append(line)
        }
        let numbers = lines.compactMap(Int.init)
        let answer = evaluatePairs(numbers: numbers)
        print(answer)
    }

    static func partTwo() {
        var lines = [String]()
        while let line = readLine() {
            lines.append(line)
        }
        var tripletSums = [Int]()
        let numbers = lines.compactMap(Int.init)
        _ = Publishers.Zip3(
            numbers.dropLast(2).publisher,
            numbers.dropFirst().dropLast().publisher,
            numbers.dropFirst(2).publisher
        )
            .map({ triplet in
                return [
                    triplet.0,
                    triplet.1,
                    triplet.2
                ].reduce(0, +)
            })
            .sink(receiveCompletion: { _ in
                let answer = evaluatePairs(numbers: tripletSums)
                print(answer)
            }, receiveValue: { tripletSum in
                tripletSums.append(tripletSum)
            })
    }
}
