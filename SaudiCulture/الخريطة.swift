//
//  الخريطة.swift
//  SaudiCulture
//

import SwiftUI
import Combine

struct SaudiMapView: View {
    @StateObject private var gameProgress = GameProgress.shared
    @AppStorage("selectedCharacter") private var savedCharacter: String = "نجديه"
    @State private var selectedRegion: Region?
    @State private var goToLevels = false
    private let debugUnlockAll = false
    @State private var selectedRegionType: RegionType?
    @State private var showLockedDialog = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isIPad = true

                ZStack {
                    Color("BackgroundMain")
                        .ignoresSafeArea()
                    
                    Text("اختار المنطقة ")
                        .font(.custom("Saudi-Regular", size: isIPad ? 44 : 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color("brown"))
                        .multilineTextAlignment(.center)
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height * 0.1
                        )
                    
                    ZStack(alignment: .center) {
                        ClickableRegionView(
                            imageName: "‎⁨المنطقة الشماليه",
                            size: 450,
                            isUnlocked: gameProgress.isRegionUnlocked(.northern),
                            action: { handleRegionTap(.northern) }
                        )
                        .offset(x: -99, y: -300)
                        .zIndex(1)
                        
                        ClickableRegionView(
                            imageName: "‎⁨المنطقة الغربيه",
                            size: 399,
                            isUnlocked: gameProgress.isRegionUnlocked(.western),
                            action: { handleRegionTap(.western) }
                        )
                        .offset(x: -219, y: -20)
                        .zIndex(3)
                        
                        ClickableRegionView(
                            imageName: "‎⁨ المنطقة الشرقيه",
                            size: 410,
                            isUnlocked: gameProgress.isRegionUnlocked(.eastern),
                            action: { handleRegionTap(.eastern) }
                        )
                        .offset(x: 235, y: -10)
                        .zIndex(2)
                        
                        ClickableRegionView(
                            imageName: "‎⁨المنطقة الوسطى",
                            size: 400,
                            isUnlocked: gameProgress.isRegionUnlocked(.central),
                            action: { handleRegionTap(.central) }
                        )
                        .offset(x: -18, y: -15)
                        .zIndex(10)
                        
                        ClickableRegionView(
                            imageName: "المنطقة الجنوبية",
                            size: 260,
                            isUnlocked: gameProgress.isRegionUnlocked(.southern),
                            action: { handleRegionTap(.southern) }
                        )
                        .offset(x: -1, y: 239)
                        .zIndex(4)
                    }
                    .scaleEffect(0.48)
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height * 0.52
                    )
                    
                    if showLockedDialog {
                        lockedRegionDialog
                    }
                }
                .navigationDestination(isPresented: $goToLevels) {
                    if let region = selectedRegionType {
                        StackedCirclesView(selectedCharacter: savedCharacter, region: region)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private var lockedRegionDialog: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    showLockedDialog = false
                }
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("منطقة مغلقة")
                    .font(.custom("Saudi-Bold", size: 30))
                    .foregroundColor(Color("brown"))
                    .padding(.top, 40)
                
                Text("أكمل المنطقة السابقة لفتح هذه المنطقة!")
                    .font(.custom("Saudi-Regular", size: 22))
                    .foregroundColor(Color("brown"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                Button(action: {
                    showLockedDialog = false
                }) {
                    Text("حسناً")
                        .font(.custom("Saudi-Bold", size: 20))
                        .foregroundColor(Color("BackgroundMain"))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 12)
                        .background(Color("brown"))
                        .cornerRadius(25)
                }
                .padding(.bottom, 40)
            }
            .frame(width: 355, height: 350)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("brown"), lineWidth: 4)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("BackgroundMain"))
                    )
            )
        }
    }

    private func handleRegionTap(_ regionType: RegionType) {
        let isUnlocked = gameProgress.isRegionUnlocked(regionType)

        if isUnlocked {
            LevelFlow.shared.selectedRegion = regionType
            selectedRegionType = regionType
            goToLevels = true
        } else {
            selectedRegion = Region(
                type: regionType,
                name: regionType.displayName,
                isLocked: true
            )
            showLockedDialog = true
        }
    }
}

struct ClickableRegionView: View {
    let imageName: String
    let size: CGFloat
    let isUnlocked: Bool
    let action: () -> Void
    
    var body: some View {
        let image = Image(imageName)
        
        Button(action: action) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .grayscale(isUnlocked ? 0 : 0.85)
                .opacity(isUnlocked ? 1.0 : 0.4)
        }
        .buttonStyle(TransparentButtonStyle())
        .contentShape(RegionImageShape(imageName: imageName))
    }
}

struct RegionImageShape: Shape {
    let imageName: String

    func path(in rect: CGRect) -> Path {
        guard let uiImage = UIImage(named: imageName),
              let cgImage = uiImage.cgImage else {
            return Path(rect)
        }

        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return Path(rect)
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelData = context.data else { return Path(rect) }

        let step = max(width / 50, 1)
        var path = Path()
        let blockW = rect.width / CGFloat(width) * CGFloat(step)
        let blockH = rect.height / CGFloat(height) * CGFloat(step)

        var y = 0
        while y < height {
            var x = 0
            while x < width {
                let pixelIndex = (y * width + x) * bytesPerPixel
                let alpha = pixelData.load(fromByteOffset: pixelIndex + 3, as: UInt8.self)

                if alpha > 10 {
                    let px = CGFloat(x) / CGFloat(width) * rect.width
                    let py = CGFloat(y) / CGFloat(height) * rect.height
                    path.addRect(CGRect(x: px, y: py, width: blockW, height: blockH))
                }
                x += step
            }
            y += step
        }

        return path
    }
}

struct TransparentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

enum RegionType: String, CaseIterable, Codable {
    case central = "المنطقة الوسطى"
    case eastern = "المنطقة الشرقية"
    case northern = "المنطقة الشمالية"
    case western = "المنطقة الغربية"
    case southern = "المنطقة الجنوبية"

    var displayName: String { self.rawValue }

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

struct Region: Identifiable {
    let id = UUID()
    let type: RegionType
    let name: String
    var isLocked: Bool = false
}

class GameProgress: ObservableObject {
    static let shared = GameProgress()

    @Published private var completedRegions: Set<String> = []
    private let userDefaultsKey = "completedRegions"

    init() { loadProgress() }

    private func loadProgress() {
        if let saved = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            completedRegions = Set(saved)
        }
    }

    private func saveProgress() {
        UserDefaults.standard.set(Array(completedRegions), forKey: userDefaultsKey)
    }

    func isRegionUnlocked(_ region: RegionType) -> Bool {
        if region == .central {
            return true
        }
        
        guard let previousRegion = RegionType.allCases
            .first(where: { $0.order == region.order - 1 }) else {
            return false
        }
        
        let previousLevelCompleted = LevelFlow.shared.currentLevel(for: previousRegion)
        return previousLevelCompleted > 4
    }

    func isRegionCompleted(_ region: RegionType) -> Bool {
        completedRegions.contains(region.rawValue)
    }

    func completeRegion(_ region: RegionType) {
        completedRegions.insert(region.rawValue)
        saveProgress()
        objectWillChange.send()
    }

    func resetProgress() {
        completedRegions.removeAll()
        saveProgress()
        objectWillChange.send()
    }
}

#Preview {
    SaudiMapView()
}
