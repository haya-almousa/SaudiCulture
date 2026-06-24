//
//  LEVEL.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 22/08/1447 AH.
//

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
            let isIPad = geo.size.width >= 700

            ZStack {
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text("اضغط على المرحله ")
                            .font(.custom("Saudi-Regular", size: isIPad ? 34 : 26))
                            .fontWeight(.bold)
                            .foregroundColor(Color("brown"))
                            .multilineTextAlignment(.center)
                            .offset(
                                x: -1,
                                y: isIPad ? -geo.size.height * 0.36 : -330
                            )
                    }

                    HStack {
                        Button(action: {
                            goToMap = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("brown"))
                                    .frame(
                                        width: isIPad ? 76 : 60,
                                        height: isIPad ? 76 : 60
                                    )
                                
                                Image("saudiMap")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: isIPad ? 45 : 35,
                                        height: isIPad ? 45 : 35
                                    )
                            }
                        }
                        .offset(
                            x: isIPad ? geo.size.width * 0.34 : 153,
                            y: isIPad ? -geo.size.height * 0.42 : -380
                        )
                    }
                }

                ZStack {
                    ForEach(0..<totalLevels, id: \.self) { index in
                        Image(index <= current ? "yellowCircle" : "grayCircle")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: isIPad
                                ? (index == 0 ? 135 : 112)
                                : (index == 0 ? 110 : 90)
                            )
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
                        .frame(
                            width: isIPad ? 125 : 100,
                            height: isIPad ? 175 : 140
                        )
                        .offset(
                            y: yPosition(for: current, isIPad: isIPad) - (isIPad ? 88 : 70)
                        )
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: current)
                        .allowsHitTesting(false)
                }
                .offset(y: isIPad ? 0 : 60)
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
        if isIPad {
            let spacing: CGFloat = 135
            let startFromBottom: CGFloat = 60
            return startFromBottom - CGFloat(index) * spacing
        } else {
            let spacing: CGFloat = 110
            let startFromBottom: CGFloat = 200
            return startFromBottom - CGFloat(index) * spacing
        }
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
