//
//  فك الشفره .swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
//

import SwiftUI

  

struct PuzzleView2: View {
    @State private var answer: String = ""
    @State private var showText = false

    
    
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()

            // صورة النخلة بالخلفية
//            GeometryReader { proxy in
//                Image("palm_bg")
//                    .resizable()
//                    .scaledToFit()
//                    .opacity(0.15)
//                    .frame(maxWidth: .infinity)
//                    .position(x: proxy.size.width / 2,
//                              y: proxy.size.height * 0.75)
//            }
//            .ignoresSafeArea()

            VStack {
                // Header
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("انهاء اللعبه ")
                            .font(.custom("Saudi-Regular", size: 14))

                            .foregroundColor(Color(hex: "FCF0DD"))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(hex: "874F35"))
                            .cornerRadius(25)
                        
                    }
                }
                .padding()

//               
//                HStack {
//                    Button(action: {
//                        
//                    }) {
//                        Image(systemName: "house")
//                            .font(.system(size: 30, weight: .medium)) // ⭐ حجم الأيقونة
//                                       .foregroundColor(Color(hex: "874F35"))
//                                       .padding(2)
//                    }
//                    .offset(x: -155, y: -50)
//                }
                
                
                
                
                // الكرت
                VStack(spacing: 10) {
                    
                    
                    
                    Text("اكتشف العاده ")
                        .font(.custom("Saudi-Regular", size: 25))
                        .foregroundColor(Color(hex: "874F35"))
                        .padding(.bottom, 20)
                        .offset(x: 0 , y: -10)


                    HStack(spacing: 20) {
                        Text("اجعل الفنجال يتحرك  ")
                    }
                    .font(.custom("Saudi-Regular", size: 30))
                    .foregroundColor(Color(hex: "874F35"))
                    .offset(x: 0 , y: 10 )

  
                    Image("الفنجال ")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .offset(x: 0 , y: 80)

                    
                    
                    
                    HStack {
                        ZStack(alignment: .leading) { // نثبت النص على اليسار
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showText.toggle()
                                }
                            }) {
                                HStack {
                                    if showText {
                                        Text(" هز الجوال  ")
                                            .font(.custom("Saudi-Regular", size: 20))
                                            .foregroundColor(Color(hex: "FCF0DD"))
                                            .padding(.horizontal, 28)
                                            .padding(.vertical, 14)
                                    } else {
                                        Image(systemName: "questionmark")
                                            .font(.system(size: 22))
                                            .foregroundColor(.white)
                                            .padding(16)
                                    }
                                }
                                .background(Color(hex: "874F35"))
                                .clipShape(RoundedRectangle(cornerRadius: showText ? 25 : 30)) // morph
                                .frame(minWidth: showText ? 140 : 60, alignment: .leading) // الثبات على اليسار
                            }
                        }
                        Spacer() // يخلي الزر على اليسار
//                        .offset(x: -140, y: 120)

                    }
                    .padding(.leading, 20)
                    .offset(x: 0, y: 10)

                    
                    
                }
                .frame(width: 355, height: 520) // ← هنا التحكم بالحجم
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(hex: "874F35"), lineWidth: 4)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "FCF0DD"))
                        )
                )
                .padding()

//                Spacer()

                Button(action: {}) {
                    Text("إنهاء")
                        .font(.custom("Saudi-Regular", size: 18))
                        .foregroundColor(Color(hex: "FCF0DD"))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color(hex: "874F35"))
                        .cornerRadius(25)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    PuzzleView2()
}
