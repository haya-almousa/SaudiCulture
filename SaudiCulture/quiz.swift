import SwiftUI
import Combine

struct ChoicePuzzle {
    let question: String
    let choices: [String]
    let correctIndex: Int
    let hint: String
    let description: String
}

struct PuzzleChoicesView: View {
    let region: RegionType
    let levelNumber: Int

    init(region: RegionType, levelNumber: Int) {
        self.region = region
        self.levelNumber = levelNumber
    }

    @ObservedObject var flow = LevelFlow.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedIndex: Int? = nil
    @State private var feedback = ""
    @State private var showHint = false
    @State private var gotonextpage = false
    @State private var selectedDescription: String = ""
    @State private var goToMap = false
    @State private var shake = false
    @State private var stopShaking = false

    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var currentIndex: Int {
        min(max(levelNumber - 1, 0), activePuzzles.count - 1)
    }

    let centralPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(question: "أنا ملك المائدة في نجد خصوصاً في الغداء، أتكون من أرز ولحم، والسر في طعمي هو الكشنة اللي فوقي، واسمي صار عالمي.", choices: ["السليق", "الكبسة (المكبوس)", "العصيدة"], correctIndex: 1, hint: "تبدأ بحرف (ك)، وإذا كانت اللحمة مدفونة تحت الرز تسمى أحياناً مضغوط.", description: "الكبسة من أشهر الأطباق التقليدية في نجد وفي السعودية عموماً، وتُقدَّم غالباً في وجبة الغداء.\nتتكوّن من الأرز المتبّل بالبهارات مع اللحم أو الدجاج، وتتميّز بالكشنة التي تُضاف على الوجه.\nوتُعد رمزاً للكرم والضيافة في المجتمع السعودي، وانتشرت عالمياً كطبق سعودي أصيل."),
        ChoicePuzzle(question: "أنا الرقصة الرسمية للمملكة وأصلي من نجد، نرتدي فيها المراود ونحمل السيوف ونردد قصائد الفخر.", choices: ["السامري", "العرضة السعودية", "الخبيتي"], correctIndex: 1, hint: "كانت تسمى عرضة الحرب وتؤدى في المناسبات الوطنية.", description: "العرضة السعودية هي الرقصة الوطنية للمملكة العربية السعودية وأصلها من نجد.\nكانت تُؤدّى قديماً قبل الحروب لرفع المعنويات، وأصبحت اليوم تُقدَّم في المناسبات الوطنية والرسمية.\nيشارك فيها الرجال حاملين السيوف، مع ترديد قصائد الفخر والحماسة على إيقاع الطبول."),
        ChoicePuzzle(question: "أنا طبق شتوي بامتياز، أُصنع من أقراص عجين البر مع المرق والخضار واللحم.", choices: ["المطازيز", "المراصيع", "المرقوق"], correctIndex: 0, hint: "اسمي يشبه صوت رمي العجين في المرق، وأنا أصغر من المرقوق.", description: "المطازيز من الأكلات الشعبية المشهورة في نجد، وتُحضَّر غالباً في فصل الشتاء.\nتتكوّن من أقراص صغيرة من عجين البر تُطهى في مرق يحتوي على اللحم والخضار.\nيُعد طبقاً دسماً يمنح الدفء ويجسد بساطة المطبخ النجدي التقليدي."),
        ChoicePuzzle(question: "أنا العاصمة القديمة للدولة السعودية، مبانيّ من الطين ومسجلة في اليونسكو.", choices: ["قصر المصمك", "حي الطريف بالدرعية", "قصر المربع"], correctIndex: 1, hint: "أبدأ بحرف ط، وأنا قلب الدرعية التاريخية.", description: "حي الطريف في الدرعية هو العاصمة التاريخية الأولى للدولة السعودية.\nيتميّز بمبانيه الطينية ذات الطراز النجدي الأصيل، ويُعد شاهداً على نشأة الدولة.\nتم تسجيله في قائمة التراث العالمي لليونسكو لما يحمله من قيمة تاريخية وثقافية كبيرة."),
        ChoicePuzzle(question: "أنا فن غنائي نجدي أصيل، نؤديه جلوساً مع إيقاع الدفوف وقصائد وجدانية.", choices: ["الدحة", "السامري", "الينبعاوي"], correctIndex: 1, hint: "اسمي مرتبط بالسمر ليلاً.", description: "السامري فن غنائي شعبي أصيل في منطقة نجد، ويُؤدَّى غالباً في جلسات السمر ليلاً.\nيعتمد على إيقاع الدفوف، وتُلقى خلاله قصائد وجدانية تعبّر عن المشاعر والحنين.\nويعكس هذا الفن الترابط الاجتماعي والحياة الثقافية في المجتمع النجدي.")
    ]

    let northernPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(question: "أنا فن شعبي مهيب، نصف فيه صفوفاً متراصة، ونصْدِر أصواتاً تشبه زئير الأسود، وننتهي بكلمة (هلا هلا بيك يا ولد).", choices: ["الدحة", "الخطوة", "السامري"], correctIndex: 0, hint: "يلقبونها بـ (أنفاس الأسود)، وكانت تُؤدى لإرهاب الأعداء.", description: "الدحة فن شعبي اشتهرت به مناطق شمال المملكة.\nيؤدَّى على شكل صفوف متراصة مع أصوات جماعية قوية تشبه زئير الأسود.\nكان يُستخدم قديماً لبث الحماسة وإرهاب الخصوم، ويُؤدّى اليوم في المناسبات والاحتفالات."),
        ChoicePuzzle(question: "أنا لستُ مجرد فاكهة، أنا كنز الشمال. لوني أسود، وطعمي مثل الدبس.", choices: ["تمر السكري", "حلوة الجوف", "تمر الإخلاص"], correctIndex: 1, hint: "هي أشهر أنواع التمور في منطقة الجوف.", description: "حلوة الجوف من أشهر منتجات منطقة الجوف الزراعية.\nتتميز بلونها الداكن وطعمها القريب من الدبس، وقيمتها الغذائية العالية.\nوتُعد من الرموز التراثية المرتبطة بالهوية الزراعية للشمال."),
        ChoicePuzzle(question: "أنا أكلة شمالية أصيلة، أعتمد على خبز يُصلى في الجمر مباشرة، ثم يُفرك بالسمن البري.", choices: ["الجريش", "الجمرية (الخميعة)", "المندي"], correctIndex: 1, hint: "اسمها مشتق من (الجمر) لأنها تُطبخ تحت رماده.", description: "الجمرية أو الخميعة من الأكلات الشعبية في شمال المملكة.\nيُخبز العجين مباشرة تحت الجمر ثم يُفرك بالسمن البري.\nتعكس هذه الأكلة بساطة الحياة واعتماد أهل الشمال على الموارد المتاحة."),
        ChoicePuzzle(question: "أنا رفيقة أهل الشمال في البرد القارس، أُصنع من صوف الغنم أو وبر الإبل، وأكون ثقيلة ودافئة.", choices: ["المشلح", "الفروة", "الشماغ"], correctIndex: 1, hint: "تبدأ بحرف (ف)، وهي ضرورية لبرد الشمال.", description: "الفروة لباس تقليدي يُستخدم في مناطق الشمال لمواجهة البرد القارس.\nتُصنع من صوف الغنم أو وبر الإبل، وتتميّز بثقلها ودفئها العالي.\nوتُعد رمزاً للحياة الصحراوية في الأجواء الباردة."),
        ChoicePuzzle(question: "أنا مدينة تاريخية في منطقة تبوك، اشتهرت بآثار (مدين) وجبالي منحوتة تشبه البتراء.", choices: ["ضباء", "البدع (مغائر شعيب)", "طريف"], correctIndex: 1, hint: "تقع في أقصى الشمال الغربي، واسمها يبدأ بـ (ألف ولام وباء).", description: "البدع أو مغائر شعيب موقع تاريخي في منطقة تبوك.\nتضم جبالاً منحوتة وآثاراً قديمة تُنسب لحضارة مدين.\nوتُعد من أهم المواقع الأثرية في شمال غرب المملكة.")
    ]

    let southernPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(question: "أنا الأكلة اللي ما يكتمل الفطور أو المناسبة بدونها، أعتمد على الدقيق والفرك اليدوي، وفي وسطي (بحر) من السمن والعسل.", choices: ["الكبسة", "العريكة", "المندي"], correctIndex: 1, hint: "اسمي مشتق من عملية (العرك) باليد.", description: "العريكة من أشهر الأكلات الشعبية في جنوب المملكة.\nتُحضَّر من الدقيق وتُعرك باليد ثم يُضاف إليها السمن والعسل.\nتُقدَّم في الفطور والمناسبات، وترمز للكرم والاحتفاء بالضيف."),
        ChoicePuzzle(question: "أنا رقصة رجالية حماسية جداً، نعتمد فيها على ضرب الأرض بقوة جماعية، وأشتهرنا بها في قبائل قحطان وشهران ومن حولهم.", choices: ["القزوعي", "السامري", "المزمار"], correctIndex: 0, hint: "تبدأ بحرف (ق) وصوت ضربة القدم فيها يسمى (هبدة).", description: "القزوعي رقصة شعبية رجالية في جنوب المملكة.\nتعتمد على ضرب الأرض بالأقدام بشكل جماعي وقوي.\nوتُؤدّى في المناسبات لتعكس القوة والتلاحم بين أفراد القبيلة."),
        ChoicePuzzle(question: "أنا زينة توضع فوق الرأس، مكونة من أجمل الورود والريحان والبرك.", choices: ["الشماغ", "الغترة", "العصابة (اللّوية)"], correctIndex: 2, hint: "مشهورة جداً في (رجال ألمع) وفي (جازان).", description: "العصابة أو اللّوية زينة تقليدية يرتديها رجال الجنوب.\nتُصنع من الورود والريحان بألوان زاهية وروائح عطرة.\nوتُعد جزءاً من الهوية الجمالية والتراثية للمنطقة."),
        ChoicePuzzle(question: "أنا مصنوع من الفخار والطين، أخبز أطعم (لحوح) و(خمير).", choices: ["الميفا", "الميكروويف", "الفرن الكهربائي"], correctIndex: 0, hint: "وهو التنور الجنوبي الأصيل.", description: "الميفا فرن تقليدي مصنوع من الطين والفخار في جنوب المملكة.\nيُستخدم لخبز الخمير واللحُوح وأطعمة أخرى.\nويمثل جزءاً أساسياً من المطبخ الجنوبي التقليدي."),
        ChoicePuzzle(question: "نحن بيوت بنيت من الحجر الصلب، ونزين جدراننا بفن (القط العسيري).", choices: ["الخيام", "الحصون والبيوت الحجرية", "البيوت الطينية"], correctIndex: 1, hint: "قرية (ذي عين) و(رجال ألمع) من أشهرها.", description: "البيوت الحجرية في جنوب المملكة تتميز بقوتها ومتانتها.\nتُزيَّن من الداخل بفن القط العسيري الملون.\nوتعكس التكيّف مع طبيعة الجبال والبيئة المحيطة.")
    ]

    let hejazPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(question: "أنا فن شعبي حجازي بامتياز، نلعب بالعصا في حلقة دائرية ومسجل في اليونسكو.", choices: ["المزمار", "العرضة", "الدحة"], correctIndex: 0, hint: "رقصة تعبر عن القوة والولاء للحارة.", description: "المزمار فن شعبي اشتهر في منطقة الحجاز.\nيؤدَّى بالعصي في حلقة دائرية وسط إيقاعات حماسية.\nسُجّل ضمن التراث الثقافي غير المادي لما يحمله من قيمة اجتماعية."),
        ChoicePuzzle(question: "أنا رفيق الصباح في الحجاز، مزيج من الخبز والموز.", choices: ["الجريش", "المعصوب", "العريكة"], correctIndex: 1, hint: "وإذا أضفنا قشطة وتمر يسمى (ملكي).", description: "المعصوب وجبة فطور شعبية في الحجاز.\nيتكوّن من الخبز والموز ويُضاف له العسل أو القشطة.\nويعكس التنوع الغذائي والتأثيرات الثقافية في المنطقة."),
        ChoicePuzzle(question: "أنا الشخصية الأهم في الحارة الحجازية قديماً.", choices: ["السقا", "العمدة", "المهرج"], correctIndex: 1, hint: "الكل يناديه بـ (يا عمّ).", description: "العمدة كان الشخصية القيادية في الحارة الحجازية.\nيتولى حل النزاعات وتنظيم شؤون السكان.\nويمثل رمز الحكمة والمسؤولية الاجتماعية."),
        ChoicePuzzle(question: "نحن مجموعة من الحلويات التقليدية الملونة.", choices: ["الكليجا", "النواشف والحلويات الحجازية", "المعمول"], correctIndex: 1, hint: "تُعد أجمل هدية من الزوار.", description: "الحلويات الحجازية تتميز بتنوعها وألوانها الزاهية.\nتُقدَّم في المناسبات وتُهدى للضيوف والزوار.\nوتعكس كرم الضيافة الحجازية."),
        ChoicePuzzle(question: "أنا فن غنائي يشتهر به أهل الساحل.", choices: ["الينبعاوي", "السامري", "القزوعي"], correctIndex: 0, hint: "يُسمى (لعب البحر).", description: "الينبعاوي فن غنائي شعبي مرتبط بسواحل الحجاز.\nيُؤدّى باستخدام آلة السمسمية.\nويعكس ارتباط أهل الساحل بالبحر وحياتهم اليومية.")
    ]

    let easternPuzzles: [ChoicePuzzle] = [
        ChoicePuzzle(question: "أنا لستُ أرزاً عادياً، لوني يميل للاحمرار.", choices: ["أرز بسمتي", "الأرز الحساوي", "الأرز الأمريكي"], correctIndex: 1, hint: "يحتاج حرارة عالية لزراعته.", description: "الأرز الحساوي محصول زراعي تشتهر به الأحساء.\nيتميّز بلونه المائل للاحمرار وقيمته الغذائية العالية.\nويُعد جزءاً من التراث الزراعي في المنطقة الشرقية."),
        ChoicePuzzle(question: "أنا عادة شعبية في منتصف شهر رمضان.", choices: ["الغبقة", "القرقيعان", "العيدية"], correctIndex: 1, hint: "أشهر أهازيجي (قرقيعان وقرقيعان).", description: "القرقيعان عادة رمضانية شعبية في المنطقة الشرقية.\nيخرج الأطفال بملابس تقليدية لجمع الحلويات.\nوتعزز روح الفرح والتكافل الاجتماعي."),
        ChoicePuzzle(question: "أنا أفخم أنواع الأردية الرجالية.", choices: ["المشلح (البشت الحساوي)", "الفروة", "الثوب"], correctIndex: 0, hint: "يُحاك يدوياً بالزري.", description: "البشت الحساوي من أفخم الملابس الرجالية التقليدية.\nيُحاك يدوياً بخيوط الزري المذهبة.\nويُلبس في المناسبات الرسمية والأعياد."),
        ChoicePuzzle(question: "أنا فن بحري أصيل.", choices: ["الفجري", "السامري", "الدحة"], correctIndex: 0, hint: "يرتبط برحلات الغوص.", description: "الفجري فن غنائي بحري اشتهر في الخليج.\nكان يُؤدَّى في رحلات الغوص على اللؤلؤ.\nويجسد كفاح أهل البحر وصبرهم."),
        ChoicePuzzle(question: "أنا نوع من المخبوزات الحساوية.", choices: ["الكليجا", "المعمول", "الخبز الأحمر الحساوي"], correctIndex: 2, hint: "يُخبز في أفران التنور.", description: "الخبز الأحمر الحساوي من أشهر المخبوزات في الأحساء.\nيتميّز بلونه ونكهته الخاصة.\nويُعد جزءاً من المائدة التراثية في المنطقة الشرقية.")
    ]

    var activePuzzles: [ChoicePuzzle] {
        switch region {
        case .central: return centralPuzzles
        case .northern: return northernPuzzles
        case .southern: return southernPuzzles
        case .western: return hejazPuzzles
        case .eastern: return easternPuzzles
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

    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        goToMap = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("brown"))
                                .frame(width: 60, height: 60)
                            
                            Image("saudiMap")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                        }
                    }
                }
                .offset(x: 150, y: -300)

                Spacer()

                let puzzle = activePuzzles[currentIndex]

                ZStack {
                    Text("اختار الإجابة الصحيحة")
                        .font(.custom("Saudi-Regular", size: 26))
                        .fontWeight(.bold)
                        .foregroundColor(Color("brown"))
                        .multilineTextAlignment(.center)
                        .offset(x: -1, y: -15)
                }

                VStack(spacing: 20) {
                    Text(puzzle.question)
                        .font(.custom("Saudi-Bold", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "874F35"))

                    Text(feedback)
                        .foregroundColor(.brown)

                    HStack {
                        Button(action: {
                            showHint = true
                            stopShaking = true
                        }) {
                            Text("💡")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hex: "874F35"))
                                .clipShape(Circle())
                                .offset(x: shake ? -2 : 2, y: shake ? 1 : -1)
                                .rotationEffect(.degrees(shake ? 3 : -3))
                                .scaleEffect(shake ? 1.05 : 0.95)
                                .animation(
                                    shake ?
                                    Animation.easeInOut(duration: 0.15).repeatCount(4, autoreverses: true)
                                    : .default,
                                    value: shake
                                )
                        }
                        .padding(.leading, 3)
                        
                        Spacer()
                    }
                    .onReceive(timer) { _ in
                        if !stopShaking {
                            shake = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                shake = false
                            }
                        }
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

                HStack(spacing: 15) {
                    ForEach(puzzle.choices.indices, id: \.self) { i in
                        Button {
                            if selectedIndex == nil {
                                selectedIndex = i
                                checkAnswer(puzzle: puzzle)
                            }
                        } label: {
                            Text(puzzle.choices[i])
                                .font(.custom("Saudi-Regular", size: 18))
                                .foregroundColor(Color(hex: "874F35"))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(optionFillColor(i, puzzle: puzzle))
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

                if selectedIndex == puzzle.correctIndex {
                    Button {
                        selectedDescription = puzzle.description
                        flow.completeLevel(region: region, levelNumber: levelNumber)
                        gotonextpage = true
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

                Spacer()
            }

            if showHint {
                hintPopupView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToMap) {
            SaudiMapView()
        }
        .navigationDestination(isPresented: $gotonextpage) {
            PuzzleView3(region: region, descriptionText: selectedDescription, levelNumber: levelNumber)
        }
    }

    func checkAnswer(puzzle: ChoicePuzzle) {
        if selectedIndex == puzzle.correctIndex {
            feedback = "😁"
        } else {
            feedback = "حاول مرة أخرى"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                selectedIndex = nil
                feedback = ""
            }
        }
    }

    func optionFillColor(_ index: Int, puzzle: ChoicePuzzle) -> Color {
        guard let selected = selectedIndex else { return Color(hex: "FCF0DD") }
        if index == puzzle.correctIndex { return Color.green.opacity(0.5) }
        if index == selected { return Color.red.opacity(0.5) }
        return Color(hex: "FCF0DD")
    }

    func hintPopupView() -> some View {
        ZStack {
            Color.black.opacity(0.25)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showHint = false
                    }
                }
            
            VStack(spacing: 20) {
                Text(activePuzzles[currentIndex].hint)
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
        }
    }
}

#Preview {
    PuzzleChoicesView(region: .southern, levelNumber: 1)
}
