//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-06.
//

import Foundation

enum December6 {

    class FishWeek {
        var week: [Int: Int]
        private var weekUpcoming: [Int: Int]
        var day = 0
        init(fishNumbers: [Int]) {
            self.week = [:]
            self.weekUpcoming = [:]
            (0...6).forEach { day in
                week[day] = 0
            }
            fishNumbers.forEach { fishDay in
                week[fishDay]! += 1
            }
            (0...6).forEach { day in
                weekUpcoming[day] = 0
            }
        }
        var newborns: Int {
            print(day)
            return week[day]!
        }
        var fishCount: Int {
            self.week.values.reduce(0, +) + self.weekUpcoming.values.reduce(0, +)
        }
        func fishPuberty() {
            let pubertyIndex = (day + 2) % 7
            week[pubertyIndex]! += weekUpcoming[pubertyIndex]!
            weekUpcoming[pubertyIndex] = 0
        }
        func runDay() {
            fishPuberty()
            createFish()
            day += 1
            day = day % 7
        }

        func createFish(){
            let birthIndex = (day + 2) % 7
            print("createFish \(birthIndex) \(newborns)")
            weekUpcoming[birthIndex]! += newborns
        }
    }

    static func main() {
        let lines = DecemberIO.getLines()
        let numbers = lines.first!
            .split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        print(numbers.count)
        let fishWeek = FishWeek(fishNumbers: numbers)
        let days = 256
        (0..<days).forEach { day in
            fishWeek.runDay()
        }
        print(fishWeek.fishCount)
    }
}
