//
//  الشمالبه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الشماليه: View {
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
            images: ["شمالي"],
            description: """
            لباس الرجل – المنطقة الشمالية
            يتميز بالبساطة والهيبة.
            يرتدي ثوب مردون،
            ويضع الغترة المثبتة بـ العقال.
            وفي المناسبات يلبس البشت
            ليمنح الزي طابعًا رسميًا وتراثيًا.
            """
        ),
        OutfitLevel(
            images: ["شماليه"],
            description: """
            لباس المرأة – المنطقة الشمالية
            معروف بالاحتشام والطابع التراثي.
            ترتدي المحوثل كلباس أساسي،
            وتكمل المظهر بـ الشيلة
            ومعها المقرونة كغطاء رأس مميز.
            """
        ),
        OutfitLevel(
            images: ["طفل شمالي"],
            description: """
            لباس الطفل – المنطقة الشمالية
            يشبه زي الرجال بأسلوب أبسط.
            يرتدي ثوب مردون،
            ويضع الغترة المثبتة بـ العقال،
            وفي المناسبات يلبس البشت.
            """
        ),
        OutfitLevel(
            images: ["طفله شماليه"],
            description: """
            لباس الطفلة – المنطقة الشمالية
            يجمع بين البساطة والهوية التراثية.
            ترتدي الدراعة المناسبة لعمرها،
            وتكمل مظهرها بـ البخنق
            ليعكس الطابع الشمالي المعروف.
            """
        ),
        OutfitLevel(
            images: ["عائلة شمالية"], // صورة تجمع الأربع شخصيات
            description: """
            الزي الشمالي – الهوية والمعنى
            لا يُعد الزي التقليدي في المنطقة الشمالية مجرد لباس،
            بل يعكس طبيعة المجتمع واعتزازه بتراثه.

            تتشابه أزياء الرجل والطفل في الأساسيات،
            بينما تتميز أزياء المرأة والطفلة
            بغطاء الرأس والعناصر الخاصة بهن.

            يعبر ثوب المردون والبشت والمحوثل
            عن الطابع التراثي المعروف لأهل الشمال.

            يستمر ارتداء هذا الزي في المناسبات الوطنية
            والفعاليات التراثية تأكيدًا على الانتماء والهوية.
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
                            Image("شمالي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)

                            Image("شماليه")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 290)
                        }
                        .offset(y: 130)

                        // الصف الأمامي
                        HStack(spacing: -29) {
                            Image("طفل شمالي")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 320)

                            Image("طفله شماليه")
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
                                        (img == "طفل شمالي" || img == "طفله شماليه")
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
            NorthView(region: region)
        }
    }
}

#Preview {
    NavigationStack {
        الشماليه(region: .northern, levelNumber: 5)
    }
}
