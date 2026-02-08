//
//  فك الشفره .swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        r = (int >> 16) & 0xFF
        g = (int >> 8) & 0xFF
        b = int & 0xFF
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}
  

struct Puzzle {
    let emojis: String
    let hint: String
    let answer: String
}


struct PuzzleView: View {
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
                    
                    
                    
                    Text("فك الشفرة")
//                        .font(.title)
                        .font(.custom("Saudi-Regular", size: 30))

                        .foregroundColor(Color(hex: "874F35"))
                        .padding(.bottom, 20)
                        .offset(x: 0 , y: -100)


                    HStack(spacing: 20) {
                        Text("🟢 ☕ 🏜️")
//                        Text("☕")
//                        Text("🏜️")
                    }
                    .font(.title)

                    .offset(x: 0 , y: -100)


                    Text("😁")
                    .font(.title)
                    .offset(x: 0 , y: -60)

                    VStack(alignment: .trailing, spacing: 8) {

                        TextField("اكتب الإجابه هنا", text: $answer)
                            .font(.custom("Saudi-Regular", size: 20))

                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.brown)
                            .padding(.vertical, 4)
                            .frame(width: 220) // ⭐ تتحكمين بطول الخط هنا

                        Rectangle()
                            .frame(width: 290, height: 2) // ⭐ نفس العرض
                            .foregroundColor(Color(hex: "874F35")/*.opacity(0.5)*/)
                    }
                    .offset(x: 0 , y: -0)



                    
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
                    .offset(x: 0 , y: 100)

               

                    
                    
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

                Button(action: {}) {
                    Text("إنهاء")
                        .font(.custom("Saudi-Regular", size: 20))

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
    PuzzleView()
}
