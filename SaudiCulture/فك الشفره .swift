//
//  فك الشفره .swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
//

//
//  فك الشفره .swift
//  SaudiCulture
//

import SwiftUI
import Combine

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
    let secondAnswer: String?
}

struct PuzzleView: View {
    let region: RegionType
    let levelNumber: Int
    
    init(region: RegionType, levelNumber: Int) {
        self.region = region
        self.levelNumber = levelNumber
    }
    
    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    @ObservedObject var flow = LevelFlow.shared

    @State private var answer: String = ""
    @State private var showText = false
    @State private var showPopup = false
    
    var currentIndex: Int {
        min(max(levelNumber - 1, 0), activePuzzles.count - 1)
    }

    @State private var feedback = ""
    @State private var showSuccessEmoji = false
    @State private var goToPuzzleLevel = false

    var activePuzzles: [Puzzle] {
        switch region {
        case .central: return puzzles
        case .southern: return southernPuzzles
        case .eastern: return easternPuzzles
        case .northern: return northernPuzzles
        case .western: return westernPuzzles
        }
    }

    var backgroundImageName: String {
        switch region {
        case .central:  return "الوسطى"
        case .northern: return "الشماليه"
        case .southern: return "الجنوبيه"
        case .eastern:  return "الشرقيه"
        case .western:  return "الغربيه"
        }
    }

    let puzzles: [Puzzle] = [
        Puzzle(emojis: "🇸🇦 ☕ ", hint: "مشروب سعودي مشهور", answer: "القهوة السعودية", secondAnswer: nil),
        Puzzle(emojis: "🌴 🍯", hint: "شي حلو يطلع من النخلة", answer: "تمر", secondAnswer: nil),
        Puzzle(emojis: "🔥 ☕", hint: "طريقة قديمة لتحضير القهوة", answer: "تحميص القهوة", secondAnswer: nil),
        Puzzle(emojis: "🏕️ 🌌", hint: "جلسة في الصحراء تحت النجوم", answer: "كشتة", secondAnswer: nil),
        Puzzle(emojis: "🥁 💃", hint: "فن شعبي سعودي", answer: "عرضة", secondAnswer: nil),
        Puzzle(emojis: "🏠 🪑 ☕", hint: "مكان يجتمع فيه الناس و الضيوف ", answer: "مجلس", secondAnswer: nil)
    ]
    
    let southernPuzzles: [Puzzle] = [
        Puzzle(emojis: "🥣 🍯 🧈", hint: "أكلة شعبية جنوبية مشهورة تؤكل مع السمن والعسل", answer: "عريكة", secondAnswer: nil),
        Puzzle(emojis: "🏠 🎨 ✨", hint: "فن تزيين جدران المنازل في عسير", answer: "القط العسيري", secondAnswer: nil),
        Puzzle(emojis: "🌸 👑 🧔", hint: "تاج من الزهور يوضع على الرأس في جازان وعسير", answer: "عصابة", secondAnswer: nil),
        Puzzle(emojis: "⛰️ 🚠 🌫️", hint: "جبل في أبها تصل إليه عبر العربات المعلقة", answer: "جبل السودة", secondAnswer: "جبل السودة"),
        Puzzle(emojis: "🍞 🛖 🏺", hint: "خبز جنوبي يخبز في التنور أو الميفا", answer: "خبز ميفا", secondAnswer: nil)
    ]
    
    let easternPuzzles: [Puzzle] = [
        Puzzle(emojis: "🌴 💦 ⛰️", hint: "أكبر واحة نخيل في العالم وتوجد بالأحساء", answer: "واحة الأحساء", secondAnswer: nil),
        Puzzle(emojis: "🌊 🏝️ 🌉", hint: "جسر يربط المنطقة الشرقية بمملكة البحرين", answer: "جسر الملك فهد", secondAnswer: nil),
        Puzzle(emojis: "🍚 🥘 🔴", hint: "أشهر أكلة حساوية لونها أحمر", answer: "أرز حساوي", secondAnswer: "المكبوس الأحمر"),
        Puzzle(emojis: "🐚 🚢 ⚓ 🤿", hint: "مهنة الأجداد القديمة في الخليج", answer: "صيد اللؤلؤ", secondAnswer: "الغوص على اللؤلؤ"),
        Puzzle(emojis: "⛰️ ❄️ 🧱", hint: "جبل مشهور في الأحساء بارد من الداخل صيفاً", answer: "جبل القارة", secondAnswer: nil)
    ]
    
    let northernPuzzles: [Puzzle] = [
        Puzzle(emojis: "❄️ 🏔️ ⛄", hint: "جبل في تبوك يغطيه الثلج في الشتاء", answer: "جبل اللوز", secondAnswer: nil),
        Puzzle(emojis: "🥖 🥩 🪵", hint: "أشهر أكلة في دومة الجندل عبارة عن خبز ولحم", answer: "الجمير", secondAnswer: "المليحية"),
        Puzzle(emojis: "🏺🪨🏜️", hint: "مدينة تاريخية تقع في محافظة العلا", answer: "مدائن صالح", secondAnswer: nil),
        Puzzle(emojis: "🫒 🌳 ", hint: "منطقة تشتهر بأكبر مزارع الزيتون في المملكة", answer: "الجوف", secondAnswer: "عنيزة"),
        Puzzle(emojis: "☕ 🪵 🔥 🌿", hint: "تسمية تطلق على القهوة التي تُصنع على نار الحطب في الشمال", answer: "قهوة مهيلة", secondAnswer: nil)
    ]
    
    let westernPuzzles: [Puzzle] = [
        Puzzle(emojis: "🕋 🕌 ✨", hint: "أطهر بقاع الأرض وقبلة المسلمين", answer: "مكة المكرمة", secondAnswer: "الكعبه "),
        Puzzle(emojis: "🌊 🏙️ ⛲", hint: "عروس البحر الأحمر وفيها نافورة الملك فهد", answer: "جدة", secondAnswer: nil),
        Puzzle(emojis: "🏠 🪵 🪟", hint: "النوافذ الخشبية المزخرفة في بيوت جدة القديمة", answer: "الرواشين", secondAnswer: "الشميسية"),
        Puzzle(emojis: "🥛❄️✨", hint: "مشروب حجازي بارد ومشهور لونه أبيض", answer: "سوبيا", secondAnswer: nil),
        Puzzle(emojis: "🍚 🥩 🏺", hint: "أكلة حجازية أصيلة تطبخ في وعاء فخاري تحت الأرض", answer: "المندي", secondAnswer: nil)
    ]
    
    @State private var goToMap = false
    @State private var showHint = false
    @State private var shake = false
    @State private var stopShaking = false
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                Image(backgroundImageName)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
                            goToMap = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("brown"))
                                    .frame(width: isIPad ? 70 : 60, height: isIPad ? 70 : 60)
                                
                                Image("saudiMap")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: isIPad ? 42 : 35, height: isIPad ? 42 : 35)
                            }
                        }
                        .offset(x: isIPad ? 330 : 153, y: isIPad ? 82 : 8)
                    }
                    
                    VStack {
                        Text("فك الشفرة")
                            .font(.custom("Saudi-Bold", size: isIPad ? 42 : 30))
                            .foregroundColor(Color("brown"))
                            .padding(.bottom, 20)
                            .offset(x: 0, y: isIPad ? 38 : -19)
                    }
                    
                    VStack(spacing: isIPad ? 18 : 10) {
                        Text(" فك الشفرات  باستخدام الرموز والتلميحات و اكتب الاجابه .")
                            .font(.custom("Saudi-Bold", size: isIPad ? 26 : 14))
                            .foregroundColor(Color(hex: "874F35"))
                            .padding(.bottom, 20)
                            .offset(x: 0, y: isIPad ? -110 : -80)
                        
                        HStack(spacing: isIPad ? 30 : 20) {
                            Text(activePuzzles[currentIndex].emojis)
                        }
                        .font(isIPad ? .system(size: 52) : .title)
                        .offset(x: 0, y: isIPad ? -80 : -60)
                        
                        if showSuccessEmoji {
                            Text("😁")
                                .font(isIPad ? .system(size: 52) : .largeTitle)
                                .transition(.scale)
                        }
                        
                        Text(feedback)
                            .font(.custom("Saudi-Regular", size: isIPad ? 28 : 18))
                            .foregroundColor(.brown)
                            .offset(x: 0, y: isIPad ? -80 : -60)
                        
                        VStack(alignment: .trailing, spacing: 8) {
                            TextField("اكتب الإجابه هنا", text: $answer)
                                .font(.custom("Saudi-Regular", size: isIPad ? 28 : 20))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.brown)
                                .padding(.vertical, 4)
                                .frame(width: isIPad ? 360 : 220)
                            
                            Rectangle()
                                .frame(width: isIPad ? 420 : 290, height: 2)
                                .foregroundColor(Color(hex: "874F35"))
                        }
                        
                        HStack {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    showPopup = true
                                }
                                stopShaking = true
                            }) {
                                Text("💡")
                                    .font(.system(size: isIPad ? 34 : 28))
                                    .foregroundColor(.white)
                                    .padding(isIPad ? 14 : 10)
                                    .background(Color(hex: "874F35"))
                                    .clipShape(Circle())
                                    .offset(x: shake ? -2 : 2, y: shake ? 1 : -1)
                                    .rotationEffect(.degrees(shake ? 3 : -3))
                                    .animation(
                                        shake ?
                                        Animation.easeInOut(duration: 0.08)
                                            .repeatCount(6, autoreverses: true)
                                        : .default,
                                        value: shake
                                    )
                            }
                            
                            Spacer()
                        }
                        .onReceive(timer) { _ in
                            if !stopShaking {
                                shake = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                shake = false
                            }
                        }
                        .padding(.leading, isIPad ? 35 : 20)
                        .offset(x: 0, y: isIPad ? 130 : 90)
                    }
                    .frame(width: isIPad ? 620 : 355, height: isIPad ? 620 : 450)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(hex: "874F35"), lineWidth: 4)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: "FCF0DD"))
                            )
                    )
                    .padding()
                    .offset(x: 0, y: isIPad ? 60 : -13)
                    .overlay(
                        Group {
                            if showPopup {
                                VStack(spacing: 20) {
                                    Text(activePuzzles[currentIndex].hint)
                                        .font(.custom("Saudi-Regular", size: isIPad ? 30 : 22))
                                        .foregroundColor(Color(hex: "FCF0DD"))
                                        .multilineTextAlignment(.center)
                                    
                                    Button("إغلاق") {
                                        withAnimation {
                                            showPopup = false
                                        }
                                    }
                                    .font(.custom("Saudi-Regular", size: isIPad ? 24 : 18))
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: "FCF0DD"))
                                    .foregroundColor(Color(hex: "874F35"))
                                    .clipShape(Capsule())
                                }
                                .padding(isIPad ? 34 : 24)
                                .background(Color(hex: "874F35"))
                                .cornerRadius(24)
                                .shadow(radius: 10)
                                .transition(.scale)
                            }
                        }
                    )
                    .padding()
                    
                    Button(action: {
                        let correct = activePuzzles[currentIndex].answer
                        let secondCorrect = activePuzzles[currentIndex].secondAnswer
                        let userAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if userAnswer.isSimilar(to: correct) ||
                            (secondCorrect != nil && userAnswer.isSimilar(to: secondCorrect!)) {
                            
                            showSuccessEmoji = true
                            feedback = ""
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                answer = ""
                                showSuccessEmoji = false
                                goToPuzzleLevel = true
                            }
                        } else {
                            showSuccessEmoji = false
                            feedback = "حاول مرة أخرى"
                        }
                    }) {
                        Text("التالي")
                            .font(.custom("Saudi-Regular", size: isIPad ? 28 : 20))
                            .foregroundColor(Color(hex: "FCF0DD"))
                            .padding(.horizontal, isIPad ? 58 : 40)
                            .padding(.vertical, isIPad ? 16 : 12)
                            .background(Color(hex: "874F35"))
                            .cornerRadius(25)
                    }
                    .offset(x: 0, y: isIPad ? 105 : 7)

                    Spacer()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationDestination(isPresented: $goToMap) {
                SaudiMapView()
            }
            .navigationDestination(isPresented: $goToPuzzleLevel) {
                PuzzleChoicesView(region: region, levelNumber: levelNumber)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

extension String {
    func normalizedArabic() -> String {
        var text = self
        
        let diacritics = "[\\u064B-\\u0652]"
        text = text.replacingOccurrences(
            of: diacritics,
            with: "",
            options: .regularExpression
        )
        
        text = text
            .replacingOccurrences(of: "أ", with: "ا")
            .replacingOccurrences(of: "إ", with: "ا")
            .replacingOccurrences(of: "آ", with: "ا")
            .replacingOccurrences(of: "ة", with: "ه")
            .replacingOccurrences(of: "ى", with: "ي")
        
        text = text.replacingOccurrences(of: "ال", with: "")
        text = text.replacingOccurrences(of: " ", with: "")
        
        return text
    }
    
    func isSimilar(to other: String) -> Bool {
        let a = self.normalizedArabic()
        let b = other.normalizedArabic()
        
        if a == b { return true }
        
        let aNoAl = a.replacingOccurrences(of: "ال", with: "")
        let bNoAl = b.replacingOccurrences(of: "ال", with: "")
        
        if aNoAl == bNoAl { return true }
        
        if aNoAl.contains(bNoAl) || bNoAl.contains(aNoAl) {
            return true
        }
        
        return false
    }
}

#Preview("PuzzleView") {
    PuzzleView(region: .central, levelNumber: 1)
}
