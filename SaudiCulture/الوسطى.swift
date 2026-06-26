//
//  FashionView.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

//
//  FashionView.swift
//  SaudiCulture
//

import SwiftUI

struct CentralOutfitLevel {
    let images: [String]
    let description: String
}

struct الوسطى: View {
    @State private var startNajdGame = false
    @Environment(\.dismiss) var dismiss

    var region: RegionType
    var levelNumber: Int = 1

    private let levels: [CentralOutfitLevel] = [
        CentralOutfitLevel(
            images: ["نجدي"],
            description: """
            لباس الرجل – المنطقة الوسطى (نجد)
            يتميز بالبساطة والهيبة.
            يرتدي الثوب كلباس أساسي،
            ويعلوه الزبون لزيادة الرسمية.
            وفي المناسبات يلبس البشت.
            ويغطي رأسه بـ الغترة المثبتة بـ العقال الزري.
            """
        ),
        CentralOutfitLevel(
            images: ["نجديه"],
            description: """
            لباس المرأة – المنطقة الوسطى (نجد)
            يتسم بالبساطة والطابع المحافظ.
            ترتدي الثوب الواسع،
            وتغطي رأسها بـ الشيلة
            ليعكس الهوية النجدية المعروفة.
            """
        ),
        CentralOutfitLevel(
            images: ["طفل نجدي"],
            description: """
            لباس الطفل – المنطقة الوسطى (نجد)
            يشبه زي الرجال بأسلوب يناسب عمره.
            يرتدي ثوب مردون،
            فوقه الجوخة
            ويضع الغترة المثبتة بـ العقال
            وتحتها طاقية زري 
            ليظهر بالطابع النجدي التقليدي.
            """
        ),
        CentralOutfitLevel(
            images: ["طفله نجديه"],
            description: """
            لباس الطفلة – المنطقة الوسطى (نجد)
            يتميز بالبساطة والهوية التراثية.
            ترتدي مقطع أو دراعة،
            وتضع القبع على الرأس
            ليكتمل المظهر النجدي التقليدي.
            """
        ),
        CentralOutfitLevel(
            images: ["عائلة نجديه"],
            description: """
            الزي النجدي – الهوية والمعنى
            لا يُعد الزي التقليدي في نجد مجرد لباس،
            بل يعكس بساطة المجتمع واعتزازه بتاريخه.

            تتشابه أزياء الرجل والطفل في الأساسيات،
            بينما تتميز أزياء المرأة والطفلة
            بغطاء الرأس والتفاصيل الخاصة بهن.

            يعبر الثوب والزبون والبشت
            عن الطابع النجدي المعروف.

            يستمر ارتداء هذا الزي في المناسبات الوطنية
            والفعاليات التراثية تأكيدًا على الهوية والانتماء.
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
            let imageY: CGFloat = isIPad ? 220 : 190

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
                                Image("نجدي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 300 : 185)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)

                                Image("نجديه")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 290 : 175)
                                    .scaleEffect(isIPad ? 1.15 : 1.25)
                            }
                            .offset(y: isIPad ? 130 : 80)

                            HStack(spacing: isIPad ? -29 : -25) {
                                Image("طفل نجدي")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: isIPad ? 320 : 190)
                                    .scaleEffect(isIPad ? 1.12 : 1.2)

                                Image("طفله نجديه")
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
                            startNajdGame = true
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
        .navigationDestination(isPresented: $startNajdGame) {
            NajdView(region: region, levelNumber: levelNumber)
        }
    }

    private func imageHeight(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return (img == "طفل نجدي" || img == "طفله نجديه") ? 380 : 320
        } else {
            return (img == "طفل نجدي" || img == "طفله نجديه") ? 255 : 230
        }
    }

    private func imageScale(for img: String, isIPad: Bool) -> CGFloat {
        if isIPad {
            return 1.12
        } else {
            if img == "نجدي" {
                return 1.5
            } else if img == "نجديه" {
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
            if img == "نجدي" {
                return -15
            } else {
                return 0
            }
        }
    }
}

#Preview {
    NavigationStack {
        الوسطى(region: .central, levelNumber: 5)
    }
}
