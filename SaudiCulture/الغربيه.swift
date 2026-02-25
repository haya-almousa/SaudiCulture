//
//  الغربيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الغربيه: View {
    @State private var goToCards = false
    @Environment(\.dismiss) var dismiss

    var region: RegionType
    var levelNumber: Int = 1
    
    struct OutfitLevel {
        let images: [String]
        let description: String
    }
    
    private let levels: [OutfitLevel] = [
        OutfitLevel(
            images: ["غربي"],
            description: """
            لباس الرجل – المنطقة الغربية (الحجاز)
            لباس الرجل في المنطقة الغربية يتميز بالبساطة والهيبة بطابع حجازي معروف.
            يرتدي الرجل الثوب كلباس أساسي، ويضع الغترة على الرأس وتثبت بـ العقال.
            وفي المناسبات يكمل مظهره بـ البشت، ويعطي الزي شكل رسمي وتراثي واضح.
            هذا اللبس يبين كثير في المناسبات والفعاليات التراثية في الحجاز.
            """
        ),
        OutfitLevel(
            images: ["غربيه"],
            description: """
            لباس المرأة – المنطقة الغربية (الحجاز)
            لباس المرأة في المنطقة الغربية معروف بذوقه وبساطته مع لمسة تراثية واضحة.
            تلبس المرأة ثوب مبقر، ويكون هو اللبس الأساسي ويعطي شكل مرتب ومميز.
            وتكمل المظهر بـ الشيلة لتغطية الرأس، وتخلي الزي متناسق ومحتشم.
            هذا اللبس يعكس هوية الحجاز ويظهر غالبًا في المناسبات التراثية.
            """
        ),
        OutfitLevel(
            images: ["طفل غربي"],
            description: """
            لباس الطفل – المنطقة الغربية (الحجاز)
            لباس الطفل في المنطقة الغربية يكون مرتب وبنفس الطابع التراثي لكن يناسب عمره.
            يلبس الطفل الثوب كقطعة أساسية، ويضع الطاقية على الرأس وتجي فوقها العمامة.
            وتكون الشاية جزء من المظهر وتكمل شكل اللبس التراثي المعروف في الحجاز.
            هذا اللبس يظهر كثير في المناسبات والاحتفالات التراثية.
            """
        ),
        OutfitLevel(
            images: ["طفله غربيه"],
            description: """
            لباس الطفلة – المنطقة الغربية (الحجاز)
            لباس الطفلة في المنطقة الغربية يتميز بطابع تراثي واضح ومظهر مرتب.
            تلبس الطفلة ثوب الصدرة كلباس أساسي، ويعطي الزي شكل مميز.
            وتكمل المظهر بـ المسفع والبرم، وتظهر معها تفاصيل تراثية معروفة في الحجاز.
            هذا اللبس يبين غالبًا في المناسبات التراثية ويعكس هوية المنطقة.
            """
        )
    ]
    
    var body: some View {
        let idx = max(0, min(levelNumber - 1, levels.count - 1))
        let level = levels[idx]
        
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()

            // ✅ زر الباك
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color("brown"))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    .padding(.top, -15)
                    Spacer()
                }
                Spacer()
            }
            .zIndex(1)
            
            HStack(spacing: 1) {
                ForEach(level.images, id: \.self) { img in
                    let clean = img.trimmingCharacters(in: .whitespacesAndNewlines)
                    let isChild = clean.contains("طفل") || clean.contains("طفله")
                    
                    Image(clean)
                        .resizable()
                        .scaledToFit()
                        .frame(height: isChild ? 350 : (clean.contains("غربيه") ? 400 : 400))
                        .offset(y: isChild ? -12 : 0)
                }
            }
            .position(x: UIScreen.main.bounds.width / 2, y: 160)
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("brown"))
                
                VStack(spacing: 7.5) {
                    ScrollView {
                        Text(level.description)
                            .font(.custom("Saudi-Regular", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .padding(.horizontal, 30)
                            .padding(.top, 70)
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                    
                    Button {
                        goToCards = true
                    } label: {
                        Text("ابدأ اللعبة")
                            .font(.custom("Saudi-Regular", size: 34))
                            .foregroundColor(Color("brown"))
                            .frame(width: 240, height: 60)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                    .padding(.bottom, 125)
                }
            }
            .frame(width: 411, height: 580)
            .position(
                x: -9 + (411 / 2),
                y: 342 + (529 / 2)
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToCards) {
            HejazView(region: region)
        }
    }
}

#Preview {
    NavigationStack {
        الغربيه(region: .western, levelNumber: 1)
    }
}
