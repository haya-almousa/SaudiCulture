//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//

import SwiftUI

struct CharacterPickerView: View {

    let characterPairs: [[String]] = [
        ["نجدي", "نجديه"],
        ["جنوبي", "جنوبيه"],
        ["شماليه", "شمالي"],
        ["شرقاوية", "شرقاوي"],
        ["غربيه", "غربي"],

        


    ]

    @State private var selectedName: String? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                let rowCount: Int = characterPairs.count
                ForEach(0..<rowCount, id: \.self) { rowIndex in
                    let pair: [String] = characterPairs[rowIndex]

                    HStack {
                        if rowIndex % 2 == 0 { Spacer() }

                        HStack(spacing: 0) {
                            ForEach(pair, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 200)
                                    .opacity(selectedName == nil ? 0.4 : (selectedName == name ? 1.0 : 0.4))
                                    .animation(.easeInOut(duration: 0.2), value: selectedName)
                                    .onTapGesture {
                                        selectedName = name
                                    }
                            }
                        }

                        if rowIndex % 2 != 0 { Spacer() }
                    }
                }

                if let _ = selectedName {
                    Button(action: {
                        // TODO: Handle next action, e.g., navigate or confirm selection
                    }) {
                        Text("التالي")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.top, 8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CharacterPickerView()
}
