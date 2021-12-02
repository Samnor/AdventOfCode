//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-02.
//

import Foundation
import simd

struct December2 {

    static func getLines() -> [String] {
        var lines = [String]()
        while let line = readLine() {
            lines.append(line)
        }
        return lines
    }

    static func partOne() {
        let lines = getLines()
//        print(lines)

        let finalPosition: SubmarinePosition = lines.reduce(
            into: SubmarinePosition(position: 0, depth: 0)) { partialResult, line in
                partialResult.update(line: line)
            }
        let answer = finalPosition.getAnswer()
        print(answer)

    }

    struct SubmarinePosition {
        var position: Int
        var depth: Int

        mutating func update(line: String) {
            let components = line.split(separator: " ")
            guard let command = components.first,
                  let valueString = components.last,
                  let value = Int(valueString)
            else {
                      fatalError("Fix your input!")
                  }
            switch command {
            case "forward":
                self.position += value
            case "up":
                self.depth -= value
            case "down":
                self.depth += value
            default:
                fatalError("Fix your input!")
            }
        }

        func getAnswer() -> Int {
            position * depth
        }
    }
}
