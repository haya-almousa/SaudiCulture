import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 60
    @State private var pairsMatched = 0
    @State private var showWinPopup = false
    @State private var showTimeUpPopup = false

    var body: some View {
        VStack {
            Text("لعبة الكروت - المنطقة الشرقية")
                .font(.custom("Saudi-Bold", size: 28))
                .padding()

            ZStack {
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundColor(.gray)
                Text("\(timeString(timeRemaining))")
                    .font(.custom("Saudi-Bold", size: 28))
                    .bold()
            }
            .frame(width: 100, height: 100)

            HStack {
                Text("مطابقات: \(pairsMatched)")
                    .font(.custom("Saudi-Bold", size: 28))
                Spacer()
            }
            .padding()

            Spacer()

            if showWinPopup {
                VStack(spacing: 20) {
                    Text("مبروك !")
                        .font(.custom("Saudi-Bold", size: 28))
                    Text("لقد نجحت في مطابقة جميع الكروت!")
                        .font(.custom("Saudi-Bold", size: 28))
                    Button(action: {
                        // Next game action
                    }) {
                        Text("يلا على اللعبه الي بعدها !")
                            .font(.custom("Saudi-Bold", size: 28))
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
            }

            if showTimeUpPopup {
                VStack(spacing: 20) {
                    Text("انتهت اللعبه")
                        .font(.custom("Saudi-Bold", size: 28))
                    Text(" العوض بالجيات")
                        .font(.custom("Saudi-Bold", size: 28))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
            }
        }
        .padding()
    }

    func timeString(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
