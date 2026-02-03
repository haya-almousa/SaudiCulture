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
  

struct PuzzleView: View {
    @State private var answer: String = ""

    
    
    
    var body: some View {
        ZStack {
            // لون الخلفية
            Color(hex: "FFF9F2")
                .ignoresSafeArea()

            // صورة النخلة بالخلفية
            GeometryReader { proxy in
                Image("palm_bg")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.15)
                    .frame(maxWidth: .infinity)
                    .position(x: proxy.size.width / 2,
                              y: proxy.size.height * 0.75)
            }
            .ignoresSafeArea()

            VStack {
                // Header
                HStack {
                    Image("home")
                        .resizable()
                        .frame(width: 24, height: 24)

                    Spacer()
                }
                .padding()

               
                // الكرت
                VStack(spacing: 10) {
                    
                    
                    
                    Text("فك الشفرة")
                        .font(.title)
                        .foregroundColor(Color.brown)
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
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.brown)
                            .padding(.vertical, 4)
                            .frame(width: 220) // ⭐ تتحكمين بطول الخط هنا

                        Rectangle()
                            .frame(width: 290, height: 1) // ⭐ نفس العرض
                            .foregroundColor(Color.brown.opacity(0.5))
                    }
                    .offset(x: 0 , y: -0)



                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "questionmark")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.brown)
                                .clipShape(Circle())
                        }
                        .offset(x: -140, y: 120) // ← تحكم كامل بالموقع

//                        Spacer()
                    }
                }
//                .padding()
                .frame(width: 355, height: 520) // ← هنا التحكم بالحجم

                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.brown, lineWidth: 4)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "FCF0DD"))
                        )
                )
                .padding()

//                Spacer()

                Button(action: {}) {
                    Text("إنهاء")
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.brown)
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
