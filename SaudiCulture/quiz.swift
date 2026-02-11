//
//  quiz.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 22/08/1447 AH.
//

// PuzzleChoicesView.swift
    
import SwiftUI

struct ChoicePuzzle {
    let question: String
    let choices: [String]
    let correctIndex: Int
    let hint: String
}

struct PuzzleChoicesView: View {

    @State private var currentIndex = 0
    @State private var selectedIndex: Int? = nil
    @State private var feedback = ""
    @State private var showHint = false
    @State private var showSuccess = false
//الوسطه
    let puzzles: [ChoicePuzzle] = [

        ChoicePuzzle(
            question: """
    أنا ملك المائدة في نجد خصوصاً في الغداء، أتكون من أرز ولحم، والسر في طعمي هو الكشنة اللي فوقي، واسمي صار عالمي.
    """,
            choices: ["السليق", "الكبسة (المكبوس)", "العصيدة"],
            correctIndex: 1,
            hint: "تبدأ بحرف (ك)، وإذا كانت اللحمة مدفونة تحت الرز تسمى أحياناً مضغوط."
        ),

        ChoicePuzzle(
            question: """
    أنا الرقصة الرسمية للمملكة وأصلي من نجد، نرتدي فيها المراود ونحمل السيوف ونردد قصائد الفخر.
    """,
            choices: ["السامري", "العرضة السعودية", "الخبيتي"],
            correctIndex: 1,
            hint: "كانت تسمى عرضة الحرب وتؤدى في المناسبات الوطنية."
        ),

        ChoicePuzzle(
            question: """
    أنا طبق شتوي بامتياز، أُصنع من أقراص عجين البر مع المرق والخضار واللحم.
    """,
            choices: ["المطازيز", "المراصيع", "المرقوق"],
            correctIndex: 0,
            hint: "اسمي يشبه صوت رمي العجين في المرق، وأنا أصغر من المرقوق."
        ),

        ChoicePuzzle(
            question: """
    أنا العاصمة القديمة للدولة السعودية، مبانيّ من الطين ومسجلة في اليونسكو.
    """,
            choices: ["قصر المصمك", "حي الطريف بالدرعية", "قصر المربع"],
            correctIndex: 1,
            hint: "أبدأ بحرف ط، وأنا قلب الدرعية التاريخية."
        ),

        ChoicePuzzle(
            question: """
    أنا فن غنائي نجدي أصيل، نؤديه جلوساً مع إيقاع الدفوف وقصائد وجدانية.
    """,
            choices: ["الدحة", "السامري", "الينبعاوي"],
            correctIndex: 1,
            hint: "اسمي مرتبط بالسمر ليلاً."
        )
    ]
    
    
    //الشماليه
    let northernPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(
            question: "أنا فن شعبي مهيب، نصف فيه صفوفاً متراصة، ونصْدِر أصواتاً تشبه زئير الأسود، وننتهي بكلمة (هلا هلا بيك يا ولد).",
            choices: ["الدحة", "الخطوة", "السامري"],
            correctIndex: 0,
            hint: "يلقبونها بـ (أنفاس الأسود)، وكانت تُؤدى لإرهاب الأعداء."
        ),
        ChoicePuzzle(
            question: "أنا لستُ مجرد فاكهة، أنا كنز الشمال. لوني أسود، وطعمي مثل الدبس.",
            choices: ["تمر السكري", "حلوة الجوف", "تمر الإخلاص"],
            correctIndex: 1,
            hint: "هي أشهر أنواع التمور في منطقة الجوف."
        ),
        ChoicePuzzle(
            question: "أنا أكلة شمالية أصيلة، أعتمد على خبز يُصلى في الجمر مباشرة، ثم يُفرك بالسمن البري.",
            choices: ["الجريش", "الجمرية (الخميعة)", "المندي"],
            correctIndex: 1,
            hint: "اسمها مشتق من (الجمر) لأنها تُطبخ تحت رماده."
        ),
        ChoicePuzzle(
            question: "أنا رفيقة أهل الشمال في البرد القارس، أُصنع من صوف الغنم أو وبر الإبل، وأكون ثقيلة ودافئة.",
            choices: ["المشلح", "الفروة", "الشماغ"],
            correctIndex: 1,
            hint: "تبدأ بحرف (ف)، وهي ضرورية لبرد الشمال."
        ),
        ChoicePuzzle(
            question: "أنا مدينة تاريخية في منطقة تبوك، اشتهرت بآثار (مدين) وجبالي منحوتة تشبه البتراء.",
            choices: ["ضباء", "البدع (مغائر شعيب)", "طريف"],
            correctIndex: 1,
            hint: "تقع في أقصى الشمال الغربي، واسمها يبدأ بـ (ألف ولام وباء)."
        )
    ]
    
    
    //الجنوبيه
    let southernPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(
            question: "أنا الأكلة اللي ما يكتمل الفطور أو المناسبة بدونها، أعتمد على الدقيق والفرك اليدوي، وفي وسطي (بحر) من السمن والعسل.",
            choices: ["الكبسة", "العريكة", "المندي"],
            correctIndex: 1,
            hint: "اسمي مشتق من عملية (العرك) باليد."
        ),
        ChoicePuzzle(
            question: "أنا رقصة رجالية حماسية جداً، نعتمد فيها على ضرب الأرض بقوة جماعية، وأشتهرنا بها في قبائل قحطان وشهران ومن حولهم.",
            choices: ["القزوعي", "السامري", "المزمار"],
            correctIndex: 0,
            hint: "تبدأ بحرف (ق) وصوت ضربة القدم فيها يسمى (هبدة)."
        ),
        ChoicePuzzle(
            question: "أنا زينة توضع فوق الرأس، مكونة من أجمل الورود والريحان والبرك، وشكلي يعطي منظر جمالي ورائحة خيالية.",
            choices: ["الشماغ", "الغترة", "العصابة (اللّوية)"],
            correctIndex: 2,
            hint: "مشهورة جداً في (رجال ألمع) وفي (جازان)، وألوانها دايم فرفوشة."
        ),
        ChoicePuzzle(
            question: "أنا مصنوع من الفخار والطين، أخبز أطعم (لحوح) و(خمير)، والسمك داخلي يطلع طعمه حكاية ثانية.",
            choices: ["الميفا", "الميكروويف", "الفرن الكهربائي"],
            correctIndex: 0,
            hint: "تبدأ بحرف (م)، وهو التنور الجنوبي الأصيل."
        ),
        ChoicePuzzle(
            question: "نحن بيوت بنيت من الحجر الصلب، ونزين جدراننا من الداخل بفن (القط العسيري) الملون، ونسكن في قمم الجبال.",
            choices: ["الخيام", "الحصون والبيوت الحجرية", "البيوت الطينية"],
            correctIndex: 1,
            hint: "قرية (ذي عين) بالباحة و(رجال ألمع) بعسير هم أشهر من بنوها."
        )
    ]

    
    // الغربيه
    let hejazPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(
            question: "أنا فن شعبي حجازي بامتياز، نلعب بالعصا في حلقة دائرية ومسجل في اليونسكو.",
            choices: ["المزمار", "العرضة", "الدحة"],
            correctIndex: 0,
            hint: "تبدأ بحرف (م)، وهي رقصة تعبر عن القوة والولاء للحارة."
        ),
        ChoicePuzzle(
            question: "أنا رفيق الصباح في الحجاز، مزيج من الخبز والموز، ويُضاف فوقي العسل والقشطة.",
            choices: ["الجريش", "المعصوب", "العريكة"],
            correctIndex: 1,
            hint: "تبدأ بحرف (م)، وإذا أضفنا لها تمر وقشطة تُسمى (ملكي)."
        ),
        ChoicePuzzle(
            question: "أنا الشخصية الأهم في الحارة الحجازية قديماً، كلمتي مسموعة، وأحل النزاعات بين الناس.",
            choices: ["السقا", "العمدة", "المهرج"],
            correctIndex: 1,
            hint: "تبدأ بحرف (ع)، والكل يناديه بـ (يا عمّ)."
        ),
        ChoicePuzzle(
            question: "نحن مجموعة من الحلويات التقليدية الملونة، مثل (اللدو) و(اللبنية) و(الهريسة).",
            choices: ["الكليجا", "النواشف والحلويات الحجازية", "المعمول"],
            correctIndex: 1,
            hint: "تبدأ بحرف (ن)، وتعتبر أجمل هدية من الزوار."
        ),
        ChoicePuzzle(
            question: "أنا فن غنائي يشتهر به أهل الساحل، نستخدم في عزفه آلة (السمسمية).",
            choices: ["الينبعاوي", "السامري", "القزوعي"],
            correctIndex: 0,
            hint: "اسمه مشتق من مدينة (ينبع)، ويُسمى (لعب البحر)."
        )
    ]
    // الشرقيه
    let easternPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(
            question: "أنا لستُ أرزاً عادياً، لوني يميل للاحمرار، وأُزرع في أرض الأحساء المباركة.",
            choices: ["أرز بسمتي", "الأرز الحساوي", "الأرز الأمريكي"],
            correctIndex: 1,
            hint: "يبدأ بحرف (ح)، ويحتاج حرارة عالية جداً لزراعته."
        ),
        ChoicePuzzle(
            question: "أنا عادة شعبية ينتظرها الأطفال في منتصف شهر رمضان، يلبسون الملابس التقليدية ويجمعون الحلويات.",
            choices: ["الغبقة", "القرقيعان", "العيدية"],
            correctIndex: 1,
            hint: "تبدأ بحرف (ق)، وأشهر أهازيجي: (قرقيعان وقرقيعان)."
        ),
        ChoicePuzzle(
            question: "أنا أفخم أنواع الأردية الرجالية، وتشتهر الأحساء يدوياً بحياكتي بـ (الزري) المذهب.",
            choices: ["المشلح (البشت الحساوي)", "الفروة", "الثوب"],
            correctIndex: 0,
            hint: "يبدأ بحرف (ب)، ويستغرق أسابيع من العمل اليدوي."
        ),
        ChoicePuzzle(
            question: "أنا فن بحري أصيل، كنتُ رفيق الأجداد في رحلات الغوص، وأعتمد على أصوات النهامين.",
            choices: ["الفجري", "السامري", "الدحة"],
            correctIndex: 0,
            hint: "يبدأ بحرف (ف)، ويجسد قصة كفاح أهل الخليج مع البحر."
        ),
        ChoicePuzzle(
            question: "أنا نوع من المخبوزات التي تشتهر بها المنطقة الشرقية، محشوة بالتمر وعليها نقوش جميلة.",
            choices: ["الكليجا", "المعمول", "الخبز الأحمر الحساوي"],
            correctIndex: 2,
            hint: "يبدأ بحرف (خ)، ويُخبز في أفران التنور."
        )
    ]
    
    
    var body: some View {

        ZStack {

            Image("الوسطى")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {

                // زر إنهاء
                HStack {
                    Spacer()
                    Text("إنهاء اللعبة")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color(hex: "874F35"))
                        .foregroundColor(Color(hex: "FCF0DD"))
                        .cornerRadius(25)
                }
                .padding()

                Spacer()

                let puzzle = puzzles[currentIndex]

                // الكرت
                VStack(spacing: 20) {

                    Text(puzzle.question)
                        .font(.custom("Saudi-Bold", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "874F35"))

                    

                    Text(feedback)
                        .foregroundColor(.brown)

                    // زر تلميح
                    HStack {
                        Button {
                            showHint.toggle()
                        } label: {
                            Image(systemName: "questionmark")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: "874F35"))
                                .clipShape(Circle())
                        }

                        Spacer()
                    }

                }
                .padding()
                .frame(width: 360)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "FCF0DD"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(hex: "874F35"), lineWidth: 4)
                        )
                )

                // الخيارات خارج الكرت
                HStack(spacing: 15) {

                    ForEach(puzzle.choices.indices, id: \.self) { i in

                        Button {

                            if selectedIndex == nil {
                                selectedIndex = i
                                checkAnswer()
                            }

                        } label: {

                            Text(puzzle.choices[i])
                                .font(.custom("Saudi-Regular", size: 18))
                                .foregroundColor(Color(hex: "874F35"))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(

                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(optionFillColor(i))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color(hex: "874F35"), lineWidth: 3)
                                        )

                                )
                        }
                        .disabled(selectedIndex != nil)

                        
                    }
                }
                .padding(.top, 10)

                Spacer()

                // التالي
                // التالي يظهر بعد الاختيار فقط
                if selectedIndex != nil {

                    Button {

                        nextPuzzle()

                    } label: {

                        Text("التالي")
                            .font(.custom("Saudi-Regular", size: 20))
                            .foregroundColor(Color(hex: "FCF0DD"))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(Color(hex: "874F35"))
                            .cornerRadius(25)
                    }
                    .transition(.scale)
                }


            }

            // نافذة التلميح
            .overlay {
                if showHint {

                    ZStack {

                        // خلفية شفافة
                        Color.black.opacity(0.25)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showHint = false
                                }
                            }

                        // البوب اب
                        VStack(spacing: 20) {

                            Text(puzzles[currentIndex].hint)
                                .font(.custom("Saudi-Regular", size: 22))
                                .foregroundColor(Color(hex: "FCF0DD"))
                                .multilineTextAlignment(.center)

                            Button("إغلاق") {
                                withAnimation {
                                    showHint = false
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

        }
        .navigationBarBackButtonHidden(true)

    }

    // MARK: - Logic

    func checkAnswer() {

        guard let selected = selectedIndex else { return }

        if selected == puzzles[currentIndex].correctIndex {

            feedback = "إجابة صحيحة!"
            showSuccess = true

        } else {

            feedback = "حاول مرة أخرى"
            showSuccess = false
        }
    }

    func nextPuzzle() {

        currentIndex = (currentIndex + 1) % puzzles.count
        selectedIndex = nil
        feedback = ""
    }

    func buttonColor(_ index: Int) -> Color {

        guard let selected = selectedIndex else {
            return Color(hex: "874F35")
        }

        if index == puzzles[currentIndex].correctIndex && selected != nil {
            return .green
        }

        if index == selected && selected != puzzles[currentIndex].correctIndex {
            return .red
        }

        return Color(hex: "874F35")
    }
    
    
    func optionFillColor(_ index: Int) -> Color {

        guard let selected = selectedIndex else {
            return Color(hex: "FCF0DD")
        }

        if index == puzzles[currentIndex].correctIndex {
            return Color.green.opacity(0.5)
        }

        if index == selected {
            return Color.red.opacity(0.5)
        }

        return Color(hex: "FCF0DD")
    }

}

#Preview {
    PuzzleChoicesView()
}
