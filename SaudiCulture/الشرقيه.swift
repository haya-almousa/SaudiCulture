//
//  الشرقيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الشرقيه: View {
    @State private var goToCards = false
    
    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // صورتين جنب بعض
            HStack(spacing: 0) {
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
                
                VStack(spacing: 7.5) {
                    ScrollView {
                        Text("""
                        لبس المنطقة الشرقية يتميزلباس المنطقة الشرقية معروف بالأناقة وغنى التفاصيل التراثية.
                        المرأة تبدأ بلبس ثوب النشل، وهو ثوب تقليدي معروف بتطريزه الذهبي وقماشه الخفيف، وغالبًا ينلبس في المناسبات والاحتفالات، وتكمل شكلها بـ الدراعة اللي تنلبس فوقه عشان تعكس الاحتشام والهوية المحلية.
                        أما الرجل فيلبس ثوب مردون، ويحط الغترة مع العقال المقصب، ويكمل لبسه بـ الدقلة، وكلها تفاصيل تعبّر عن الطابع التراثي والمكانة الاجتماعية في المنطقة الشرق
                        """)
                        .font(.custom("Saudi-Regular", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .multilineTextAlignment(.trailing)
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
            EasternView()
        }
    }
}

#Preview {
    الشرقيه()
}
