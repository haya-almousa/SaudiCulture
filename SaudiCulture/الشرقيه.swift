//
//  الشرقيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الشرقيه: View {
    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // صورتين جنب بعض
            HStack(spacing: 1) {
                Image("شرقاوية")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 500)
                
                Image("شرقاوي")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 500)
            }
            .position(x: UIScreen.main.bounds.width / 2, y: 160)
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("brown"))
                
                VStack(spacing: 0) {
                    ScrollView {
                        Text("""
                        لباس المنطقة الشرقية يتميز بالأناقة وغنى التفاصيل التراثية. 
                        تبدأ المرأة بارتداء ثوب النشل، وهو ثوب تقليدي معروف بتطريزه الذهبي وقماشه الخفيف، ويُلبس في المناسبات والاحتفالات، وتُكمل مظهرها بـ الدراعة التي تُلبس فوقه لتعكس الاحتشام والهوية المحلية. 
                        أما الرجل فيرتدي ثوب مردون، ويضع الغترة مع العقال المقصب، ويُكمل لباسه بـ الدقلة، وهو ما يعبر عن الطابع التراثي والمكانة الاجتماعية في المنطقة الشرقية.

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
    الشرقيه()
}
