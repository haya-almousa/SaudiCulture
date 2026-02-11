//
//  الشمالبه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct الشماليه: View {
    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()
            
            // صورتين جنب بعض
            HStack(spacing: 0) {
                Image("شماليه")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 360)
                
                Image("شمالي")
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
                        لباس المنطقة الشمالية يعكس البساطة والاحتشام المرتبطين بطبيعة الحياة الصحراوية.
                        المرأة تبدأ بلبس المحوثل، وهو ثوب أسود واسع يتميّز بتطريزات بسيطة، وتحط الشيلة لتغطية الرأس، ومعها المقرونة اللي تعتبر من أغطية الرأس التقليدية المعروفة في المنطقة، وهاللبس يعبّر عن الهوية المحلية والالتزام بالعادات.
                        أما الرجل فيلبس ثوب مردون، ويحط الغترة مع العقال، ويكمّل مظهره بـ البشت، وهذي قطع تعبّر عن الطابع التراثي والمكانة الاجتماعية في المنطقة الشمالية، ولسّه هاللباس موجود في المناسبات الشعبية والتراثية.
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
    الشماليه()
}
