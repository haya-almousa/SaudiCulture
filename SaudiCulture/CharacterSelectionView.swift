//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//

import SwiftUI

// 1. الموديل: كل شخصية منفصلة تماماً
struct CharacterItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

// 2. تنظيم البيانات في أزواج (كل زوج يمثل سطر)
struct RegionRow: Identifiable {
    let id = UUID()
    let regionName: String
    let man: CharacterItem
    let woman: CharacterItem
    let isLeading: Bool // تحديد الجهة (يسار أو يمين)
}

struct CharacterSelectionView: View {
    
    // مصفوفة البيانات مرتبة حسب طلبك
    let regions = [
        RegionRow(regionName: "الوسطى", man: .init(name: "نجدي", imageName: "نجدي"), woman: .init(name: "نجدية", imageName: "نجدية"), isLeading: true),
        RegionRow(regionName: "الشرقية", man: .init(name: "شرقاوي", imageName: "شرقاوي"), woman: .init(name: "شرقية", imageName: "شرقية"), isLeading: false),
        RegionRow(regionName: "الغربية", man: .init(name: "غربي", imageName: "غربي"), woman: .init(name: "غربية", imageName: "غربية"), isLeading: true),
        RegionRow(regionName: "الشمالية", man: .init(name: "شمالي", imageName: "شمالي"), woman: .init(name: "شمالية", imageName: "شمالية"), isLeading: false),
        RegionRow(regionName: "الجنوبية", man: .init(name: "جنوبي", imageName: "جنوبي"), woman: .init(name: "جنوبية", imageName: "جنوبية"), isLeading: true)
    ]
    
    // لتخزين الـ ID الخاص بالشخصية المختارة فقط
    @State private var selectedCharacterID: UUID? = nil
    
    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.97, blue: 0.95).ignoresSafeArea()
            
            VStack {
                Text("اضغط على شخصيتك")
                    .font(.custom("Traditional Arabic", size: 35))
                    .padding(.top, 40)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 40) {
                        ForEach(regions) { row in
                            HStack(spacing: 20) {
                                if !row.isLeading { Spacer() }
                                
                                // عرض الرجل والمرأة بجانب بعض في نفس السطر
                                characterView(for: row.man)
                                characterView(for: row.woman)
                                
                                if row.isLeading { Spacer() }
                            }
                            .padding(.horizontal, 25)
                        }
                    }
                    .padding(.vertical, 20)
                }
                
                // زر التأكيد: يظهر فقط عند اختيار شخصية
                if selectedCharacterID != nil {
                    Button(action: {
                        print("تم التأكيد")
                    }) {
                        Text("تأكيد")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.brown)
                            .cornerRadius(15)
                            .padding()
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
    
    // مكون الصورة المنفصلة مع منطق الشفافية
    @ViewBuilder
    private func characterView(for character: CharacterItem) -> some View {
        VStack {
            Image(character.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                // المنطق: إذا كانت مختارة وضوح كامل، غير ذلك شفافة
                .opacity(selectedCharacterID == character.id ? 1.0 : 0.3)
                .scaleEffect(selectedCharacterID == character.id ? 1.1 : 1.0)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        selectedCharacterID = character.id
                    }
                }
        }
    }
}
#Preview {
    CharacterSelectionView()
}
