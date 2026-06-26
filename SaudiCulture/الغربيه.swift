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
            images: ["عائلة غربية"],
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
        
        GeometryReader { geo in
            let screenW = geo.size.width
            let screenH = geo.size.height
            let isIPad = screenW >= 700

            let boxWidth: CGFloat = isIPad ? 820 : min(screenW * 1, 801)
            let boxHeight: CGFloat = isIPad ? 760 : 480

            let boxY: CGFloat = isIPad ? screenH * 0.72 : screenH * 0.74
            let imageY: CGFloat = isIPad ? 220 : 170


            ZStack {
                Color("BackgroundMain")
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: isIPad ? 30 : 25, weight: .bold))
                                .foregroundColor(.white)
                                .padding(isIPad ? 16 : 12)
                                .background(Color("brown"))
                                .clipShape(Circle())
                        }
                        .padding(.leading, isIPad ? 35 : 20)
                        .padding(.top, isIPad ? 20 : -15)

                        Spacer()
                    }
                    Spacer()
                }
                .zIndex(1)

                Group {
                    if levelNumber == 5 {
                        VStack(spacing: isIPad ? 5 : -10) {
                            HStack(spacing: isIPad ? -15 : -20) {
                                Image("غربي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 300 : 185)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)

                                Image("غربيه")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 290 : 175)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)
                            }
                            .offset(y: isIPad ? 130 : 80)

                            HStack(spacing: isIPad ? -29 : -25) {
                                Image("طفل غربي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 320 : 190)
                                    .scaleEffect(isIPad ? 1.12 : 1.2)

                                Image("طفله غربيه")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 310 : 185)
                                    .scaleEffect(isIPad ? 1.12 : 1.2)
                            }
                            .offset(y: isIPad ? -103 : 4)
                        }
                    } else {
                        HStack(spacing: 20) {
                            ForEach(level.images, id: \.self) { img in
                                Image(img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: imageHeight(for: img, isIPad: isIPad))
                                    .scaleEffect(imageScale(for: img, isIPad: isIPad))
                                    .offset(y: imageOffsetY(for: img, isIPad: isIPad))
                            }
                        }
                    }
                }
                .position(x: screenW / 2, y: imageY)

                ZStack {
                    RoundedRectangle(cornerRadius: isIPad ? 50 : 42)
                        .fill(Color("brown"))
                    
                    VStack(spacing: 7.5) {
                        ScrollView {
                            Text(level.description)
                                .font(.custom("Saudi-Regular", size: isIPad ? 29 : 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .lineSpacing(isIPad ? 7 : 7)
                                .padding(.horizontal, isIPad ? 39 : 24)
                                .padding(.top, isIPad ? 50 : 40)
                                .padding(.bottom, 10)
                        }
                        .scrollIndicators(.hidden)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            goToCards = true
                        } label: {
                            Text("ابدأ اللعبة")
                                .font(.custom("Saudi-Regular", size: isIPad ? 34 : 25))
                                .foregroundColor(Color("brown"))
                                .frame(width: isIPad ? 240 : 190, height: isIPad ? 60 : 50)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        .padding(.bottom, isIPad ? 105 : 38)
                    }
                }
                .frame(width: boxWidth, height: boxHeight)
                .position(x: screenW / 2, y: boxY)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToCards) {
            HejazView(region: region, levelNumber: levelNumber)
        }
    }

    private func imageHeight(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return (img == "طفل غربي" || img == "طفله غربيه") ? 380 : 320
        } else {
            return (img == "طفل غربي" || img == "طفله غربيه") ? 255 : 230
        }
    }

    private func imageScale(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return 1.12
        } else {
            if img == "غربي" {
                return 1.7
            } else if img == "غربيه" {
                return 1.6
            } else {
                return 1.7
            }
        }
    }

    private func imageOffsetY(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return 0
        } else {
            if img == "غربي" {
                return -15
            } else {
                return 0
            }
        }
    }
}

#Preview {
    NavigationStack {
        الغربيه(region: .western, levelNumber: 5)
    }
}
