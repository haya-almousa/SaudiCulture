//
//  FashionView.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//


import SwiftUI

struct الوسطى: View {
    @State private var startNajdGame = false
    var body: some View {
        NavigationStack{
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
                        لباس المنطقة الوسطى (نجد) معروف بالاحتشام والبساطة مع وضوح الهوية التراثية.
                        المرأة تبدأ بلبس الثوب النجدي الواسع، اللي يكون فيه تطريز ملون وواضح في منطقة الصدر، وتكمل شكلها بـ الشيلة لتغطية الرأس، وهاللبس يعكس الذوق النجدي وطبيعة البيئة الصحراوية.
                        أما الرجل فيلبس الثوب مع الغترة والعقال الزري، ويلبس فوقهم الزبون والبشت في المناسبات الرسمية. ولسّه هاللباس موجود في المناسبات الوطنية والاجتماعية.
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
                        startNajdGame = true
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
            .navigationBarBackButtonHidden(true)

            
            .navigationDestination(isPresented: $startNajdGame) {
                NajdView()
            }
    }
    }
}

#Preview {
    الوسطى()
}
