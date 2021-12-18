//
//  December14.swift
//  
//
//  Created by Samuel Norling on 2021-12-18.
//

import Foundation

enum December14 {

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

    static func getNextPairCounts(state: PairCounts, pairMap: PairMap) -> PairCounts {
        var nextState = [Pair: Int]()
        for (pair, count) in state {
            let new = pairMap[pair]!
            let firstKey = "\(pair.first!)\(new)"
            let secondKey = "\(new)\(pair.last!)"
            nextState[firstKey] = (nextState[firstKey] ?? 0) + count
            nextState[secondKey] = (nextState[secondKey] ?? 0) + count
        }
        return nextState
    }

    static func getMostAndLeast(characterCounts: [Character: Int]) -> MostAndLeastCommonCount {
        let values = characterCounts.values.map({$0}).sorted()
        return MostAndLeastCommonCount(most: values.last!, least: values.first!)
    }

    static func parseState(line: String) -> PairCounts {
        var state = [Pair: Int]()
        let characters = line.map({$0})
        let pairs: [Pair] = zip(
            characters.dropLast(),
            characters.dropFirst()
        ).map { (first, second) in
            "\(first)\(second)"
        }
        for pair in pairs {
            state[pair] = (state[pair] ?? 0) + 1
        }
        return state
    }

    static func characterCounts(state: PairCounts, lastCharacter: Character) -> [Character: Int] {
        var dict = [Character: Int]()
        for (pair, count) in state {
            // We only count first character in each pair
            // If we count the second character we would count that character twice
            let firstCharacter = pair.first!
            dict[firstCharacter] = (dict[firstCharacter] ?? 0) + count
        }
        dict[lastCharacter] = (dict[lastCharacter] ?? 0) + 1
        return dict
    }

    static func solvePairCounts(steps: Int, lines: [String], pairMap: PairMap) -> PairCounts {
        var pairCounts = parseState(line: lines.first!)
        for step in 0..<steps {
            pairCounts = getNextPairCounts(state: pairCounts, pairMap: pairMap)
        }
        return pairCounts
    }

    static func main(){
        let lines = DecemberIO.getLines()
        let pairMap = parsePairMap(lines: Array(lines.dropFirst(2)))
        let lastCharacter: Character = lines.first!.last!
        let pairCounts = solvePairCounts(
            steps: 40,
            lines: lines,
            pairMap: pairMap
        )
        let characterCounts = characterCounts(
            state: pairCounts,
            lastCharacter: lastCharacter
        )
        let results = getMostAndLeast(characterCounts: characterCounts)
        print(results.answer)
    }
}

typealias Pair = String
typealias PairMap = [Pair: Character]
typealias PairCounts = [Pair: Int]

struct MostAndLeastCommonCount {
    var most: Int
    var least: Int
    var answer: Int {
        most - least
    }
}
