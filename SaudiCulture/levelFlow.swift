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

    // 🔹 المرحلة الحالية لكل منطقة
    @Published var currentLevelByRegion: [RegionType: Int] = [
        .central: 0,
        .northern: 0,
        .southern: 0,
        .eastern: 0,
        .western: 0
    ]

    // 🔹 قراءة المرحلة الحالية
    func currentLevel(for region: RegionType) -> Int {
        currentLevelByRegion[region] ?? 0
    }

    // 🔹 إنهاء مرحلة واحدة
    func completeLevel(region: RegionType) {
        let next = currentLevel(for: region) + 1
        currentLevelByRegion[region] = next
    }

    // 🔹 تصفير المنطقة (اختياري)
    func reset(region: RegionType) {
        currentLevelByRegion[region] = 0
    }
}
