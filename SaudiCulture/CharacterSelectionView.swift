//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//

import SwiftUI

struct CharacterPickerView: View {
    let playerName: String
    
    @AppStorage("selectedCharacter") private var savedCharacter: String = "نجدية"  // ✅ حفظ الشخصية
    @AppStorage("hasChosenCharacter") private var hasChosenCharacter: Bool = false // ✅ هل اختار فعليًا؟
    
    let characterPairs: [[String]] = [
        ["نجدي", "نجدية"],
        ["شرقاوية", "شرقاوي"],
        ["شمالية", "شمالي"],
        ["جنوبي", "جنوبية"],
        ["غربية", "غربي"],
    ]

    @State private var selectedName: String? = nil
    @State private var navigateToWelcome = false

    private var isNameValid: Bool { selectedName != nil }

    var body: some View {
        ZStack {
            Color("BackgroundMain").ignoresSafeArea()

            VStack(spacing: 16) {
                Text("اضغط على شخصيتك")
                    .font(.custom("Saudi-Bold", size: 32))
                    .foregroundStyle(Color("brown"))
                    .padding(.top, 0)
                    .offset(y: 4)

                // Horizontal, centered, side-by-side characters with horizontal scroll
                VStack {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 5) {
                            // Flatten characterPairs preserving order
                            ForEach(Array(characterPairs.joined()), id: \.self) { name in
                                VStack(spacing: 8) {
                                    // Name above image only when selected
                                    if selectedName == name {
                                        Text(name)
                                            .font(.custom("Saudi-Regular", size: 18))
                                            .foregroundStyle(Color("brown"))
                                    }

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

                                    // Name below image only when NOT selected
                                    if selectedName != name {
                                        Text(name)
                                            .font(.custom("Saudi-Regular", size: 18))
                                            .foregroundStyle(Color("brown"))
                                    }

                                    // Description appears under the image only for the selected character
                                    if selectedName == name {
                                        VStack(spacing: 4) {
                                            if name == "نجدية" {
                                                Text("لباس المرأة – المنطقة الوسطى (نجد)")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتسم بالبساطة والطابع المحافظ.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "شرقاوية" {
                                                Text("لباس المرأة – المنطقة الشرقية")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("معروف بأناقته وتفاصيله التراثية.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "شرقاوي" {
                                                Text("لباس الرجل – المنطقة الشرقية")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتميز بالهيبة والطابع الرسمي.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "شمالية" {
                                                Text("لباس المرأة – المنطقة الشمالية")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("معروف بالاحتشام والطابع التراثي.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "شمالي" {
                                                Text("لباس الرجل – المنطقة الشمالية")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتميز بالبساطة والهيبة.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "جنوبي" {
                                                Text("لباس الرجل – المنطقة الجنوبية")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتميز بالبساطة والطابع التراثي المرتبط بطبيعة المنطقة.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "جنوبية" {
                                                Text("لباس المرأة – المنطقة الجنوبية")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتميز بالأناقة والتفاصيل التراثية.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "غربية" {
                                                Text("لباس المرأة – المنطقة الغربية (الحجاز)")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("معروف بذوقه وبساطته التراثية.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else if name == "غربي" {
                                                Text("لباس الرجل – المنطقة الغربية (الحجاز)")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتميز بالبساطة والهيبة بطابع حجازي.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            } else {
                                                Text("لباس الرجل – المنطقة الوسطى (نجد)")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown"))
                                                Text("يتميز بالبساطة والهيبة.")
                                                    .font(.custom("Saudi-Regular", size: 16))
                                                    .foregroundStyle(Color("brown").opacity(0.9))
                                            }
                                        }
                                        .multilineTextAlignment(.center)
                                    }
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
        case "نجدي", "نجدية":
            مرحباالوسطى(playerName: playerName, selectedCharacter: selectedCharacter)
        case "شرقاوي", "شرقاوية":
            مرحباالشرقيه(playerName: playerName, selectedCharacter: selectedCharacter)
        case "جنوبي", "جنوبية":
            مرحباالجنوبيه(playerName: playerName, selectedCharacter: selectedCharacter)
        case "شمالي", "شمالية":
            مرحباالشماليه(playerName: playerName, selectedCharacter: selectedCharacter)
        case "غربي", "غربية":
            مرحباالغربيه(playerName: playerName, selectedCharacter: selectedCharacter)
        default:
            مرحباالجنوبيه(playerName: playerName, selectedCharacter: selectedCharacter)
        }
    }
}

#Preview {
        CharacterPickerView(playerName: "هيا")
}

