import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .trailing, spacing: 20) {
                    Group {
                        Text("سياسة الخصوصية")
                            .font(.custom("Saudi-Bold", size: 28))
                            .foregroundColor(Color("brown"))

                        Text("آخر تحديث: يونيو 2026")
                            .font(.custom("Saudi-Regular", size: 16))
                            .foregroundColor(Color("brown").opacity(0.7))

                        sectionView(
                            title: "مقدمة",
                            body: "نحن في تطبيق جذور نحترم خصوصيتك ونلتزم بحمايتها. توضح هذه السياسة كيفية تعاملنا مع بياناتك عند استخدام التطبيق."
                        )

                        sectionView(
                            title: "البيانات التي نجمعها",
                            body: "يحفظ التطبيق البيانات التالية محلياً على جهازك فقط:\n• اسم اللاعب\n• الشخصية المختارة\n• تقدم اللعبة والمراحل المكتملة\n\nلا يتم إرسال أي من هذه البيانات إلى خوادم خارجية."
                        )

                        sectionView(
                            title: "كيف نستخدم البيانات",
                            body: "تُستخدم البيانات المحفوظة فقط لتحسين تجربة اللعب، مثل حفظ تقدمك في المراحل وعرض اسمك في التطبيق."
                        )

                        sectionView(
                            title: "مشاركة البيانات",
                            body: "لا نشارك أي بيانات مع أطراف ثالثة. جميع البيانات محفوظة محلياً على جهازك فقط."
                        )

                        sectionView(
                            title: "أمان البيانات",
                            body: "بياناتك محفوظة على جهازك فقط باستخدام تقنيات التخزين المحلي الآمنة من Apple."
                        )

                        sectionView(
                            title: "حقوقك",
                            body: "يمكنك حذف جميع بياناتك في أي وقت عن طريق حذف التطبيق من جهازك."
                        )

                        sectionView(
                            title: "تواصل معنا",
                            body: "إذا كان لديك أي استفسار حول سياسة الخصوصية، يمكنك التواصل معنا عبر البريد الإلكتروني."
                        )
                    }
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .background(Color("BackgroundMain"))
            .environment(\.layoutDirection, .rightToLeft)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("brown"))
                    }
                }
            }
        }
    }

    private func sectionView(title: String, body: String) -> some View {
        VStack(alignment: .trailing, spacing: 8) {
            Text(title)
                .font(.custom("Saudi-Bold", size: 20))
                .foregroundColor(Color("brown"))

            Text(body)
                .font(.custom("Saudi-Regular", size: 18))
                .foregroundColor(Color("brown").opacity(0.85))
                .multilineTextAlignment(.trailing)
                .lineSpacing(6)
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
