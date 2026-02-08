//
//  الجنوبيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الجنوبيه: View {
    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // صورتين جنب بعض
            HStack(spacing: 20) {
                Image("جنوبيه")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 360)
                
                Image("جنوبي")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 360)
            }
            .position(x: UIScreen.main.bounds.width / 2, y: 160)
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("brown"))
                
                VStack(spacing: 0) {
                    ScrollView {
                        Text("""
                        لباس المنطقة الجنوبية يتميز بغنى التفاصيل والألوان 
                        المرتبطة بالهوية الجبلية.
                        تبدأ المرأة بارتداء ثوب مجنب، وهو ثوب تقليدي طويل مزخرف بخطوط وتطريزات طولية، وتضع الشيلة المبرشة التي تتميز بزخارفها وألوانها اللافتة، ويُكمل المظهر الحزام والإكسسوارات التراثية التي 
                        تعكس المكانة الاجتماعية.
                        أما الرجل فيرتدي الثوب ويضع العصابة على الرأس، ويحمل اليدّي، وهي عناصر تعبّر عن الطابع التراثي والاعتزاز بالهوية في المنطقة الجنوبية، ولا يزال هذا اللباس حاضرًا في المناسبات الشعبية والاحتفالات التراثية.

                        """)
                        .font(.custom("Saudi-Regular", size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .multilineTextAlignment(.trailing)
                        .lineSpacing(5)
                        .padding(.horizontal, 30)
                        .padding(.top, 70)
                    }
                    .scrollIndicators(.hidden) // لإخفاء الـ scroll bar
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("ابدأ اللعبة")
                            .font(.custom("Saudi-Regular", size: 34))
                            .foregroundColor(Color("brown"))
                            .frame(width: 254, height: 70)
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
    }
}

#Preview {
    الجنوبيه()
}
