//
//  December14.swift
//  
//
//  Created by Samuel Norling on 2021-12-18.
//

import Foundation

enum December14 {

    static func performPolymerInsertion(state: [String: Int], pairMap: [String: [String]]) -> [String: Int] {
        var nextState = [String: Int]()
        state.forEach { (key: String, value: Int) in
            let newPairs = pairMap[key]!
            for newPair in newPairs {
                nextState[newPair] = nextState[newPair] ?? 0 + value
            }
        }
        return nextState
    }

    static func parsePairMap(lines: [String]) -> PairMap {
        var dict = PairMap()
        for line in lines {
            let components = line.split(separator: ">")
            let key = String(components.first!.prefix(2))
            let nextCharacter = components.last!.last!
            dict[key] = nextCharacter
        }
        return dict
    }

    static func countMostCommonElement(state: [String: Int]) -> Int {
        var dict = [Character: Int]()
        for (key, value) in state {
            for character in key {
                dict[character] = dict[character] ?? 0 + value
            }
        }
        print(dict)
        return 0
    }

    static func countLeastCommonElement(state: [String: Int]) -> Int {
        return 0
    }

    static func sumPairs(state: [String: Int]) -> Int {
        state.values.reduce(0, +)
    }

    static func getNextState(state: State, pairMap: PairMap) -> State {
        let characters = state.map({$0})
        let pairs = zip(characters.dropLast(), characters.dropFirst()).map({$0})
        let almostResult = pairs.reduce("") { partialResult, pair in
            let pairKey = "\(pair.0)\(pair.1)"
            let newPart = [
                String(pair.0),
                String(pairMap[pairKey]!)
            ].joined()
            return partialResult + newPart
        }
        return almostResult + String(characters.last!)
    }

    static func getMostAndLeast(state: String) -> MostAndLeastCommonCount {
        var dict = [Character: Int]()
        for character in state.map({$0}) {
            dict[character] = (dict[character] ?? 0) + 1
        }
        print(dict)
        let values = dict.values.map({$0}).sorted()
        print(values)
        return MostAndLeastCommonCount(most: values.last!, least: values.first!)
    }

    static func parseState(line: String) -> State {
        line
    }

    static func main(){
        let lines = DecemberIO.getLines()
        print(lines)
        let pairMap = parsePairMap(lines: Array(lines.dropFirst(2)))
        print(pairMap)
        var currentState = parseState(line: lines.first!)
        let steps = 4
        for step in 0..<steps {
            print("step: \(step)")
            print(currentState)
            currentState = getNextState(state: currentState, pairMap: pairMap)
        }
        print(currentState)
        let results = getMostAndLeast(state: currentState)
        print(results)
        print(results.answer)
    }
}

typealias Pair = String
typealias PairMap = [String: Character]
typealias State = String

struct MostAndLeastCommonCount {
    var most: Int
    var least: Int
    var answer: Int {
        most - least
    }
}
