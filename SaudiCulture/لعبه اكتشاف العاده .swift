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
    @State private var showPopup = false

    
    
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()



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
                        Button(action: {
                            withAnimation(.easeInOut) {
                                showPopup = true
                            }
                        }) {
                            Image(systemName: "questionmark")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .padding(16)
                                .background(Color(hex: "874F35"))
                                .clipShape(Circle())
                        }

                        Spacer()
                    }
                    .padding(.leading, 20)


                    
//                    if showPopup {
//                            // محتوى البوب أب
//                            ZStack() {
//                                VStack(spacing: 20){
//                                    Text("هز الجوال")
//                                        .font(.custom("Saudi-Regular", size: 22))
//                                        .foregroundColor(Color(hex: "FCF0DD"))
//                                    
//                                    Text("هز الجهاز لمعرفة المعلومة")
//                                        .font(.custom("Saudi-Regular", size: 16))
//                                        .foregroundColor(Color(hex: "FCF0DD"))
//                                    
//                                    Button("إغلاق") {
//                                        withAnimation {
//                                            showPopup = false
//                                        }
//                                    }
//                                    .padding(.horizontal, 30)
//                                    .padding(.vertical, 10)
//                                    .background(Color(hex: "FCF0DD"))
//                                    .foregroundColor(Color(hex: "874F35"))
//                                    .clipShape(Capsule())
//                                }
//                                .padding(24)
//                                .background(Color(hex: "874F35"))
//                                .cornerRadius(24)
//                                .shadow(radius: 10)
//                                .transition(.scale)
//                                .offset(x:0,y:-150)
//                            }
//                    }

                    
                    
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
                .overlay(
                    Group {
                        if showPopup {
                            ZStack {
                              
                                VStack(spacing: 20) {
                                    Text("هز الجوال")
                                        .font(.custom("Saudi-Regular", size: 22))
                                        .foregroundColor(Color(hex: "FCF0DD"))

                                    Text("هز الجهاز لمعرفة المعلومة")
                                        .font(.custom("Saudi-Regular", size: 16))
                                        .foregroundColor(Color(hex: "FCF0DD"))

                                    Button("إغلاق") {
                                        withAnimation {
                                            showPopup = false
                                        }
                                    }
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: "FCF0DD"))
                                    .foregroundColor(Color(hex: "874F35"))
                                    .clipShape(Capsule())
                                }
                                .padding(24)
                                .background(Color(hex: "874F35"))
                                .cornerRadius(24)
                                .shadow(radius: 10)
                                .transition(.scale)
                            }
                        }
                    }
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

