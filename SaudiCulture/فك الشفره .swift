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
    @State private var currentIndex = 0
    @State private var feedback = ""
    @State private var showSuccessEmoji = false
    @State private var goToPuzzleLevel = false

    
    let puzzles: [Puzzle] = [
        
        Puzzle(
            emojis: "🟢 ☕ ",
            hint: "مشروب عربي مشهور",
            answer: "القهوه السعوديه"
        ),
        
        Puzzle(
            emojis: "🌴 🍯",
            hint: "شي حلو يطلع من النخلة",
            answer: "تمر"
        ),
        
        Puzzle(
            emojis: "🔥 ☕",
            hint: "طريقة قديمة لتحضير القهوة",
            answer: "تحميص القهوة"
        ),
        
        Puzzle(
            emojis: "🏕️ 🌌",
            hint: "جلسة في الصحراء تحت النجوم",
            answer: "كشتة"
        ),
        
        Puzzle(
            emojis: "👘 🇸🇦",
            hint: "لبس تقليدي للرجال",
            answer: "ثوب"
        ),
        
        Puzzle(
            emojis: "🥁 💃",
            hint: "فن شعبي سعودي",
            answer: "عرضة"
        ),
        
        Puzzle(
            emojis: "☀️ 🏜️ 🐪",
            hint: "وسيلة تنقل قديمة في الصحراء",
            answer: "جمل"
        ),
        
        Puzzle(
            emojis: "🏠 🪑 ☕",
            hint: "مكان يجتمع فيه الناس للقهوة",
            answer: "مجلس"
        )
    ]
    
    let southernPuzzles: [Puzzle] = [
        
        Puzzle(
            emojis: "🏔️ 🌧️ ☁️",
            hint: "مدينة الضباب والجمال في الجنوب",
            answer: "أبها"
        ),
        
        Puzzle(
            emojis: "🥣 🍯 🧈",
            hint: "أكلة شعبية جنوبية مشهورة تؤكل مع السمن والعسل",
            answer: "عريكة"
        ),
        
        Puzzle(
            emojis: "🏠 🎨 ✨",
            hint: "فن تزيين جدران المنازل في عسير",
            answer: "القط العسيري"
        ),
        
        Puzzle(
            emojis: "🌸 👑 🧔",
            hint: "تاج من الزهور يوضع على الرأس في جازان وعسير",
            answer: "عصابة"
        ),
        
        Puzzle(
            emojis: "🏔️ 🛖 🧱",
            hint: "قرية تراثية شهيرة في منطقة الباحة",
            answer: "ذي عين"
        ),
        
        Puzzle(
            emojis: "🥣 🔥 🪵",
            hint: "أكلة جنوبية تشبه العريكة لكن تطبخ على النار وتُفرك",
            answer: "مشغوثة"
        ),
        
        Puzzle(
            emojis: "💃 ⚔️ 🥁",
            hint: "رقصة شعبية حماسية تشتهر بها جازان",
            answer: "العرضة الجيزانية"
        ),
        
        Puzzle(
            emojis: "🥭 🏝️ 🦐",
            hint: "مدينة تشتهر بالمانجو والسمك والأجواء الدافئة",
            answer: "جازان"
        ),

        Puzzle(
            emojis: "⛰️ 🚠 🌫️",
            hint: "جبل في أبها تصل إليه عبر العربات المعلقة",
            answer: "الجبل الأخضر"
        ),

        Puzzle(
            emojis: "🍞 🛖 🏺",
            hint: "خبز جنوبي يخبز في التنور أو الميفا",
            answer: "خبز ميفا"
        )
    ]
    
    @State private var goToMap = false

    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
//                Image("background")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//                    .ignoresSafeArea()
                Image("الوسطى")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    // Header
                    HStack {
                        Spacer()
                        Button(action: {
                            goToMap = true
                        }) {
                            Image(systemName: "house.fill")
                                .font(.system(size: 16))
                                .foregroundColor(Color(hex: "FCF0DD"))
                                .padding(12)
                                .background(Color(hex: "874F35"))
                                .clipShape(Circle())
                        }

                    }
                    .padding()
                    .offset(x:-15,y:70)

                    
                    
                    
                    // الكرت
                    VStack(spacing: 10) {
                        
                        
                        
                        Text("فك الشفرة")
                        //                        .font(.title)
                            .font(.custom("Saudi-Regular", size: 30))
                        
                            .foregroundColor(Color(hex: "874F35"))
                            .padding(.bottom, 20)
                            .offset(x: 0 , y: -100)
                        
                        
                        HStack(spacing: 20) {
                            Text(puzzles[currentIndex].emojis)
                            //                        Text("☕")
                            //                        Text("🏜️")
                        }
                        .font(.title)
                        
                        .offset(x: 0 , y: -100)
                        
                        
                        if showSuccessEmoji {
                            Text("😁")
                                .font(.largeTitle)
                                .transition(.scale)
                        }
                        
                        Text(feedback)
                            .font(.custom("Saudi-Regular", size: 18))
                            .foregroundColor(.brown)
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
                    .offset(x:0,y:70)
                    .overlay(
                        Group {
                            if showPopup {
                                ZStack {
                                    
                                    VStack(spacing: 20) {
                                        Text(puzzles[currentIndex].hint)
                                            .font(.custom("Saudi-Regular", size: 22))
                                            .foregroundColor(Color(hex: "FCF0DD"))
                                        
                                        //                                    Text("هز الجهاز لمعرفة المعلومة")
                                        //                                        .font(.custom("Saudi-Regular", size: 16))
                                        //                                        .foregroundColor(Color(hex: "FCF0DD"))
                                        
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
                    
                    Button(action: {
                        
                        let correct = puzzles[currentIndex].answer
                        let userAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if userAnswer == correct {
                            
                            // صح
                            showSuccessEmoji = true
                            feedback = ""
                            
                            // بعد ثانية ينتقل للغز التالي
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                currentIndex = (currentIndex + 1) % puzzles.count
                                answer = ""
                                showSuccessEmoji = false
                                goToPuzzleLevel = true
                            }
                            
                        } else {
                            
                            // غلط
                            showSuccessEmoji = false
                            feedback = "حاول مرة أخرى"
                        }
                    }) {
                        Text("التالي")
                            .font(.custom("Saudi-Regular", size: 20))
                        
                            .foregroundColor(Color(hex: "FCF0DD"))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(Color(hex: "874F35"))
                            .cornerRadius(25)
                    }
                    
                    .offset(x:0,y:70)

                    Spacer()
                }
            }
            .navigationDestination(isPresented: $goToMap) {
                SaudiMapView()
            }

            .navigationBarBackButtonHidden(true)
            
            .navigationDestination(isPresented: $goToPuzzleLevel) {
                LevelAlwosta()
            }

        }
    }
}

#Preview("PuzzleView") {
    PuzzleView()
}
