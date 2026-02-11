//
//  الجنوبيه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الجنوبيه: View {
    @State private var goToCards = false
    
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
                
                VStack(spacing: 7.5) {
                    ScrollView {
                        Text("""
                        لبس المنطقة الجنوبية يتميّز بغنى التفاصيل والألوان المرتبطة بالهوية الجبلية.
                        المرأة تبدأ بلبس ثوب مجنب، وهو ثوب تقليدي طويل مزخرف بخطوط وتطريزات طولية، وتحط الشيلة المبرشة اللي تتميّز بزخارفها وألوانها اللافتة، ويكمّل المظهر الحزام والإكسسوارات التراثية اللي تعكس المكانة الاجتماعية.
                        أما الرجل فيلبس الثوب ويحط العصابة على راسه، ويحمل اليدّي، وهذي عناصر تعبّر عن الطابع التراثي والاعتزاز بالهوية في المنطقة الجنوبية، ولسّه هاللباس موجود في المناسبات الشعبية والاحتفالات التراثية.
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
            AsirView()
        }
    }
}

#Preview {
    الجنوبيه()
}
