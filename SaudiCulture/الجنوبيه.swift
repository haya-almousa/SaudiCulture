//
//  الجنوبيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

// موديل بسيط للبس (نفس الوسطى)
struct SouthernOutfitLevel {
    let images: [String]
    let description: String
}

struct الجنوبيه: View {
    @State private var goToCards = false
    
    var region: RegionType
    
    // ✅ رقم الليفل (قيمة افتراضية عشان ما ينكسر أي ربط قديم)
    var levelNumber: Int = 1

    // ✅ مستويات الجنوب (4)
    private let levels: [SouthernOutfitLevel] = [
        
//         لفل 1 — جنوبي
        SouthernOutfitLevel(
            images: ["جنوبي"],
            description: """
            لباس الرجل – المنطقة الجنوبية
            لباس الرجل في المنطقة الجنوبية يتميز بطابعه التراثي المرتبط بطبيعة المنطقة.
            يرتدي الرجل الثوب كلباس أساسي، ويكمل مظهره بـ البيدي الذي يعطي الزي طابعًا مميزًا وشكلًا مرتبًا.
            وعلى الرأس يضع العصابة، وهي من العناصر المعروفة في الزي الجنوبي، وتعكس الهوية التراثية للمنطقة.
            هذا اللباس يبرز الاعتزاز بالعادات والتقاليد الجنوبية، ويظهر غالبًا في المناسبات والفعاليات التراثية.
            """
        ),
        
        // لفل 2 — جنوبيه
        SouthernOutfitLevel(
            images: ["جنوبيه"],
            description: """
            لباس المرأة – المنطقة الجنوبية
            لباس المرأة في المنطقة الجنوبية معروف بأناقته وتفاصيله التراثية.
            تبدأ بلبس ثوب مجنب، وهو ثوب طويل يعطي مظهرًا مرتبًا ويعكس الطابع الجنوبي الأصيل.
            وتكمل اللباس بـ الشيلة المريشة التي تغطي الرأس وتضيف لمسة تراثية مميزة.
            هذا الزي يعبر عن هوية المرأة الجنوبية ويظهر في المناسبات الشعبية والاحتفالات التراثية.
            """
        ),
        
        // لفل 3 — طفل جنوبي
        SouthernOutfitLevel(
            images: ["طفل جنوبي"],
            description: """
            لباس الطفل – المنطقة الجنوبية
            لباس الطفل في المنطقة الجنوبية يكون بسيطًا ومناسبًا لعمره، مع المحافظة على الطابع التراثي.
            يرتدي الطفل قميصًا يعطيه مظهرًا مرتبًا، ويكمل اللباس بـ المصنف الذي يضيف لمسة تقليدية واضحة.
            ويكون الجزء السفلي هو الإزار، ليكتمل شكل الزي الجنوبي.
            هذا اللباس يربط الطفل بالتراث منذ الصغر بأسلوب عملي ومريح.
            """
        ),
        
        // لفل 4 — طفله جنوبيه
        SouthernOutfitLevel(
            images: ["طفله جنوبيه"],
            description: """
            لباس الطفلة – المنطقة الجنوبية
            لباس الطفلة في المنطقة الجنوبية يتميز بالأناقة والبساطة مع وضوح الهوية التراثية.
            تعتمد الطفلة على ثوب مكلف كلباس أساسي، ويكون مناسبًا للمناسبات التراثية.
            وتكمل مظهرها بـ الطقشة، التي تضيف طابعًا جنوبيًا واضحًا للزي.
            هذا اللباس يعكس التراث الجنوبي بأسلوب ناعم يناسب عمر الطفلة.
            """
        )
    ]
    // حجم الصورة حسب الليفل
//    var imageHeight: CGFloat {
//        switch levelNumber {
//        case 3, 4:   // طفل / طفله
//            return 420   // 👈 أكبر
//        default:      // جنوبي / جنوبيه
//            return 360   // 👈 الحجم الحالي
//        }
//    }

    var body: some View {
        // ✅ حماية من أي رقم خارج النطاق
        let idx = max(0, min(levelNumber - 1, levels.count - 1))
        let level = levels[idx]

        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // الصور (حسب الليفل)
            HStack(spacing: 20) {
                ForEach(level.images, id: \.self) { img in
                    Image(img)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: (img == "طفل جنوبي" || img == "طفله جنوبيه")
                            ? 480    // 👈 حجم الطفل/الطفلة
                            : 360    // 👈 باقي الصور
                        )
                
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
                    
                    // ✅ نفس ربطك — ما تغيّر
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
        
        // ✅ نفس الربط للألعاب
        .navigationDestination(isPresented: $goToCards) {
            AsirView(region: region)
        }
    }
}

#Preview {
    // افتراضي يطلع لفل 1 (جنوبي)
    الجنوبيه(region: .southern)
    
    // لمعاينة لفل معين:
    // الجنوبيه(region: .southern, levelNumber: 3)
}
