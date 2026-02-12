//
//  الغربيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الغربيه: View {
    @State private var goToCards = false
    var region: RegionType

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
                    .frame(height: 400)
            }
            .position(x: UIScreen.main.bounds.width / 2, y: 160)
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("brown"))
                
                VStack(spacing: 7.5) {
                    ScrollView {
                        Text("""
                        لبس في المنطقة الغربية (الحجاز) معروف بتنوعه وثرائه التراثي.
                        المرأة تبدأ بلبس ثوب الصدرة، وتكمل شكلها بـ المسفع والبرم، وهي قطع معروفة بزخارفها وألوانها اللي تعكس الهوية الحجازية.
                        أما الرجل فيلبس الثوب مع الشالية، ويحط على راسه الطاقية وتجي فوقها العمامة، وهذي عناصر تأثرت بتاريخ المنطقة كمركز للحج والتجارة. ولسّه هاللباس موجود في المناسبات التراثية والاحتفالات الشعبية.
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
            HejazView(region: region)
        }
    }
    
    
    
}
#Preview {
    الغربيه(region: .central)
}
