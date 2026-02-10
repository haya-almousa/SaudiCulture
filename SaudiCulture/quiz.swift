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

    var body: some View {

        ZStack {

            Image("background")
                .resizable()
                .scaledToFit()
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
                        .font(.custom("Saudi-Regular", size: 22))
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
