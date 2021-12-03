//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-03.
//

import Foundation
import simd

enum December3 {

    struct BinaryDiagnostic {
        let gamma: Int
        let epsilon: Int
        var powerConsumption: Int {
            gamma * epsilon
        }
        init(roundedSum: simd_int16) {
            let integerCount = 12
            let integers = roundedSum.values.prefix(integerCount)
            let gammaString: String = integers.reduce("") { partialResult, value in
                partialResult + "\(value)"
            }
            print(gammaString)
            self.gamma = Int(gammaString, radix: 2)!
            let epsilonString: String = integers.reduce("") { partialResult, value in
                let invertedValue = (value == 1) ? 0 : 1
                return partialResult + "\(invertedValue)"
            }
            print(epsilonString)
            self.epsilon = Int(epsilonString, radix: 2)!
        }
    }

    static func parseLine(_ line: String) -> simd_int16 {
        let components = Array(line).map(String.init)
        let integers = components.compactMap({Int.init($0)}).map(Int32.init)
        let paddedIntegers = integers + Array(repeating: 0, count: max(16 - integers.count, 0))
        return simd_int16(paddedIntegers)
    }

    static func partOne() {
        let lines = DecemberIO.getLines()
        let count = lines.count
        let binaryVectors = lines.map(parseLine(_:))
        let vectorSum = binaryVectors.reduce(simd_int16.zero, &+)
        print(vectorSum)
        let floatSum = simd_float16.init(vectorSum)
        print(floatSum)
        let dividedSum = floatSum/Float(count)
        print(dividedSum)
        let roundedSum = simd_int16(dividedSum.rounded(.toNearestOrEven))
        print(roundedSum)
        let diagnostic = BinaryDiagnostic(roundedSum: roundedSum)
        print(diagnostic.powerConsumption)
//        let binInt = Int.init("1110", radix: 2)
//        print(binInt)
    }
}

extension simd_int16 {
    var values: [Int32] {
        self.indices.map { index in
            return self[index]
        }
    }
}
