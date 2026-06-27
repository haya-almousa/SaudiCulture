//
//  LEVEL.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 22/08/1447 AH.


//test the push 
import SwiftUI

struct StackedCirclesView: View {
    let selectedCharacter: String
    let region: RegionType
    let totalLevels = 5
    
    @StateObject var flow = LevelFlow.shared
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameProgress = GameProgress.shared
    @State private var navigateToPuzzle = false
    @State private var navigateToFashion = false
    @State private var goToMap = false
    
    @State private var selectedLevelNumber: Int = 1

    var current: Int {
        min(flow.currentLevel(for: region), totalLevels - 1)
    }

    var backgroundImageName: String {
        switch region {
        case .central:  return "الوسطى"
        case .northern: return "الشماليه"
        case .southern: return "الجنوبيه"
        case .eastern:  return "الشرقيه"
        case .western:  return "الغربيه"
        }
    }

    var body: some View {
        GeometryReader { geo in
            let screenW = geo.size.width
            let isIPad = screenW >= 700
            
            let titleFontSize: CGFloat = isIPad ? 36 : 26
            let titleOffsetY: CGFloat = isIPad ? -720 : -340
            
            let mapCircleSize: CGFloat = isIPad ? 75 : 60
            let mapImageSize: CGFloat = isIPad ? 45 : 35
            let mapOffsetX: CGFloat = isIPad ? 310 : 150
            let mapOffsetY: CGFloat = isIPad ? -800 : -400
            
            let circleSize: CGFloat = isIPad ? 125 : 90
            let firstCircleSize: CGFloat = isIPad ? 150 : 110
            
            let characterWidth: CGFloat = isIPad ? 140 : 100
            let characterHeight: CGFloat = isIPad ? 190 : 140
            let characterOffset: CGFloat = isIPad ? 95 : 70
            
            let stackOffsetY: CGFloat = isIPad ? -200 : 60

            ZStack {
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(isIPad ? 0.99 : 1.0)
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text("اضغط على المرحله ")
                            .font(.custom("Saudi-Regular", size: titleFontSize))
                            .fontWeight(.bold)
                            .foregroundColor(Color("brown"))
                            .multilineTextAlignment(.center)
                            .offset(x: -1, y: titleOffsetY)
                    }

                    HStack {
                        Button(action: {
                            goToMap = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("brown"))
                                    .frame(width: mapCircleSize, height: mapCircleSize)
                                
                                Image("saudiMap")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: mapImageSize, height: mapImageSize)
                            }
                        }
                        .offset(x: mapOffsetX, y: mapOffsetY)
                    }
                }

                ZStack {
                    ForEach(0..<totalLevels, id: \.self) { index in
                        Image(index <= current ? "yellowCircle" : "grayCircle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: index == 0 ? firstCircleSize : circleSize)
                            .offset(y: yPosition(for: index, isIPad: isIPad))
                            .onTapGesture {
                                if index <= current {
                                    selectedLevelNumber = index + 1
                                    navigateToFashion = true
                                }
                            }
                    }

                    Image(selectedCharacter)
                        .resizable()
                        .scaledToFit()
                        .frame(width: characterWidth, height: characterHeight)
                        .offset(y: yPosition(for: current, isIPad: isIPad) - characterOffset)
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: current)
                        .allowsHitTesting(false)
                }
                .offset(y: stackOffsetY)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToMap) {
            SaudiMapView()
        }
        .navigationDestination(isPresented: $navigateToFashion) {
            switch region {
            case .central:
                الوسطى(region: region, levelNumber: selectedLevelNumber)
            case .northern:
                NorthernView(region: region, levelNumber: selectedLevelNumber)
            case .southern:
                الجنوبيه(region: region, levelNumber: selectedLevelNumber)
            case .eastern:
                الشرقيه(region: region, levelNumber: selectedLevelNumber)
            case .western:
                الغربيه(region: region, levelNumber: selectedLevelNumber)
            }
        }
    }

    func yPosition(for index: Int, isIPad: Bool) -> CGFloat {
        let spacing: CGFloat = isIPad ? 145 : 110
        let startFromBottom: CGFloat = isIPad ? 300 : 200
        
        return startFromBottom - CGFloat(index) * spacing
    }
}

#Preview {
    NavigationStack {
        StackedCirclesView(
            selectedCharacter: "نجديه",
            region: .central
        )
    }
}
