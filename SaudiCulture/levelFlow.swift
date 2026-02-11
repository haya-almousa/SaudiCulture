//
//  levelFlow.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 23/08/1447 AH.
//
import SwiftUI
internal import Combine

class LevelFlow: ObservableObject {

    static let shared = LevelFlow()

    @Published var currentLevel: Int = 0
    @Published var puzzleIndex: Int = 0

    func completeLevel() {
        currentLevel += 1
        puzzleIndex += 1
    }
}

