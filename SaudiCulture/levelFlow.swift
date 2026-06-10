//
//  levelFlow.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 23/08/1447 AH.
//
import SwiftUI
import Combine

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

//class LevelFlow: ObservableObject {
//    static let shared = LevelFlow()
//
//    @Published var progress: [RegionType: Int] = [:]
//    @Published var selectedRegion: RegionType? = nil
//
//    func currentLevel(for region: RegionType) -> Int {
//        progress[region] ?? 0
//    }
//
//    func completeLevel(region: RegionType) {
//        let current = currentLevel(for: region)
//        let maxLevel = 4 // لأن المراحل 0..4 (5 مراحل)
//        if current < maxLevel {
//            progress[region] = current + 1
//        }
//    }
//}
//

class LevelFlow: ObservableObject {
    static let shared = LevelFlow()

    @Published var progress: [RegionType: Int] = [:] {
        didSet {
            saveProgress()
        }
    }
    @Published var selectedRegion: RegionType? = nil 
    private let key = "levelProgress"

    init() {
        loadProgress()
    }

    func currentLevel(for region: RegionType) -> Int {
        progress[region] ?? 0
    }

//    func completeLevel(region: RegionType) {
//        let current = currentLevel(for: region)
//        let maxLevel = 4 // لأن المراحل 0..4 (5 مراحل)
//        if levelNumber - 1 == current && current < maxLevel {
//               progress[region] = current + 1
//           }
//    }
    func completeLevel(region: RegionType, levelNumber: Int) {
        let current = currentLevel(for: region)
        let maxLevel = 5 // لأن المراحل 0..4 (5 مراحل)

        // زيادة المستوى فقط إذا هذه أعلى مرحلة مفتوحة
        if levelNumber - 1 == current && current < maxLevel {
            progress[region] = current + 1
        }
    }

    // حفظ البيانات
    private func saveProgress() {
        var dictToSave: [String: Int] = [:]
        for (region, level) in progress {
            dictToSave[region.rawValue] = level
        }
        UserDefaults.standard.set(dictToSave, forKey: key)
    }

    // تحميل البيانات
    private func loadProgress() {
        if let saved = UserDefaults.standard.dictionary(forKey: key) as? [String: Int] {
            var loaded: [RegionType: Int] = [:]
            for (key, value) in saved {
                if let region = RegionType(rawValue: key) {
                    loaded[region] = value
                }
            }
            progress = loaded
        }
    }
}


