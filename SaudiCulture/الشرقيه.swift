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
            لباس الرجل في المنطقة الشرقية يتميز بالهيبة والبساطة مع لمسة رسمية واضحة.
            يرتدي الرجل ثوب مردون، وهو ثوب يعطي شكل فخم ومميز في المناسبات.
            ويضع الغترة على الرأس، وتثبت بـ العقال المقصب اللي يوضح الطابع التراثي المعروف للمنطقة.
            وفي المناسبات يكمل اللبس بـ الدقلة، وتكون فوق اللبس وتعطيه مظهر مرتب وأكثر رسمية.
            هذا الزي معروف في الشرقية ويبان كثير في الاحتفالات والمناسبات الشعبية.
            """
        ),
        EasternOutfitLevel(
            images: ["شرقاوية"],
            description: """
            لباس المرأة – المنطقة الشرقية
            لباس المرأة في المنطقة الشرقية معروف بأناقته وبالتفاصيل اللي تعكس تراث المنطقة.
            تبدأ بلبس ثوب النشل، وهو من الأزياء المشهورة في الشرقية ويكون ملفت بتطريزه.
            وتلبس معه الدراعة، وتكمل فيها المظهر بطابع محتشم ومرتب يناسب اللبس التراثي.
            هذا اللبس يبين عادة في المناسبات والاحتفالات، ويعطي هوية واضحة للزي الشرقي.
            """
        ),
        EasternOutfitLevel(
            images: ["طفل شرقاوي"],
            description: """
            لباس الطفل – المنطقة الشرقية
            لباس الطفل في المنطقة الشرقية يكون مرتب وبنفس الطابع التراثي لكن يناسب عمره.
            يلبس الطفل الثوب كقطعة أساسية، وفوقه يلبس الصدرية اللي تعطيه شكل أجمل وتوضح الزي الشعبي.
            وعلى الرأس يضع الغترة، وتثبت بـ العقال ليكتمل مظهره مثل لبس الكبار لكن بطريقة أبسط.
            هذا الزي يبان كثير في المناسبات الشعبية ويعوّد الطفل على لبس المنطقة من وهو صغير.
            """
        ),
        EasternOutfitLevel(
            images: ["طفله شرقاويه"],
            description: """
            لباس الطفلة – المنطقة الشرقية
            لباس الطفلة في المنطقة الشرقية يجمع بين البساطة والهوية التراثية بشكل واضح.
            تلبس الطفلة الدراعة، وتكون مناسبة لعمرها وتعطيها مظهر مرتب وناعم.
            وتكمل اللبس بـ البخنق على الرأس، وهو جزء معروف في لبس البنات ويعطي الزي شكل تراثي واضح.
            هذا اللبس يظهر غالبًا في المناسبات والفعاليات التراثية ويعكس هوية المنطقة الشرقية.
            """
        )
    ]

    var body: some View {
        let idx = max(0, min(levelNumber - 1, levels.count - 1))
        let level = levels[idx]

        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()

            // ✅ زر الباك
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
            
            HStack(spacing: 0) {
                ForEach(level.images, id: \.self) { img in
                    let clean = img.trimmingCharacters(in: .whitespacesAndNewlines)
                    let isChild = clean.contains("طفل") || clean.contains("طفله")

                    Image(clean)
                        .resizable()
                        .scaledToFit()
                        .frame(height: isChild ? 410 : 410)
                        .offset(y: isChild ? -1 : 0)
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
        الشرقيه(region: .eastern, levelNumber: 1)
    }
}
