//
//  الجنوبيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct SouthernOutfitLevel {
    let images: [String]
    let description: String
}

struct الجنوبيه: View {
    
    @State private var goToCards = false
    @Environment(\.dismiss) var dismiss

    var region: RegionType
    var levelNumber: Int = 1

    private let levels: [SouthernOutfitLevel] = [
        SouthernOutfitLevel(
            images: ["جنوبي"],
            description: """
            لباس الرجل – المنطقة الجنوبية
            يتميز بالبساطة والطابع التراثي المرتبط بطبيعة المنطقة.
            يرتدي الرجل الثوب كلباس أساسي، ويكمله بـ البيدي،
            وعلى الرأس العصابة التي تعكس الهوية الجنوبية.
            يظهر هذا الزي في المناسبات والفعاليات التراثية.
            """
        ),
        SouthernOutfitLevel(
            images: ["جنوبيه"],
            description: """
            لباس المرأة – المنطقة الجنوبية
            يتميز بالأناقة والتفاصيل التراثية.
            ترتدي ثوب مجنب، وتكمله بـ الشيلة المريشة
            التي تضيف لمسة جنوبية مميزة.
            يُلبس هذا الزي في الاحتفالات والمناسبات الشعبية.
            """
        ),
        SouthernOutfitLevel(
            images: ["طفل جنوبي"],
            description: """
            لباس الطفل – المنطقة الجنوبية
            زي بسيط يحافظ على الطابع التراثي.
            يرتدي قميصًا مع المصنف، ويكمله بالإزار
            ليعكس الهوية الجنوبية بأسلوب عملي ومريح.
            يظهر في الأعياد والمناسبات التراثية.
            """
        ),
        SouthernOutfitLevel(
            images: ["طفله جنوبيه"],
            description: """
            لباس الطفلة – المنطقة الجنوبية
            يجمع بين البساطة والهوية التراثية.
            ترتدي ثوب مكلف، وتكمله بـ الطقشة
            التي تضيف طابعًا جنوبيًا واضحًا.
            يُلبس في المناسبات والفعاليات التراثية.
            """
        ),
        SouthernOutfitLevel(
            images: ["عائلة جنوبية"],
            description: """
            الزي الجنوبي – الهوية والمعنى
            لا يُعد الزي التقليدي مجرد لباس،
            بل يمثل جزءًا من هوية المنطقة الجنوبية وثقافتها.

            يختلف تصميم زي الرجل والمرأة والأطفال
            ليتناسب مع العمر والدور الاجتماعي،
            مع المحافظة على الطابع التراثي المشترك.

            تعكس الألوان والزخارف طبيعة المنطقة
            وروح المجتمع الجنوبي المعتز بعاداته.

            يبقى هذا الزي حاضرًا في المناسبات الوطنية
            والفعاليات التراثية تأكيدًا على الاعتزاز بالهوية.
            """
        )
    ]

    var body: some View {
        let idx = max(0, min(levelNumber - 1, levels.count - 1))
        let level = levels[idx]

        GeometryReader { geo in
            let screenW = geo.size.width
            let screenH = geo.size.height

            let isIPadSize = screenW >= 700

            let cardWidth: CGFloat = min(screenW, 411)
            let cardHeight: CGFloat = min(screenH * 0.69, 580)

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

                Group {
                    if levelNumber == 5 {
                        VStack(spacing: 5) {
                            HStack(spacing: -15) {
                                Image("جنوبي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)

                                Image("جنوبيه")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 290)
                            }
                            .offset(y: 130)

                            HStack(spacing: -29) {
                                Image("طفل جنوبي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 320)

                                Image("طفله جنوبيه")
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
                                        height: (img == "طفل جنوبي" || img == "طفله جنوبيه") ? 380 : 320
                                    )
                            }
                        }
                    }
                }
                .position(
                    x: screenW / 2,
                    y: isIPadSize ? 160 : 190
                )

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
                                .padding(.top, 50)
                                .padding(.bottom, 10)
                        }
                        .scrollIndicators(.hidden)

                        Spacer(minLength: 0)

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
                        .padding(.bottom, 105)
                    }
                }
                .frame(width: cardWidth, height: cardHeight)
                .position(
                    x: screenW / 2,
                    y: isIPadSize ? screenH * 0.81 : screenH * 0.79
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToCards) {
            AsirView(region: region, levelNumber: levelNumber)
        }
    }
}

#Preview {
    NavigationStack {
        الجنوبيه(region: .southern, levelNumber: 4)
    }
}
