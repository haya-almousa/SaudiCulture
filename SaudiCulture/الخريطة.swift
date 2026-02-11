//
//  الخريطة.swift
//  SaudiCulture
//
//  Created by Raghad Alamoudi on 22/08/1447 AH.
//

import SwiftUI
internal import Combine

struct SaudiMapView: View {
    // MARK: - Properties
    @StateObject private var gameProgress = GameProgress.shared
    @State private var selectedRegion: Region?
    @State private var goToLevels = false

    // MARK: - Body
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                ZStack {
                    // Background
                    Color("BackgroundMain")
                        .ignoresSafeArea()
                    
                    // Map Container
                    ZStack(alignment: .center) {
                        
                        // المنطقة الشمالية
                        RegionImageView(
                            imageName: "المنطقة الشماليه",
                            size: 280,
                            isUnlocked: gameProgress.isRegionUnlocked(.northern)
                        )
                        .offset(x: -70, y: -160)
                        .zIndex(1)

                        .onTapGesture {
                            handleRegionTap(.northern)
                        }
                        
                        // المنطقة الشرقية
                        RegionImageView(
                            imageName: "المنطقة الشرقيه",
                            size: 250,
                            isUnlocked: gameProgress.isRegionUnlocked(.eastern)
                        )
                        .offset(x: 110, y: -10)

                        .onTapGesture {
                            handleRegionTap(.eastern)
                        }
                        
                        // المنطقة الوسطى (مفتوحة)
                        //                    RegionImageView(
                        //                        imageName: "المنطقة الوسطى",
                        //                        size: 200,
                        //                        isUnlocked: gameProgress.isRegionUnlocked(.central)
                        //                    )
                        //                    .offset(x: -18, y: -20)
                        //                    .onTapGesture {
                        //                        handleRegionTap(.central)
                        //                    }
                        
                        // المنطقة الوسطى  wed
                        RegionImageView(
                            imageName: "المنطقة الوسطى",
                            size: 200,
                            isUnlocked: true
                        )
                        .offset(x: -18, y: -20)
                        .zIndex(10)
                        .onTapGesture {
                            goToLevels = true   // 👈 هنا فقط
                        }

                        
                        // المنطقة الغربية
                        RegionImageView(
                            imageName: "المنطقة الغربيه",
                            size: 280,
                            isUnlocked: gameProgress.isRegionUnlocked(.western)
                        )
                        .offset(x: -120, y: -30)
                        .onTapGesture {
                            handleRegionTap(.western)
                        }
                        
                        // المنطقة الجنوبية
                        RegionImageView(
                            imageName: "المنطقة الجنوبيه",
                            size: 150,
                            isUnlocked: gameProgress.isRegionUnlocked(.southern)
                        )
                        .offset(x: -12, y: 111)
                        .onTapGesture {
                            handleRegionTap(.southern)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .navigationDestination(isPresented: $goToLevels) {
                    StackedCirclesView()
                }
                
            }
            .navigationBarBackButtonHidden(true)

//            .alert(item: $selectedRegion) { region in
//                Alert(
//                    title: Text(region.isLocked ? "🔒 منطقة مقفلة" : region.name),
//                    message: Text(region.isLocked ? "أكمل المنطقة السابقة لفتح هذه المنطقة!" : "اخترت \(region.name)"),
//                    dismissButton: .default(Text("حسناً"))
//                )
//            }
            //wed
            .alert(item: $selectedRegion) { region in
                Alert(
                    title: Text(region.isLocked ? "🔒 منطقة مقفلة" : region.name),
                    message: Text(
                        region.isLocked
                        ? "أكمل المنطقة السابقة لفتح هذه المنطقة!"
                        : "اخترت \(region.name)"
                    ),
                    dismissButton: .default(Text("حسناً"))
                )
            }

            
        }
    }
    
    // MARK: - Functions
//    private func handleRegionTap(_ regionType: RegionType) {
//        let isUnlocked = gameProgress.isRegionUnlocked(regionType)
//        
//        selectedRegion = Region(
//            type: regionType,
//            name: regionType.displayName,
//            isLocked: !isUnlocked
//        )
//        
//        // هنا راح تضيف الـ Navigation لصفحة الألغاز
//    }
    
    //wed
    private func handleRegionTap(_ regionType: RegionType) {

        // 👑 المنطقة الوسطى: انتقال مباشر
        if regionType == .central {
            goToLevels = true
            return
        }

        // باقي المناطق فقط
        let isUnlocked = gameProgress.isRegionUnlocked(regionType)

        selectedRegion = Region(
            type: regionType,
            name: regionType.displayName,
            isLocked: !isUnlocked
        )
    }

}

// MARK: - Region Image View
struct RegionImageView: View {
    let imageName: String
    let size: CGFloat
    let isUnlocked: Bool
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .grayscale(isUnlocked ? 0 : 0.85)
            .opacity(isUnlocked ? 1.0 : 0.4)
    }
}

// MARK: - Region Type Enum
enum RegionType: String, CaseIterable {
    case central = "المنطقة الوسطى"
    case eastern = "المنطقة الشرقية"
    case northern = "المنطقة الشمالية"
    case western = "المنطقة الغربية"
    case southern = "المنطقة الجنوبية"
    
    var displayName: String {
        return self.rawValue
    }
    
    var order: Int {
        switch self {
        case .central: return 1
        case .eastern: return 2
        case .northern: return 3
        case .western: return 4
        case .southern: return 5
        }
    }
}

// MARK: - Region Model
struct Region: Identifiable {
    let id = UUID()
    let type: RegionType
    let name: String
    var isLocked: Bool = false
}

// MARK: - Game Progress Manager
class GameProgress: ObservableObject {
    static let shared = GameProgress()
    
    @Published private var completedRegions: Set<String> = []
    
    private let userDefaultsKey = "completedRegions"
    
    init() {
        loadProgress()
    }
    
    // تحميل التقدم من UserDefaults
    private func loadProgress() {
        if let saved = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            completedRegions = Set(saved)
        }
    }
    
    // حفظ التقدم في UserDefaults
    private func saveProgress() {
        UserDefaults.standard.set(Array(completedRegions), forKey: userDefaultsKey)
    }
    
    // التحقق من فتح المنطقة
    func isRegionUnlocked(_ region: RegionType) -> Bool {
        // المنطقة الوسطى مفتوحة دائماً
        if region == .central {
            return true
        }
        
        // تحقق من المنطقة السابقة
        let previousRegion = getPreviousRegion(region)
        return previousRegion == nil || isRegionCompleted(previousRegion!)
    }
    
    // التحقق من إنجاز المنطقة
    func isRegionCompleted(_ region: RegionType) -> Bool {
        return completedRegions.contains(region.rawValue)
    }
    
    // إنجاز منطقة (يتم استدعاؤها عند إنهاء الألغاز)
    func completeRegion(_ region: RegionType) {
        completedRegions.insert(region.rawValue)
        saveProgress()
        objectWillChange.send()
    }
    
    // الحصول على المنطقة السابقة
    private func getPreviousRegion(_ region: RegionType) -> RegionType? {
        let allRegions = RegionType.allCases.sorted { $0.order < $1.order }
        guard let currentIndex = allRegions.firstIndex(of: region), currentIndex > 0 else {
            return nil
        }
        return allRegions[currentIndex - 1]
    }
    
    // إعادة تعيين التقدم (للتطوير/التجربة)
    func resetProgress() {
        completedRegions.removeAll()
        saveProgress()
        objectWillChange.send()
    }
}

// MARK: - Preview
#Preview {
    SaudiMapView()
}
