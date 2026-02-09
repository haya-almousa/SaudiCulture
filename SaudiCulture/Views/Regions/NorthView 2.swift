import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 60
    @State private var matchedPairs = 0
    @State private var showWinPopup = false
    @State private var showTimeUpPopup = false

    var body: some View {
        VStack {
            Text("لعبة الكروت - الشمالية")
                .font(.custom("Saudi-Bold", size: 28))
                .padding()

            ZStack {
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 100)

                Text("\(timeString(timeRemaining))")
                    .font(.custom("Saudi-Bold", size: 28))
            }
            .padding()

            HStack {
                Text("مطابقات: \(matchedPairs)")
                    .font(.custom("Saudi-Bold", size: 28))
                    .padding()
                Spacer()
            }

            Spacer()

            if showWinPopup {
                VStack(spacing: 20) {
                    Text("مبروك !")
                        .font(.custom("Saudi-Bold", size: 28))

                    Text("لقد نجحت في مطابقة جميع الكروت!")
                        .font(.custom("Saudi-Bold", size: 28))

                    Button(action: {
                        resetGame()
                    }) {
                        Text("إعادة اللعب")
                            .font(.custom("Saudi-Bold", size: 28))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            }

            if showTimeUpPopup {
                VStack(spacing: 20) {
                    Text("انتهت اللعبه")
                        .font(.custom("Saudi-Bold", size: 28))

                    Text(" العوض بالجيات")
                        .font(.custom("Saudi-Bold", size: 28))

                    Button(action: {
                        resetGame()
                    }) {
                        Text("إعادة المحاولة")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
        .onAppear(perform: startTimer)
        .padding()
    }

    func timeString(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startTimer() {
        // Timer logic here
    }

    func resetGame() {
        timeRemaining = 60
        matchedPairs = 0
        showWinPopup = false
        showTimeUpPopup = false
        startTimer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
