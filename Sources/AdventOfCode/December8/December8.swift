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
    func solveOneFourSevenEight() -> PairInput {
        return PairInput(
            signalPatterns: self.signalPatterns.map({$0.simpleConversion()}),
            output: output.map({$0.simpleConversion()})
        )
    }
}
public enum Digit {
    case decoded(Int)
    case encoded(String)
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
        case .encoded(let string):
//            print("string \(string)")
            guard let translation = Self.simpleTranslation[string.count] else {
                return self
            }
//            print(translation)
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
                Digit.encoded(signal)
            })
        self.output = outputString
            .split(separator: " ")
            .compactMap(String.init)
            .map({ digitString in
                Digit.encoded(digitString)
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
        let solvedPairs = pairs.map {$0.solveOneFourSevenEight()}
//        print(solvedPairs)
        for pair in solvedPairs {
            let output = pair.output
            print(output)
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
