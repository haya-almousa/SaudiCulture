//
//  FashionView.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
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
            ويضع الغترة المثبتة بـ العقال
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
            images: ["عائلة نجديه"], // صورة تجمع الأربع شخصيات
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
                        // الصف الخلفي (الرجل + المرأة)
                        HStack(spacing: -15) {
                            Image("نجدي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)

                            Image("نجديه")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 290)
                        }
                        .offset(y: 130)

                        // الصف الأمامي (الطفل + الطفلة)
                        HStack(spacing: -29) {
                            Image("طفل نجدي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 320)

                            Image("طفله نجديه")
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
                                    height: (img == "طفل نجدي" || img == "طفله نجديه") ? 380 : 320
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
                        startNajdGame = true
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
        .navigationDestination(isPresented: $startNajdGame) {
            NajdView(region: region)
        }
    }
}

#Preview {
    NavigationStack {
        الوسطى(region: .central, levelNumber: 4)
    }
}
