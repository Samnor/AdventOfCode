//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-07.
//

import Foundation

enum December7 {
    static func mainOne() {
        let lines = DecemberIO.getLines()
        let positions = lines
            .first!
            .split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        print(positions)
        let maxPos = positions.max()!
        var minSum = 999999999
        for position in (0...maxPos) {
            let distSum = positions.reduce(0) { partialResult, crabPosition in
                return partialResult + abs(position - crabPosition)
            }
            minSum = min(minSum, distSum)
        }
        print(minSum)
    }

    static func posDistance(position: Int, crabPosition: Int) -> Int {
        let distance = abs(position - crabPosition)
        let arithmeticSeriesSum = distance * (1 + distance)/2
        return arithmeticSeriesSum
    }

    static func main() {
        let lines = DecemberIO.getLines()
        let positions = lines
            .first!
            .split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        print(positions)
        let maxPos = positions.max()!
        var minSum = 999999999
        for position in (0...maxPos) {
            let distSum = positions.reduce(0) { partialResult, crabPosition in
                return partialResult + posDistance(position: position, crabPosition: crabPosition)
            }
            minSum = min(minSum, distSum)
        }
        print(minSum)
    }
}
