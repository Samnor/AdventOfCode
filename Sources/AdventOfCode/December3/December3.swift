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

    struct BinaryDiagnosticTwo {
        let oxygen: Int
        let co2: Int
        var lifeSupport: Int {
            oxygen * co2
        }
        init(vectors: [simd_int16]) {
            self.oxygen = Self.parseOxygen(vectors: vectors, count: 12)
            self.co2 = Self.parseCo2(vectors: vectors, count: 12)
        }

        static func filterForPosition(_ position: Int, chosenNumbers: [simd_int16], invert: Bool = false) -> [simd_int16] {
            let oneNumbers = chosenNumbers.filter {$0[position] == Int32(1)}
            let zeroNumbers = chosenNumbers.filter {$0[position] == Int32(0)}
            if invert {
                return (oneNumbers.count >= zeroNumbers.count) ? zeroNumbers : oneNumbers
            } else {
                return (oneNumbers.count >= zeroNumbers.count) ? oneNumbers : zeroNumbers
            }
        }

        static func parseOxygen(vectors: [simd_int16], count: Int) -> Int {
            var chosenNumbers = vectors
            for index in 0..<count {
                if chosenNumbers.count == 1 {
                    break
                }
                chosenNumbers = Self.filterForPosition(index, chosenNumbers: chosenNumbers)
            }
            return chosenNumbers.first!.binaryToInt
        }
        static func parseCo2(vectors: [simd_int16], count: Int) -> Int {
            var chosenNumbers = vectors
            for index in 0..<count {
                print(chosenNumbers)
                if chosenNumbers.count == 1 {
                    break
                }
                chosenNumbers = Self.filterForPosition(index, chosenNumbers: chosenNumbers, invert: true)
            }
            return chosenNumbers.first!.binaryToInt
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

    static func partTwo() {
        let lines = DecemberIO.getLines()
        let binaryVectors = lines.map(parseLine(_:))
        let diagnostics = BinaryDiagnosticTwo(vectors: binaryVectors)
        print(diagnostics.lifeSupport)
    }
}

extension simd_int16 {
    var values: [Int32] {
        (0..<12).map { index in
            return self[index]
        }
    }
    var binaryToInt: Int {
        let binaryString: String = self.values.reduce("") { partialResult, value in
            partialResult + "\(value)"
        }
        print(binaryString)
        return Int(binaryString, radix: 2)!
    }
}
