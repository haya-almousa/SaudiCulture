//
//  الشرقيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct EasternOutfitLevel {
    let images: [String]
    let description: String
}

struct الشرقيه: View {
    @State private var goToCards = false
    @Environment(\.dismiss) var dismiss

    var region: RegionType
    var levelNumber: Int = 1

    private let levels: [EasternOutfitLevel] = [
        EasternOutfitLevel(
            images: ["شرقاوي"],
            description: """
            لباس الرجل – المنطقة الشرقية
            يتميز بالهيبة والطابع الرسمي.
            يرتدي ثوب مردون، ويضع الغترة
            المثبتة بـ العقال المقصب.
            وفي المناسبات يكمل اللبس بـ الدقلة
            ليعطي مظهرًا أكثر رسمية.
            """
        ),
        EasternOutfitLevel(
            images: ["شرقاوية"],
            description: """
            لباس المرأة – المنطقة الشرقية
            معروف بأناقته وتفاصيله التراثية.
            ترتدي ثوب النشل المطرز،
            وتلبس معه الدراعة
            ليكتمل المظهر التراثي المحتشم.
            """
        ),
        EasternOutfitLevel(
            images: ["طفل شرقاوي"],
            description: """
            لباس الطفل – المنطقة الشرقية
            يحافظ على الطابع الشعبي بأسلوب أبسط.
            يرتدي الثوب كقطعة أساسية،
            وفوقه الصدرية،
            ويضع الغترة المثبتة بـ العقال.
            """
        ),
        EasternOutfitLevel(
            images: ["طفله شرقاويه"],
            description: """
            لباس الطفلة – المنطقة الشرقية
            يجمع بين البساطة والهوية التراثية.
            ترتدي الدراعة المناسبة لعمرها،
            وتكمل مظهرها بـ البخنق
            ليعكس الطابع الشرقي المعروف.
            """
        ),
        EasternOutfitLevel(
            images: ["عائلة شرقاوية"],
            description: """
            الزي الشرقي – الهوية والمعنى
            لا يُعد الزي التقليدي في المنطقة الشرقية مجرد لباس،
            بل يعكس مكانة اجتماعية وهوية ثقافية متوارثة عبر الأجيال.

            يختلف زي الرجل والمرأة والأطفال في التفاصيل،
            مع المحافظة على الطابع الرسمي والأناقة المميزة للمنطقة.

            تظهر الدقلة وثوب النشل والبخنق
            كعناصر تعبر عن تراث الشرقية وتاريخها.

            يبقى هذا الزي حاضرًا في المناسبات الوطنية
            والاحتفالات الشعبية تأكيدًا على الاعتزاز بالهوية.
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
            let imageY: CGFloat = isIPad ? 220 : 140
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
                                Image("شرقاوي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 300 : 185)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)

                                Image("شرقاوية")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 290 : 175)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)
                            }
                            .offset(y: isIPad ? 130 : 80)

                            HStack(spacing: isIPad ? -29 : -25) {
                                Image("طفل شرقاوي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 320 : 190)
                                    .scaleEffect(isIPad ? 1.12 : 1.2)

                                Image("طفله شرقاويه")
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
            EasternView(region: region, levelNumber: levelNumber)
        }
    }

    private func imageHeight(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return (img == "طفل شرقاوي" || img == "طفله شرقاويه") ? 380 : 320
        } else {
            return (img == "طفل شرقاوي" || img == "طفله شرقاويه") ? 255 : 230
        }
    }

    private func imageScale(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return 1.12
        } else {
            if img == "شرقاوي" {
                return 1.7
            } else if img == "شرقاوية" {
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
            if img == "شرقاوي" {
                return -15
            } else {
                return 0
            }
        }
    }
}

#Preview {
    NavigationStack {
        الشرقيه(region: .eastern, levelNumber: 1)
    }
}
