//
//  الغربيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الغربيه: View {
    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // صورتين جنب بعض
            HStack(spacing: 20) {
                Image("غربيه")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 360)
                
                Image("غربي")
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
                        اللباس يُعد من لباس المنطقة الوسطى (نجد) في المملكة العربية السعودية. 
                        يتميز هذا اللباس بالاحتشام والبساطة مع إبراز الهوية من خلال التفاصيل؛
                        فالمرأة ترتدي الدراعة النجدية الواسعة ذات التطريز الملون حول الصدر، وغالبًا تُلبس معها عباءة داكنة، بينما يرتدي الرجل الثوب مع البشت الأسود أو البني المطرز بالزري، إضافة إلى الغترة والعقال. هذا اللباس يعكس طبيعة المجتمع النجدي والبيئة الصحراوية، ولا يزال حاضرًا في المناسبات الاجتماعية والوطنية.
                        """)
                        .font(.custom("Saudi-Regular", size: 20))
                        .foregroundColor(.white)
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
    الغربيه()
}
