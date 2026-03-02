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
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("اضغط على المرحله ")
                        .font(.custom("Saudi-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color("brown"))
                        .multilineTextAlignment(.center)
                        .offset(y: -280)
                }

                HStack {
                    Button(action: {
                        goToMap = true
                    }) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color("brown"))
                            .clipShape(Circle())
                    }
                    .offset(x: 140, y: -413)
                }
            }

            ZStack {
                ForEach(0..<totalLevels, id: \.self) { index in
                    Image(index <= current ? "yellowCircle" : "grayCircle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: index == 0 ? 110 : 90)
                        .offset(y: yPosition(for: index))
                        .onTapGesture {
                            if index == current {
                                selectedLevelNumber = index + 1
                                navigateToFashion = true
                            }
                        }
                }

                Image(selectedCharacter)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 140)
                    .offset(y: yPosition(for: current) - 70)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: current)
                    .allowsHitTesting(false)
            }
            .offset(y: 60)
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
                الشماليه(region: region, levelNumber: selectedLevelNumber)
            case .southern:
                الجنوبيه(region: region, levelNumber: selectedLevelNumber)
            case .eastern:
                الشرقيه(region: region, levelNumber: selectedLevelNumber)
            case .western:
                الغربيه(region: region, levelNumber: selectedLevelNumber)
            }
        }
    }

    func yPosition(for index: Int) -> CGFloat {
        let spacing: CGFloat = 110
        let startFromBottom: CGFloat = 200
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
