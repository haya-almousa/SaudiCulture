//
//  الغربيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الغربيه: View {
    @State private var goToCards = false
    var region: RegionType
    
    // ✅ رقم الليفل (قيمة افتراضية عشان ما ينكسر أي استدعاء قديم)
    var levelNumber: Int = 1
    
    // موديل بسيط داخلي
    struct OutfitLevel {
        let images: [String]
        let description: String
    }
    
    // ✅ مستويات المنطقة الغربية (4)
    private let levels: [OutfitLevel] = [
        
        // لفل 1 — غربي
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
        
        // لفل 2 — غربيه
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
        
        // لفل 3 — طفل غربي
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
        
        // لفل 4 — طفله غربيه
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
            
            // ✅ الصور حسب الليفل
            HStack(spacing: 1) {
                ForEach(level.images, id: \.self) { img in
                    let clean = img.trimmingCharacters(in: .whitespacesAndNewlines)
                    let isChild = clean.contains("طفل") || clean.contains("طفله")
                    
                    Image(clean)
                        .resizable()
                        .scaledToFit()
                        // 👇 حافظت على منطق اختلاف الأحجام عندك، وكبرت الطفل/الطفلة
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
                    
                    // ✅ نفس الربط — ما تغيّر
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
        
        // ✅ نفس وجهة الربط — ما تغيّر
        .navigationDestination(isPresented: $goToCards) {
            HejazView(region: region)
        }
    }
}

#Preview {
//    الغربيه(region: .central)
    // لمعاينة لفل معين:
     الغربيه(region: .central, levelNumber: 4)
}
