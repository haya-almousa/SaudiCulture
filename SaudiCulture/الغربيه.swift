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
            HStack(spacing: 1) {
                Image("غربيه")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 590)
                
                Image("غربي")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 450)
            }
            .position(x: UIScreen.main.bounds.width / 2, y: 160)
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("brown"))
                
                VStack(spacing: 0) {
                    ScrollView {
                        Text("""
                        اللباس يُعد من لباس المنطقة الغربية (الحجاز) يتميز 
                        بتنوعه وثرائه التراثي. 
                        تبدأ المرأة بارتداء ثوب الصدرة، وتُكمل مظهرها بـ المسفع والبرم، وهي قطع معروفة بزخارفها وألوانها التي تعكس الهوية الحجازية. 
                        أما الرجل فيرتدي الثوب مع الشالية، ويضع على رأسه الطاقية وتعلوها العمامة، وهي عناصر تأثرت بتاريخ المنطقة كمركز للحج والتجارة. ولا يزال هذا اللباس حاضرًا في المناسبات التراثية والاحتفالات الشعبية.
                        """)
                        .font(.custom("Saudi-Regular", size: 20))
                        .fontWeight(.bold)                 // بولد
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)   // توسيط
                        .lineSpacing(5)
                        .padding(.horizontal, 30)
                        .padding(.top, 70)
                    }
                    .scrollIndicators(.hidden)
                    
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
