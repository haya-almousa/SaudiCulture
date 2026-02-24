//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//

import SwiftUI

struct CharacterPickerView: View {
    let playerName: String
    
    @AppStorage("selectedCharacter") private var savedCharacter: String = "نجديه"  // ✅ حفظ الشخصية
    @AppStorage("hasChosenCharacter") private var hasChosenCharacter: Bool = false // ✅ هل اختار فعليًا؟
    
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
        ZStack {
            Color("BackgroundMain").ignoresSafeArea()

            VStack(spacing: 16) {
                Text("اضغط على شخصيتك")
                    .font(.custom("Saudi-Regular", size: 32))
                    .foregroundStyle(Color("brown"))
                    .padding(.top, 0)
                    .offset(y: 40)

                // Horizontal, centered, side-by-side characters with horizontal scroll
                VStack {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 5) {
                            // Flatten characterPairs preserving order
                            ForEach(Array(characterPairs.joined()), id: \.self) { name in
                                VStack(spacing: 8) {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 240, height: 360)
                                        .opacity(selectedName == nil ? 1.0 : (selectedName == name ? 1.0 : 0.35))
                                        .animation(.easeInOut(duration: 0.2), value: selectedName)
                                        .onTapGesture {
                                            selectedName = name
                                        }
                                        .zIndex(selectedName == name ? 1 : 0)

                                    Text(name)
                                        .font(.custom("Saudi-Regular", size: 18))
                                        .foregroundStyle(Color("brown"))
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedName == name ? Color("brown").opacity(0.08) : .clear)
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .background(Color.clear)
                    .scrollIndicators(.visible)
                }
                .frame(maxHeight: .infinity, alignment: .center)

                Button("التالي") {
                    if let selected = selectedName {
                        savedCharacter = selected
                        hasChosenCharacter = true
                    }
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
                .padding(.bottom, 16)
            }
            .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // ✅ إذا سبق اختار شخصية: لا نعرض الاختيار مره ثانية، وندخله على الترحيب
            if hasChosenCharacter {
                selectedName = savedCharacter
                navigateToWelcome = true
            }
        }
        .navigationDestination(isPresented: $navigateToWelcome) {
            if let selected = selectedName {
                getWelcomeView(for: selected, selectedCharacter: selected)
            }
        }
    }
    
    @ViewBuilder
    func getWelcomeView(for character: String, selectedCharacter: String) -> some View {
        switch character {
        case "نجدي", "نجديه":
            مرحباالوسطى(playerName: playerName, selectedCharacter: selectedCharacter)
        case "شرقاوي", "شرقاوية":
            مرحباالشرقيه(playerName: playerName, selectedCharacter: selectedCharacter)
        case "جنوبي", "جنوبيه":
            مرحباالجنوبيه(playerName: playerName, selectedCharacter: selectedCharacter)
        case "شمالي", "شماليه":
            مرحباالشماليه(playerName: playerName, selectedCharacter: selectedCharacter)
        case "غربي", "غربيه":
            مرحباالغربيه(playerName: playerName, selectedCharacter: selectedCharacter)
        default:
            مرحباالجنوبيه(playerName: playerName, selectedCharacter: selectedCharacter)
        }
    }
}

#Preview {
        CharacterPickerView(playerName: "هيا")
}
