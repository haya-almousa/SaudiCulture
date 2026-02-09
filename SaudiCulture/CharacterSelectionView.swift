//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//
import SwiftUI

struct CharacterPickerView: View {
    let playerName: String
    
    let characterPairs: [[String]] = [
        ["نجدي", "نجديه"],
        ["شرقاوية", "شرقاوي"],
        ["شماليه", "شمالي"],
        ["جنوبي", "جنوبيه"],
        ["غربيه", "غربي"],
    ]

    @State private var selectedName: String? = nil
    @State private var navigateToWelcome = false

    private var isNameValid: Bool { selectedName != nil }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("اضغط على شخصيتك")
                    .font(.custom("Saudi-Regular", size: 32))
                    .foregroundStyle(Color("brown"))
                    .padding(.top, 20)
                
                let regionTitles: [String] = [
                    "المنطقة الوسطى",
                    "المنطقة الشرقية",
                    "المنطقة الشمالية",
                    "المنطقة الجنوبية",
                    "المنطقة الغربية"
                ]

                ForEach(0..<characterPairs.count, id: \.self) { rowIndex in
                    let pair = characterPairs[rowIndex]
                    let isEvenRow = rowIndex % 2 == 0

                    HStack(alignment: .center, spacing: 8) {
                        if isEvenRow {
                            Text(regionTitles[rowIndex])
                                .font(.custom("Saudi-Regular", size: 28))
                                .foregroundStyle(Color("brown"))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)

                            Spacer(minLength: 6)

                            HStack(spacing: -64) {
                                ForEach(pair, id: \.self) { name in
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 140)
                                        .opacity(selectedName == nil ? 0.6 : (selectedName == name ? 1.0 : 0.35))
                                        .animation(.easeInOut(duration: 0.2), value: selectedName)
                                        .onTapGesture {
                                            selectedName = name
                                        }
                                        .zIndex(selectedName == name ? 1 : 0)
                                }
                            }
                            .frame(maxWidth: 240, alignment: .trailing)
                        } else {
                            HStack(spacing: -64) {
                                ForEach(pair, id: \.self) { name in
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 140)
                                        .opacity(selectedName == nil ? 0.6 : (selectedName == name ? 1.0 : 0.35))
                                        .animation(.easeInOut(duration: 0.2), value: selectedName)
                                        .onTapGesture {
                                            selectedName = name
                                        }
                                        .zIndex(selectedName == name ? 1 : 0)
                                }
                            }
                            .frame(maxWidth: 240, alignment: .leading)

                            Spacer(minLength: 6)

                            Text(regionTitles[rowIndex])
                                .font(.custom("Saudi-Regular", size: 28))
                                .foregroundStyle(Color("brown"))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: isEvenRow ? .trailing : .leading)
                }

                Button("التالي") {
                    navigateToWelcome = true
                }
                .font(.custom("Saudi-Regular", size: 20))
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Color("brown"))
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .disabled(!isNameValid)
                .opacity(isNameValid ? 1 : 0.4)
                .padding(.top, 8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color("BackgroundMain"))
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToWelcome) {
            if let selected = selectedName {
                getWelcomeView(for: selected)
            }
        }
    }
    
    @ViewBuilder
    func getWelcomeView(for character: String) -> some View {
        switch character {
        case "نجدي", "نجديه":
            مرحباالوسطى(playerName: playerName)
        case "شرقاوي", "شرقاوية":
            مرحباالشرقيه(playerName: playerName)
        case "جنوبي", "جنوبيه":
            مرحباالجنوبيه(playerName: playerName)
        case "شمالي", "شماليه":
            مرحباالشماليه(playerName: playerName)
        case "غربي", "غربيه":
            مرحباالغربيه(playerName: playerName)
        default:
            مرحباالجنوبيه(playerName: playerName)
        }
    }
}

#Preview {
    NavigationStack {
        CharacterPickerView(playerName: "")
    }
}
