import SwiftUI

struct AdatTaqaleedView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("لعبة العادات والتقاليد")
                .font(.custom("Saudi-Regular", size: 28))
                .foregroundColor(Color(hex: "874F35"))
                .multilineTextAlignment(.center)

            Text("هذه شاشة مؤقتة. قم بتحديثها بالمحتوى الفعلي للعبة العادات والتقاليد.")
                .font(.custom("Saudi-Regular", size: 18))
                .foregroundColor(Color(hex: "874F35"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "FCF0DD").ignoresSafeArea())
        .navigationTitle("العادات والتقاليد")
    }
}

#Preview {
    NavigationStack {
        AdatTaqaleedView()
    }
}
