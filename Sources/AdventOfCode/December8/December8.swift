//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-08.
//

import Foundation
public struct PairInput {
    let signalPatterns: [Digit]
    let output: [Digit]
    var allPatterns: [Digit] {
        signalPatterns + output
    }
    func parseFirstTranslationSet() -> [Set<Character>: Int] {
        var setTranslation = [Set<Character>: Int]()
        allPatterns.forEach { pattern in
            if case let .encoded(set) = pattern {
                if setTranslation.keys.contains(set) {
                    return
                }
                let setSize = set.count
                let uniqueSizes = Digit.simpleTranslation.keys
                if uniqueSizes.contains(setSize) {
                    setTranslation[set] = setSize
                }
            }
        }
        return setTranslation
    }
    func parseSecondTranslationSet(firstSet: [Set<Character>: Int]) -> Set<Set<Character>> {
        var secondSet = firstSet
        let allSets: [Set<Character>] = allPatterns.compactMap { pattern -> Set<Character>? in
            switch pattern {
            case .encoded(let set):
                return set
            default:
                return nil
            }
        }
        let fullSet: Set<Set<Character>> = Set(allSets)
        print("fullSet")
        print(fullSet)

        let firstSets = Set(firstSet.keys)
        print(type(of: firstSets))
        let finalSets = fullSet.subtracting(firstSets)
        print("finalSets")
        print(finalSets)
        return finalSets
    }
    func solve() -> PairInput {
        let firstSet = self.parseFirstTranslationSet()
        let secondSet = self.parseSecondTranslationSet(firstSet: firstSet)
        print("firstSet")
        print(firstSet)
        print("secondSet")
        print(secondSet)
        return PairInput(
            signalPatterns: self.signalPatterns.map({$0.simpleConversion()}),
            output: output.map({$0.simpleConversion()})
        )
    }
}
public enum Digit {
    case decoded(Int)
    case encoded(Set<Character>)
    static var simpleTranslation: [Int: Int] = [
        2: 1,
        4: 4,
        3: 7,
        7: 8
    ]
    func simpleConversion() -> Digit {
        switch self {
        case .decoded:
            return self
        case .encoded(let set):
            guard let translation = Self.simpleTranslation[set.count] else {
                return self
            }
            return .decoded(translation)
        }
    }
}
public extension PairInput {
    init(
        zeroToNineString: String,
        outputString: String
    ) {
        self.signalPatterns = zeroToNineString
            .split(separator: " ")
            .compactMap(String.init)
            .map({ signal in
                Digit.encoded(Set(signal))
            })
        self.output = outputString
            .split(separator: " ")
            .compactMap(String.init)
            .map({ digitString in
                Digit.encoded(Set(digitString))
            })
    }
}
enum December8 {


    static func main() {
        let lines = DecemberIO.getLines()
        let pairs: [PairInput] = lines.map { line in
            let components = line.split(separator: "|").compactMap(String.init)
            return PairInput(
                zeroToNineString: components[0].trimmingCharacters(in: .whitespaces),
                outputString: components[1].trimmingCharacters(in: .whitespaces)
            )
        }
//        print(pairs)
        let solvedPairs = pairs.map {$0.solve()}
//        print(solvedPairs)
        for pair in solvedPairs {
            let output = pair.output
//            print(output)
        }
        let answerSum = solvedPairs.reduce(0) { partialResult, pair in
            partialResult + pair.output.reduce(0, { pairSum, digit in
                switch digit {
                case .decoded:
                    return pairSum + 1
                case .encoded:
                    return pairSum
                }
            })
        }
        print(answerSum)
    }
}


/*
 Using this information, you should be able to work out which combination of signal wires corresponds to each of the ten digits. Then, you can decode the four digit output value.
 */
