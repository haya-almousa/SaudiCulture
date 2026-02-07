//
//  FashionView.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//


import SwiftUI

struct الوسطى: View {
    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // صورتين جنب بعض
            HStack(spacing: 20) {
                Image("نجديه")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 360)
                
                Image("نجدي")
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
                        اللباس يُعد من لباس المنطقةلباسلباس المنطقة الوسطى (نجد) يتميز بالاحتشام والبساطة مع وضوح الهوية التراثية. 
                        تبدأ المرأة بارتداء الثوب النجدي الواسع، الذي يزدان بتطريز ملون بارز في منطقة الصدر، ويُكمل المظهر الشيلة لتغطية الرأس، وهو لباس يعكس الذوق النجدي وطبيعة البيئة الصحراوية. 
                        أما الرجل فيرتدي الثوب مع الغترة والعقال الزري، ويُلبس فوق ذلك الزبون والبشت في المناسبات الرسمية. ولا يزال هذا اللباس حاضرًا في المناسبات الوطنية والاجتماعية.
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
    الوسطى()
}
