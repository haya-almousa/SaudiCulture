//
//  CharacterSelectionView.swift
//  SaudiCulture
//
//  Created by Haya almousa on 04/02/2026.
//
import SwiftUI

// شاشة اختيار الشخصية: تعرض أزواج صور وتمكّن المستخدم من اختيار شخصية واحدة
struct CharacterPickerView: View {

    // مصفوفة أزواج الأسماء لكل منطقة (ذكر/أنثى) مطابقة لأسماء الصور في الأصول
    let characterPairs: [[String]] = [
        ["نجدي", "نجديه"], // المنطقة النجدية (ذكر/أنثى)
        ["شرقاوية", "شرقاوي"], // المنطقة الشرقية (أنثى/ذكر)
        ["شماليه", "شمالي"], // المنطقة الشمالية (أنثى/ذكر)
        ["جنوبي", "جنوبيه"], // المنطقة الجنوبية (ذكر/أنثى)
        ["غربيه", "غربي"], // المنطقة الغربية (أنثى/ذكر)
    ]

    // الحالة التي تحتفظ بالاسم المختار حالياً (nil يعني لم يتم الاختيار بعد)
    @State private var selectedName: String? = nil
    @State private var navigateToAlwosta: Bool = false
    @State private var navigateToSharqia: Bool = false
    @State private var navigateToJanoub: Bool = false
    @State private var navigateToGharbi: Bool = false
    @State private var navigateToShamal: Bool = false


    private var isNameValid: Bool { selectedName != nil }

    // بناء واجهة المستخدم الخاصة باختيار الشخصية
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) { // مسافة رأسية بين الصفوف مشابهة للصورة، مخفضة
                    // أسماء المناطق بالترتيب الظاهر في الصورة
                    let regionTitles: [String] = [
                        "المنطقة الوسطى",
                        "المنطقة الشرقية",
                        "المنطقة الغربية",
                        "المنطقة الجنوبية",
                        "المنطقة الشمالية"
                    ]

                    let rowCount: Int = characterPairs.count

                    ForEach(0..<rowCount, id: \.self) { rowIndex in
                        let pair: [String] = characterPairs[rowIndex]
                        let isEvenRow: Bool = rowIndex % 2 == 0 // صف 0،2،4 ...

                        // صف واحد يحتوي على العنوان + زوج الشخصيات، مع محاذاة متبادلة
                        HStack(alignment: .center, spacing: 8) {
                            if isEvenRow {
                                // العنوان على اليمين، الشخصيات على اليسار (كما في بعض صفوف الصورة)
                                Text(regionTitles[rowIndex])
                                    .font(.custom("Saudi-Regular", size: 28))
                                    .foregroundStyle(Color("brown"))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)

                                Spacer(minLength: 6)

                                // الزوج على يسار العنوان
                                HStack(spacing: -64) { // تقارب واضح بين الشخصيتين مع تداخل أكبر
                                    ForEach(pair, id: \.self) { name in
                                        Image(name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 140) // حجم مناسب لـ iPhone، مخفض
                                            .opacity(selectedName == nil ? 0.6 : (selectedName == name ? 1.0 : 0.35))
                                            .animation(.easeInOut(duration: 0.2), value: selectedName)
                                            .onTapGesture {
                                                selectedName = name
                                                if name == "نجدي" || name == "نجديه" {
                                                    navigateToAlwosta = true
                                                } else if name == "شرقاوي" || name == "شرقاوية" {
                                                    navigateToSharqia = true
                                               } else if name == "جنوبي" || name == "جنوبيه" {
                                                    
                                                   navigateToJanoub = true
                                                } else if name == "شمالي" || name == "شماليه" {
                                                    navigateToShamal = true
                                                }
                                            }
                                            .zIndex(selectedName == name ? 1 : 0)
                                    }
                                }
                                .frame(maxWidth: 240, alignment: .trailing)
                            } else {
                                // الصف الفردي: الشخصيات أولاً ثم العنوان على اليسار
                                HStack(spacing: -64) { // تقارب واضح بين الشخصيتين مع تداخل أكبر
                                    ForEach(pair, id: \.self) { name in
                                        Image(name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 140)
                                            .opacity(selectedName == nil ? 0.6 : (selectedName == name ? 1.0 : 0.35))
                                            .animation(.easeInOut(duration: 0.2), value: selectedName)
                                            .onTapGesture {
                                                selectedName = name
                                                if name == "نجدي" || name == "نجديه" {
                                                    navigateToAlwosta = true
                                                } else if name == "شرقاوي" || name == "شرقاوية" {
                                                    navigateToSharqia = true
                                               // } else if name == "جنوبي" || name == "جنوبيه" {
                                                    //navigateToJanoub = true//
                                                } else if name == "غربي" || name == "غربيه" {
                                                    navigateToGharbi = true
                                                } else if name == "شمالي" || name == "شماليه" {
                                                    navigateToShamal = true
                                                }
                                            }
                                            .zIndex(selectedName == name ? 1 : 0)
                                    }
                                }
                                .frame(maxWidth: 240, alignment: .leading)

                                Spacer(minLength: 6)

                                Text(regionTitles[rowIndex])
                                    .font(.custom("Saudi-Regular", size: 28))
                                    .foregroundStyle(Color("brown"))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: isEvenRow ? .trailing : .leading)
                    }

                    // زر "التالي" بأسلوب مخصص
                    Button("التالي") {
                        // TODO: تنفيذ الإجراء التالي (مثل الانتقال للشاشة التالية أو تأكيد الاختيار)
                    }
                    .font(.custom("Saudi-Regular", size: 20))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Color("brown"))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .disabled(!isNameValid)
                    .opacity(isNameValid ? 1 : 0.4)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20) // حواف جانبية مشابهة للصورة
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .navigationDestination(isPresented: $navigateToAlwosta) {
                مرحباالوسطى(playerName: selectedName ?? "")
            }
            .navigationDestination(isPresented: $navigateToSharqia) {
                مرحباالشرقيه(playerName: selectedName ?? "")
            }
            .navigationDestination(isPresented: $navigateToJanoub) {
                مرحباالجنوبيه(playerName: selectedName ?? "")
            }
            }
            .navigationDestination(isPresented: $navigateToGharbi) {
                مرحباالغربيه(playerName: selectedName ?? "")
            }
            .navigationDestination(isPresented: $navigateToShamal) {
                مرحباالشماليه(playerName: selectedName ?? "")
            }
        }
    }


// معاينة الواجهة أثناء التطوير باستخدام SwiftUI Preview
#Preview {
    CharacterPickerView()
}

