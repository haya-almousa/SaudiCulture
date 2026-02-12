//
//  levelFlow.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 23/08/1447 AH.
//
import SwiftUI
internal import Combine

//class LevelFlow: ObservableObject {
//
//    static let shared = LevelFlow()
//
//    @Published var currentLevel: Int = 0
//    @Published var puzzleIndex: Int = 0
//
//    func completeLevel() {
//        currentLevel += 1
//        puzzleIndex += 1
//    }
//}
//

class LevelFlow: ObservableObject {
    static let shared = LevelFlow()

    @Published var progress: [RegionType: Int] = [:]
    @Published var selectedRegion: RegionType? = nil

    func currentLevel(for region: RegionType) -> Int {
        progress[region] ?? 0
    }

    func completeLevel(region: RegionType) {
        let current = currentLevel(for: region)
        let maxLevel = 4 // لأن المراحل 0..4 (5 مراحل)
        if current < maxLevel {
            progress[region] = current + 1
        }
    }
}





