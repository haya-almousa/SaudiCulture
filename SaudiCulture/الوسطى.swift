//
//  FashionView.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//


import SwiftUI

// موديل بسيط للبس
struct CentralOutfitLevel {
    let images: [String]      // صورة أو صورتين
    let description: String
}

struct الوسطى: View {
    @State private var startNajdGame = false
    
    var region: RegionType
    
    // ✅ رقم الليفل (قيمة افتراضية عشان ما ينكسر أي استدعاء قديم)
    var levelNumber: Int = 1
    
    // ✅ مستويات اللبس (4 فقط)
    private let levels: [CentralOutfitLevel] = [
        
        // لفل 1 — نجدي
        CentralOutfitLevel(
            images: ["نجدي"],
            description: """
            لباس الرجل – المنطقة الوسطى (نجد)   
            لباس الرجل في المنطقة الوسطى يعتمد على الثوب كلبس أساسي، وهو اللبس اليومي المعروف عند أهل نجد.
            فوق الثوب يلبس الزبون، ويكون مفتوح من قدّام ويعطي شكل رسمي أكثر.
            وفي المناسبات الرسمية أو المهمة يلبس البشت، واللي يرمز للمكانة والوقار.
            أما الرأس، فيغطيه بـ الغترة، وتثبت باستخدام العقال الزري، واللي يعطي شكل مرتب ومميز.
            هاللبس يعكس بساطة أهل نجد واهتمامهم بالهيبة والاحتشام.
            """
        ),
        
        // لفل 2 — نجديه
        CentralOutfitLevel(
            images: ["نجديه"],
            description: """
            لباس المرأة – المنطقة الوسطى (نجد)
            لباس المرأة في المنطقة الوسطى يتكوّن من الثوب، ويكون واسع ومريح للحركة.
            تغطي رأسها بـ الشيلة، واللي تعتبر جزء أساسي من اللبس النجدي.
            اللبس بشكل عام بسيط ومرتب، ويعكس الذوق النجدي المحافظ، بدون تعقيد أو مبالغة، مع المحافظة على الهوية التراثية للمنطقة.
            """
        ),
        
        // لفل 3 — طفل نجدي
        CentralOutfitLevel(
            images: ["طفل نجدي"],
            description: """
            لباس الطفل – المنطقة الوسطى (نجد)                                                       لباس الطفل النجدي يشبه لباس الرجال لكن يناسب عمره.
            يلبس ثوب مردون، واللي يكون عملي ومريح.
            يغطي رأسه بـ الغترة، وتثبت باستخدام العقال.
            اللبس يعطي الطفل مظهر مرتب ويعوّده من صغره على اللباس التراثي لأهل نجد.
            """
        ),
        
        // لفل 4 — طفله نجديه
        CentralOutfitLevel(
            images: ["طفله نجديه"],
            description: """
             لباس الطفلة – المنطقة الوسطى (نجد)                      لباس الطفلة في المنطقة الوسطى يكون بسيط ومناسب لعمرها.
            تلبس مقطع أو دراعة، وهو اللبس الأساسي لها.
            وتضع على رأسها قبع، واللي يكمل اللبس ويعطيه طابع تراثي.
            لبس الطفلة يعكس الهوية النجدية بأسلوب خفيف وناعم يناسب الأطفال.
            """
        )
    ]
    
    var body: some View {
        // ✅ حماية من أي رقم خارج النطاق
        let idx = max(0, min(levelNumber - 1, levels.count - 1))
        let level = levels[idx]
        
        NavigationStack {
            ZStack {
                Color("BackgroundMain")
                    .ignoresSafeArea()
                
                // الصور (حسب الليفل)
                HStack(spacing: 20) {
                    ForEach(level.images, id: \.self) { img in
                        Image(img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 360)
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
                                .multilineTextAlignment(.center)   // ✅ صار بالوسط
                                .lineSpacing(5)
                                .padding(.horizontal, 30)
                                .padding(.top, 70)

                        }
                        .scrollIndicators(.hidden)
                        
                        Spacer()
                        
                        // ✅ نفس ربطك للألعاب — ما تغيّر
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
            
            // ✅ نفس ربطك للألعاب — ما تغيّر
            .navigationDestination(isPresented: $startNajdGame) {
                NajdView(region: region)
            }
        }
    }
}

#Preview {
    // تشتغل بدون levelNumber (يطلع لفل 1)
    الوسطى(region: .central)
    // مثال لمعاينة لفل 2:
    // الوسطى(region: .central, levelNumber: 2)
}
