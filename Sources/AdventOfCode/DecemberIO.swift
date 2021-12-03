//
//  File.swift
//  
//
//  Created by Samuel Norling on 2021-12-03.
//

import Foundation

public struct DecemberIO {
    static func getLines() -> [String] {
        var lines = [String]()
        while let line = readLine() {
            lines.append(line)
        }
        return lines
    }
}
