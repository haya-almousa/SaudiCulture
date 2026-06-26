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
                        .padding(.top, isIPad ? 20 : -1)

                        Spacer()
                    }
                    Spacer()
                }
                .zIndex(1)

                Group {
                    if levelNumber == 5 {
                        VStack(spacing: isIPad ? 5 : -10) {
                            HStack(spacing: isIPad ? -15 : -20) {
                                Image("جنوبي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 300 : 185)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)

                                Image("جنوبيه")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 290 : 175)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)
                            }
                            .offset(y: isIPad ? 130 : 80)

                            HStack(spacing: isIPad ? -29 : -25) {
                                Image("طفل جنوبي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 320 : 190)
                                    .scaleEffect(isIPad ? 1.12 : 1.2)

                                Image("طفله جنوبيه")
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
            AsirView(region: region, levelNumber: levelNumber)
        }
    }

    private func imageHeight(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return (img == "طفل جنوبي" || img == "طفله جنوبيه") ? 380 : 320
        } else {
            return (img == "طفل جنوبي" || img == "طفله جنوبيه") ? 255 : 230
        }
    }

    private func imageScale(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return 1.12
        } else {
            if img == "جنوبي" {
                return 1.5
            } else if img == "جنوبيه" {
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
            if img == "جنوبي" {
                return -15
            } else {
                return 0
            }
        }
    }
}

#Preview {
    NavigationStack {
        الجنوبيه(region: .southern, levelNumber: 5)
    }
}
