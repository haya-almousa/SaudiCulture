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
            لباس الرجل في المنطقة الشمالية معروف بالبساطة والهيبة، ويعكس طابع أهل الشمال.
            يرتدي الرجل ثوب مردون، ويضع الغترة على الرأس وتثبت بـ العقال.
            وفي المناسبات يكمل مظهره بـ البشت، ويعطي الزي شكل رسمي وتراثي واضح.
            هذا اللبس يبان كثير في المناسبات والفعاليات التراثية في المنطقة.
            """
        ),
        OutfitLevel(
            images: ["شماليه"],
            description: """
            لباس المرأة – المنطقة الشمالية
            لباس المرأة في المنطقة الشمالية يتميز بالاحتشام وبالطابع التراثي المعروف عند أهل الشمال.
            تبدأ بلبس المحوثل، وهو اللبس الأساسي ويكون واسع ومرتب.
            وتكمل المظهر بـ الشيلة لتغطية الرأس، ومعها المقرونة كغطاء رأس معروف في المنطقة.
            هاللبس يعكس هوية المنطقة الشمالية ويظهر غالبًا في المناسبات التراثية.
            """
        ),
        OutfitLevel(
            images: ["طفل شمالي"],
            description: """
            لباس الطفل – المنطقة الشمالية
            لباس الطفل في المنطقة الشمالية يشبه لباس الرجال لكن يناسب عمره بشكل أبسط.
            يلبس الطفل ثوب مردون كقطعة أساسية، ويضع الغترة وتثبت بـ العقال.
            وفي المناسبات يلبس البشت ويعطيه شكل مرتب وتراثي مثل الكبار.
            هذا اللبس يربط الطفل بتراث المنطقة من وهو صغير، خصوصًا في المناسبات الشعبية.
            """
        ),
        OutfitLevel(
            images: ["طفله شماليه"],
            description: """
            لباس الطفلة – المنطقة الشمالية
            لباس الطفلة في المنطقة الشمالية يتميز بالبساطة مع طابع تراثي واضح.
            تلبس الطفلة الدراعة، وتكون مناسبة لعمرها ومريحة للحركة.
            وتكمل المظهر بـ البخنق لتغطية الرأس، ويعطي الزي شكل تراثي معروف للبنات في المنطقة.
            هذا اللبس يبان كثير في المناسبات والاحتفالات التراثية.
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
                        .frame(height: isChild ? 420 : 360)
                        .offset(y: isChild ? -10 : 0)
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
        الشماليه(region: .northern, levelNumber: 1)
    }
}
