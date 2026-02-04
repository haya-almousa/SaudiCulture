//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//

import SwiftUI

// 1) تعريف المناطق
enum Region: Hashable {
    case central, east, west, south, north
}

// 2) عنصر الشخصية
struct CharacterItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let region: Region
}

struct CharacterSelectionView: View {

    // 3) هذا هو “الطريق” اللي بنمشيه في التنقل (أنظف من booleans)
    @State private var path: [Region] = []

    // 4) اختيار المستخدم
    @State private var selectedID: UUID? = nil

    // ✳️ عدلي أسماء الصور هنا لتطابق Assets عندك
    private let items: [CharacterItem] = [
        .init(title: "نجدي",  imageName: "نجدي",   region: .central),
        .init(title: "نجدية", imageName: "نجديه", region: .central),
    ]

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 24) {

                Text("اضغط على شخصيتك")
                    .font(.custom("Saudi-Regular", size: 34))
                    .foregroundStyle(Color("brown"))
                    .padding(.top, 24)

                HStack(spacing: 24) {
                    ForEach(items) { item in
                        characterCard(item)
                    }
                }
                .padding(.horizontal, 24)

                Button("التالي") {
                    goNext()
                }
                .font(.custom("Saudi-Regular", size: 20))
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Color("brown"))
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .disabled(selectedID == nil)
                .opacity(selectedID == nil ? 0.4 : 1)
                .padding(.bottom, 32)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundMain"))
            .ignoresSafeArea()
            .navigationDestination(for: Region.self) { region in
                switch region {
                case .central:
                    الوسطى()      // ✅ واجهتك الجاهزة
                default:
                    Text("قريبًا") // مؤقت لباقي المناطق
                }
            }
        }
    }

    private func characterCard(_ item: CharacterItem) -> some View {
        let isSelected = (selectedID == item.id)

        return VStack(spacing: 12) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .contentShape(Rectangle())
                .opacity(selectedID == nil ? 1 : (isSelected ? 1 : 0.25))
                .animation(.easeInOut(duration: 0.2), value: selectedID)
                .onTapGesture { selectedID = item.id }

            Text(item.title)
                .font(.custom("Saudi-Regular", size: 22))
                .foregroundStyle(Color("brown"))
        }
        .frame(maxWidth: .infinity)
    }

    private func goNext() {
        guard let selectedID,
              let selected = items.first(where: { $0.id == selectedID }) else { return }

        path.append(selected.region) // ✅ هذا هو التنقل النظيف
    }
}
#Preview {
    CharacterSelectionView()
}
