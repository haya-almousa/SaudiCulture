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
            يتميز بالبساطة والهيبة بطابع حجازي.
            يرتدي الثوب كلباس أساسي،
            ويضع الغترة المثبتة بـ العقال.
            وفي المناسبات يلبس البشت
            ليمنح الزي مظهرًا رسميًا وتراثيًا.
            """
        ),
        OutfitLevel(
            images: ["غربيه"],
            description: """
            لباس المرأة – المنطقة الغربية (الحجاز)
            معروف بذوقه وبساطته التراثية.
            ترتدي ثوب مبقر كلباس أساسي،
            وتكمل المظهر بـ الشيلة
            ليعكس الطابع الحجازي المحتشم.
            """
        ),
        OutfitLevel(
            images: ["طفل غربي"],
            description: """
            لباس الطفل – المنطقة الغربية (الحجاز)
            يحافظ على الطابع التراثي بأسلوب يناسب عمره.
            يرتدي الثوب،
            ويضع الطاقية تعلوها العمامة،
            وتكون الشاية جزءًا من المظهر التقليدي.
            """
        ),
        OutfitLevel(
            images: ["طفله غربيه"],
            description: """
            لباس الطفلة – المنطقة الغربية (الحجاز)
            يتميز بالطابع التراثي المرتب.
            ترتدي ثوب الصدرة،
            وتكمل مظهرها بـ المسفع والبرم
            لتعكس الهوية الحجازية المعروفة.
            """
        ),
        OutfitLevel(
            images: ["عائلة غربية"], // صورة تجمع الرجل والمرأة والطفل والطفلة
            description: """
            الزي الحجازي – الهوية والمعنى
            لا يُعد الزي التقليدي في المنطقة الغربية مجرد لباس،
            بل يعكس تاريخ الحجاز وثقافته العريقة.

            تتشابه أزياء الرجل والطفل في الأساسيات،
            بينما تتميز أزياء المرأة والطفلة
            بتفاصيل غطاء الرأس والعناصر الزخرفية.

            يعبر ثوب المبقر والصدرة والعمامة
            عن الطابع الحجازي المعروف في المنطقة.

            يستمر ارتداء هذا الزي في المناسبات الوطنية
            والاحتفالات التراثية تأكيدًا على الاعتزاز بالهوية.
            """
        )
    ]
    
    var body: some View {
        let idx = max(0, min(levelNumber - 1, levels.count - 1))
        let level = levels[idx]
        
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()

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

            // ✅ الصور
            Group {
                if levelNumber == 5 {

                    VStack(spacing: 5) {

                        // الصف الخلفي
                        HStack(spacing: -15) {
                            Image("غربي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)

                            Image("غربيه")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 290)
                        }
                        .offset(y: 130)

                        // الصف الأمامي
                        HStack(spacing: -29) {
                            Image("طفل غربي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 320)

                            Image("طفله غربيه")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 310)
                        }
                        .offset(y: -100)
                    }

                } else {

                    HStack(spacing: 20) {
                        ForEach(level.images, id: \.self) { img in
                            Image(img)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    height:
                                        (img == "طفل غربي" || img == "طفله غربيه")
                                        ? 360
                                        : 360
                                )
                        }
                    }
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
        الغربيه(region: .western, levelNumber: 5)
    }
}
