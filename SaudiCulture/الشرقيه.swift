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
            images: ["عائلة شرقاوية"], // صورة تجمع الرجل والمرأة والطفل والطفلة
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
                            Image("شرقاوي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)

                            Image("شرقاوية")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 290)
                        }
                        .offset(y: 130)

                        // الصف الأمامي (الطفل + الطفلة)
                        HStack(spacing: -29) {
                            Image("طفل شرقاوي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 320)

                            Image("طفله شرقاويه")
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
                                        (img == "طفل شرقاوي" || img == "طفله شرقاويه")
                                        ? 480
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
            EasternView(region: region)
        }
    }
}

#Preview {
    NavigationStack {
        الشرقيه(region: .eastern, levelNumber: 5)
    }
}
