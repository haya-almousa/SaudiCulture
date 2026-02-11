////
////  فك الشفره .swift
////  SaudiCulture
////
////  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
////
//
//import SwiftUI
//
//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let r, g, b: UInt64
//        r = (int >> 16) & 0xFF
//        g = (int >> 8) & 0xFF
//        b = int & 0xFF
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue: Double(b) / 255
//        )
//    }
//}
//  
//
//struct Puzzle {
//    let emojis: String
//    let hint: String
//    let answer: String
//}
//
//
//struct PuzzleView: View {
//    let region: RegionType
//    @StateObject var flow = LevelFlow.shared
//
//    @State private var answer: String = ""
//    @State private var showText = false
//    @State private var showPopup = false
//    var currentIndex: Int {
//        flow.currentIndex(for: region)
//    }
//    @State private var feedback = ""
//    @State private var showSuccessEmoji = false
//    @State private var goToPuzzleLevel = false
//
//
//    var activePuzzles: [Puzzle] {
//        switch region {
//        case .central: return puzzles
//        case .southern: return southernPuzzles
//        case .eastern: return easternPuzzles
//        case .northern: return northernPuzzles
//        case .western: return westernPuzzles
//        }
//    }
//
//    //الرياض
//    let puzzles: [Puzzle] = [
//        
//        Puzzle(
//            emojis: "🟢 ☕ ",
//            hint: "مشروب عربي مشهور",
//            answer: "القهوة السعودية"
//        ),
//        
//        Puzzle(
//            emojis: "🌴 🍯",
//            hint: "شي حلو يطلع من النخلة",
//            answer: "تمر"
//        ),
//        
//        Puzzle(
//            emojis: "🔥 ☕",
//            hint: "طريقة قديمة لتحضير القهوة",
//            answer: "تحميص القهوة"
//        ),
//        
//        Puzzle(
//            emojis: "🏕️ 🌌",
//            hint: "جلسة في الصحراء تحت النجوم",
//            answer: "كشتة"
//        ),
//        
//     
//        
//        Puzzle(
//            emojis: "🥁 💃",
//            hint: "فن شعبي سعودي",
//            answer: "عرضة"
//        ),
//        
//       
//        
//        Puzzle(
//            emojis: "🏠 🪑 ☕",
//            hint: "مكان يجتمع فيه الناس للقهوة",
//            answer: "مجلس"
//        )
//    ]
//    //الجنوب
//    
//    let southernPuzzles: [Puzzle] = [
//        
//       
//        
//        Puzzle(
//            emojis: "🥣 🍯 🧈",
//            hint: "أكلة شعبية جنوبية مشهورة تؤكل مع السمن والعسل",
//            answer: "عريكة"
//        ),
//        
//        Puzzle(
//            emojis: "🏠 🎨 ✨",
//            hint: "فن تزيين جدران المنازل في عسير",
//            answer: "القط العسيري"
//        ),
//        
//        Puzzle(
//            emojis: "🌸 👑 🧔",
//            hint: "تاج من الزهور يوضع على الرأس في جازان وعسير",
//            answer: "عصابة"
//        ),
//
//        Puzzle(
//            emojis: "⛰️ 🚠 🌫️",
//            hint: "جبل في أبها تصل إليه عبر العربات المعلقة",
//            answer: "الجبل الأخضر"
//        ),
//
//        Puzzle(
//            emojis: "🍞 🛖 🏺",
//            hint: "خبز جنوبي يخبز في التنور أو الميفا",
//            answer: "خبز ميفا"
//        )
//    ]
//    //الشرقيه
//    let easternPuzzles: [Puzzle] = [
//        
//        Puzzle(
//            emojis: "🌴 💦 ⛰️",
//            hint: "أكبر واحة نخيل في العالم وتوجد بالأحساء",
//            answer: "واحة الأحساء"
//        ),
//        
//        Puzzle(
//            emojis: "🌊 🏝️ 🌉",
//            hint: "جسر يربط المنطقة الشرقية بمملكة البحرين",
//            answer: "جسر الملك فهد"
//        ),
//        
//        Puzzle(
//            emojis: "🍚 🥘 🔴",
//            hint: "أشهر أكلة حساوية لونها أحمر",
//            answer: "أرز حساوي"
//        ),
//        
//        Puzzle(
//            emojis: "🐚 🚢 ⚓",
//            hint: "مهنة الأجداد القديمة في الخليج",
//            answer: "صيد اللؤلؤ"
//        ),
//        
//        Puzzle(
//            emojis: "⛰️ ❄️ 🧱",
//            hint: "جبل مشهور في الأحساء بارد من الداخل صيفاً",
//            answer: "جبل القارة"
//        )
//    ]
//    
//    //الشمال 
//    let northernPuzzles: [Puzzle] = [
//        
//        Puzzle(
//            emojis: "❄️ 🏔️ ⛄",
//            hint: "جبل في تبوك يغطيه الثلج في الشتاء",
//            answer: "جبل اللوز"
//        ),
//        
//        Puzzle(
//            emojis: "🍕 🥩 🪵",
//            hint: "أشهر أكلة في دومة الجندل عبارة عن خبز ولحم",
//            answer: "الجمير"
//        ),
//        
//        Puzzle(
//            emojis: "🏺 🏜️ 🧱",
//            hint: "مدينة تاريخية تقع في محافظة العلا",
//            answer: "مدائن صالح"
//        ),
//        
//        Puzzle(
//            emojis: "🫒 🌳 ",
//            hint: "منطقة تشتهر بأكبر مزارع الزيتون في المملكة",
//            answer: "الجوف"
//        ),
//        
//        Puzzle(
//            emojis: "☕ 🪵 🔥",
//            hint: "تسمية تطلق على القهوة التي تُصنع على نار الحطب في الشمال",
//            answer: "قهوة مهيلة"
//        )
//    ]
//    
//    // الحجاز
//    let westernPuzzles: [Puzzle] = [
//        
//        Puzzle(
//            emojis: "🕋 🕌 ✨",
//            hint: "أطهر بقاع الأرض وقبلة المسلمين",
//            answer: "مكة المكرمة"
//        ),
//        
//        Puzzle(
//            emojis: "🌊 🏙️ ⛲",
//            hint: "عروس البحر الأحمر وفيها نافورة الملك فهد",
//            answer: "جدة"
//        ),
//        
//        Puzzle(
//            emojis: "🏠 🪵 🪟",
//            hint: "النوافذ الخشبية المزخرفة في بيوت جدة القديمة",
//            answer: "الرواشين"
//        ),
//        
//        Puzzle(
//            emojis: "🍵 🥖 🔴 🧊",
//            hint: "مشروب حجازي بارد ومشهور لونه أبيض",
//            answer: "سوبيا"
//        ),
//        
//        Puzzle(
//            emojis: "🍚 🥩 🏺",
//            hint: "أكلة حجازية أصيلة تطبخ في وعاء فخاري تحت الأرض",
//            answer: "المندي"
//        )
//    ]
//    
//    
//    @State private var goToMap = false
//
//    var backgroundName: String {
//        switch region {
//        case .central: return "الوسطى"
//        case .southern: return "الجنوبية"
//        case .eastern: return "الشرقية"
//        case .northern: return "الشمالية"
//        case .western: return "الغربية"
//        }
//    }
//
//    
//    var body: some View {
//        
//        NavigationStack {
//            
//            ZStack {
////                Image("background")
////                    .resizable()
////                    .scaledToFit()
////                    .frame(maxWidth: .infinity)
////                    .ignoresSafeArea()
//                Image(backgroundName)
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack {
//                    // Header
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            goToMap = true
//                        }) {
//                            Image(systemName: "house.fill")
//                                .font(.system(size: 16))
//                                .foregroundColor(Color(hex: "FCF0DD"))
//                                .padding(12)
//                                .background(Color(hex: "874F35"))
//                                .clipShape(Circle())
//                        }
//
//                    }
//                    .padding()
//                    .offset(x:-15,y:70)
//
//                    
//                    
//                    
//                    // الكرت
//                    VStack(spacing: 10) {
//                        
//                        
//                        
//                        Text("فك الشفرة")
//                        //                        .font(.title)
//                            .font(.custom("Saudi-Regular", size: 30))
//                        
//                            .foregroundColor(Color(hex: "874F35"))
//                            .padding(.bottom, 20)
//                            .offset(x: 0 , y: -100)
//                        
//                        
//                        HStack(spacing: 20) {
////                            Text(puzzles[currentIndex].emojis)
//                            Text(activePuzzles[currentIndex].emojis)
//
//                            //                        Text("☕")
//                            //                        Text("🏜️")
//                        }
//                        .font(.title)
//                        
//                        .offset(x: 0 , y: -100)
//                        
//                        
//                        if showSuccessEmoji {
//                            Text("😁")
//                                .font(.largeTitle)
//                                .transition(.scale)
//                        }
//                        
//                        Text(feedback)
//                            .font(.custom("Saudi-Regular", size: 18))
//                            .foregroundColor(.brown)
//                            .font(.title)
//                            .offset(x: 0 , y: -60)
//                        
//                        VStack(alignment: .trailing, spacing: 8) {
//                            
//                            TextField("اكتب الإجابه هنا", text: $answer)
//                                .font(.custom("Saudi-Regular", size: 20))
//                            
//                                .multilineTextAlignment(.trailing)
//                                .foregroundColor(.brown)
//                                .padding(.vertical, 4)
//                                .frame(width: 220) // ⭐ تتحكمين بطول الخط هنا
//                            
//                            Rectangle()
//                                .frame(width: 290, height: 2) // ⭐ نفس العرض
//                                .foregroundColor(Color(hex: "874F35")/*.opacity(0.5)*/)
//                        }
//                        .offset(x: 0 , y: -0)
//                        
//                        
//                        
//                        
//                        HStack {
//                            Button(action: {
//                                withAnimation(.easeInOut) {
//                                    showPopup = true
//                                }
//                            }) {
//                                Image(systemName: "questionmark")
//                                    .font(.system(size: 22))
//                                    .foregroundColor(.white)
//                                    .padding(16)
//                                    .background(Color(hex: "874F35"))
//                                    .clipShape(Circle())
//                            }
//                            
//                            Spacer()
//                        }
//                        .padding(.leading, 20)
//                        .offset(x: 0 , y: 100)
//                        
//                        
//                        
//                        
//                        
//                    }
//                    .frame(width: 355, height: 520) // ← هنا التحكم بالحجم
//                    .background(
//                        RoundedRectangle(cornerRadius: 30)
//                            .stroke(Color(hex: "874F35"), lineWidth: 4)
//                            .background(
//                                RoundedRectangle(cornerRadius: 30)
//                                    .fill(Color(hex: "FCF0DD"))
//                            )
//                    )
//                    .padding()
//                    .offset(x:0,y:70)
//                    .overlay(
//                        Group {
//                            if showPopup {
//                                ZStack {
//                                    
//                                    VStack(spacing: 20) {
//                                        Text(activePuzzles[currentIndex].hint)
//                                            .font(.custom("Saudi-Regular", size: 22))
//                                            .foregroundColor(Color(hex: "FCF0DD"))
//                                        
//                                        //                                    Text("هز الجهاز لمعرفة المعلومة")
//                                        //                                        .font(.custom("Saudi-Regular", size: 16))
//                                        //                                        .foregroundColor(Color(hex: "FCF0DD"))
//                                        
//                                        Button("إغلاق") {
//                                            withAnimation {
//                                                showPopup = false
//                                            }
//                                        }
//                                        .padding(.horizontal, 30)
//                                        .padding(.vertical, 10)
//                                        .background(Color(hex: "FCF0DD"))
//                                        .foregroundColor(Color(hex: "874F35"))
//                                        .clipShape(Capsule())
//                                    }
//                                    .padding(24)
//                                    .background(Color(hex: "874F35"))
//                                    .cornerRadius(24)
//                                    .shadow(radius: 10)
//                                    .transition(.scale)
//                                }
//                            }
//                        }
//                    )
//                    .padding()
//                    
//                    Button(action: {
//                        
//                        let correct = activePuzzles[currentIndex].answer
//                        let userAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
//                        
//                        if userAnswer == correct {
//                            
//                            // صح
//                            showSuccessEmoji = true
//                            feedback = ""
//                            
//                            // بعد ثانية ينتقل للغز التالي
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                flow.advance(region: region, total: activePuzzles.count)
//                                answer = ""
//                                showSuccessEmoji = false
//                                goToPuzzleLevel = true
//                            }
//                            
//                        } else {
//                            
//                            // غلط
//                            showSuccessEmoji = false
//                            feedback = "حاول مرة أخرى"
//                        }
//                    }) {
//                        Text("التالي")
//                            .font(.custom("Saudi-Regular", size: 20))
//                        
//                            .foregroundColor(Color(hex: "FCF0DD"))
//                            .padding(.horizontal, 40)
//                            .padding(.vertical, 12)
//                            .background(Color(hex: "874F35"))
//                            .cornerRadius(25)
//                    }
//                    
//                    .offset(x:0,y:70)
//
//                    Spacer()
//                }
//            }
//            .navigationDestination(isPresented: $goToMap) {
//                SaudiMapView()
//            }
//
//            .navigationBarBackButtonHidden(true)
//            
//            .navigationDestination(isPresented: $goToPuzzleLevel) {
//                LevelAlwosta()
//            }
//
//        }
//    }
//}
//
//#Preview("PuzzleView") {
//    PuzzleView(region: .central)
//}
