///
//
//import SwiftUI
//
//struct EasternView: View {
//    var region: RegionType
//    var backgroundImageName: String {
//            switch region {
//            case .central:  return "الوسطى"
//            case .northern: return "الشماليه"
//            case .southern: return "الجنوبيه"
//            case .eastern:  return "الشرقيه"
//            case .western:  return "الغربيه"
//            }
//        }
//    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
//    
//    @StateObject private var viewModel = GameLogic()
//    @State private var activePopup: GamePopupType? = nil
//    
//    // Timer
//    @State private var timeRemaining: Int = 90
//    @State private var timerRunning: Bool = true
//    @State private var flashRed: Bool = false
//    
//    // 🔥 زر الرجوع للخريطة
//    @State private var goToMap = false
//    
//    // ✅ ربط الفوز بالبزل
//    @State private var goToNextGame = false
//    
//    // Cards for Eastern region
//    let easternCards: [Card] = [
//        // Pair 1
//        Card(text: nil, imageName: "شرقاوية", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: " ثوب النشل ", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        // Pair 2
//        Card(text: nil, imageName: "شرقاوي", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: " ثوب مرودن و عقال مقصب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        // Pair 3
//        Card(text: nil, imageName: "شرقية", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: " بخنق و دراعة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        // Pair 4
//        Card(text: nil, imageName: "شرقي", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: " غترة و صديريه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
//        // Lonely card
//        Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
//    ]
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                // Background
//                Color(hex: "FFF9F2").ignoresSafeArea()
//                Image(backgroundImageName)
//                               .resizable()
//                               .scaledToFill()
//                               .ignoresSafeArea()
//                
//                
//                // 🔥 زر الهوم
//                HStack{
//                    Button(action: {
//                        goToMap = true
//                    }) {
//                        Image(systemName: "house.fill")
//                            .font(.system(size: 25))
//                            .foregroundColor(Color(hex: "FCF0DD"))
//                            .padding(12)
//                            .background(Color(hex: "874F35"))
//                            .clipShape(Circle())
//                    }
//                }
//                .offset(x:150,y:-300)
//
//                VStack(spacing: 16) {
//                    // Title
//                    Text("لعبة الكروت - المنطقة الشرقية")
//                        .foregroundStyle(Color(hex: "7A4A2E"))
//                        .font(.custom("Saudi-Regular", size: 28))
//                    
//                    // Timer
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.white.opacity(0.3))
//                            .frame(width: 100, height: 40)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .stroke(Color(hex: "7A4A2E").opacity(0.5), lineWidth: 2)
//                            )
//                            .shadow(radius: 3)
//                            .opacity(flashRed ? 0.3 : 1)
//                        
//                        Text("\(timeString(timeRemaining))")
//                            .font(.custom("Saudi-Regular", size: 28))
//                            .foregroundColor(Color(hex: "731112"))
//                    }
//                    
//                    // Cards Grid
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
//                            CardView(
//                                text: card.text,
//                                imageName: card.imageName,
//                                isFaceUp: viewModel.isFlipped(at: index),
//                                borderColor: card.borderColor
//                            )
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                viewModel.cardTapped(at: index)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 26)
//                    .blur(radius: activePopup != nil ? 10 : 0)
//                    .animation(.default, value: activePopup)
//                    
//                    // Pairs Counter
//                    HStack {
//                        Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
//                            .font(.custom("Saudi-Regular", size: 28))
//                            .foregroundColor(Color(hex: "7A4A2E"))
//                        Spacer()
//                    }
//                    .padding(.horizontal, 26)
//                    
//                    Spacer()
//                }
//                .padding(.top, 60)
//                
//                // MARK: - Popup
//                if let popup = activePopup {
//                    GamePopupView(
//                        type: popup,
//                        onClose: {
//                            activePopup = nil
//                            resetGame()
//                        },
//                        onPrimaryAction: popup == .win ? {
//                            activePopup = nil
//                            goToNextGame = true
//                        } : nil
//                    )
//                }
//            }
//            .navigationDestination(isPresented: $goToMap) {
//                SaudiMapView()
//            }
//            // ✅ بعد الفوز يروح للبزل (الشرقية)
//            .navigationDestination(isPresented: $goToNextGame) {
//                LevelAlsharqiya()
//            }
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
//            
//            ////
////            .onReceive(viewModel.$gameWon) { won in
////                if won {
////                    activePopup = .win
////                    timerRunning = false
////                }
////            }
//            .onReceive(viewModel.$gameWon) { won in
//                if won {
//                    timerRunning = false
//                    viewModel.revealAllCards() // 👈 flips the lonely card
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 👈 1 sec delay
//                        withAnimation(.easeInOut) {
//                            activePopup = .win
//                        }
//                    }
//                }
//            }
//            
//            .onAppear {
//                viewModel.setupCards(cardPairs: easternCards)
//                
//                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                    if timerRunning && timeRemaining > 0 {
//                        timeRemaining -= 1
//                        flashRed = timeRemaining <= 15 && timeRemaining > 0
//                    } else if timeRemaining == 0 {
//                        timer.invalidate()
//                        activePopup = .timeUp
//                        timerRunning = false
//                    }
//                }
//            }
//        }
//    }
//    
//    // MARK: - Reset Game
//    func resetGame() {
//        timeRemaining = 90
//        timerRunning = true
//        flashRed = false
//        viewModel.setupCards(cardPairs: easternCards)
//    }
//    
//    // Helper: format seconds to mm:ss
//    func timeString(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let secs = seconds % 60
//        return String(format: "%01d:%02d", minutes, secs)
//    }
//}
//
//#Preview {
//    EasternView(region: .central)
//}
import SwiftUI

struct EasternView: View {
    var region: RegionType
    var backgroundImageName: String {
        switch region {
        case .central:  return "الوسطى"
        case .northern: return "الشماليه"
        case .southern: return "الجنوبيه"
        case .eastern:  return "الشرقيه"
        case .western:  return "الغربيه"
        }
    }

    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    @StateObject private var viewModel = GameLogic()
    @State private var activePopup: GamePopupType? = nil

    // Timer
    @State private var timeRemaining: Int = 90
    @State private var timerRunning: Bool = true
    @State private var flashRed: Bool = false

    // Navigation
    @State private var goToMap = false
    @State private var goToNextGame = false

    // 👇 Preview mode for shuffle animation
    @State private var isPreviewMode: Bool = true

    // Cards for Eastern region
    let easternCards: [Card] = [
        Card(text: nil, imageName: "شرقاوية", borderColor: Color(hex: "731112"), pairID: 1),
        Card(text: " ثوب النشل ", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
        Card(text: nil, imageName: "شرقاوي", borderColor: Color(hex: "731112"), pairID: 2),
        Card(text: " ثوب مرودن و عقال مقصب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
        Card(text: nil, imageName: "شرقية", borderColor: Color(hex: "731112"), pairID: 3),
        Card(text: " بخنق و دراعة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
        Card(text: nil, imageName: "شرقي", borderColor: Color(hex: "731112"), pairID: 4),
        Card(text: " غترة و صديريه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
        Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(hex: "FFF9F2").ignoresSafeArea()
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Home Button
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
                .offset(x: 150, y: -310)

                VStack(spacing: 16) {
                    // Title
                    Text("لعبة الكروت - المنطقة الشرقية")
                        .foregroundStyle(Color(hex: "7A4A2E"))
                        .font(.custom("Saudi-Regular", size: 28))

                    // Timer
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 100, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "7A4A2E").opacity(0.5), lineWidth: 2)
                            )
                            .shadow(radius: 3)
                            .opacity(flashRed ? 0.3 : 1)

                        Text("\(timeString(timeRemaining))")
                            .font(.custom("Saudi-Regular", size: 28))
                            .foregroundColor(Color(hex: "731112"))
                    }

                    // Cards Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
                            CardView(
                                text: card.text,
                                imageName: card.imageName,
                                isFaceUp: isPreviewMode ? true : viewModel.isFlipped(at: index),
                                borderColor: card.borderColor
                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if !isPreviewMode {
                                    viewModel.cardTapped(at: index)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 26)
                    .blur(radius: activePopup != nil ? 10 : 0)
                    .animation(.default, value: activePopup)

                    // Pairs Counter
                    HStack {
                        Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
                            .font(.custom("Saudi-Regular", size: 28))
                            .foregroundColor(Color(hex: "7A4A2E"))
                        Spacer()
                    }
                    .padding(.horizontal, 26)

                    Spacer()
                }
                .padding(.top, 60)

                // MARK: - Popup
                if let popup = activePopup {
                    GamePopupView(
                        type: popup,
                        onClose: {
                            activePopup = nil
                            resetGame()
                        },
                        onPrimaryAction: popup == .win ? {
                            activePopup = nil
                            goToNextGame = true
                        } : nil
                    )
                }
            }
            .navigationDestination(isPresented: $goToMap) {
                SaudiMapView()
            }
            .navigationDestination(isPresented: $goToNextGame) {
                LevelAlsharqiya()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)

            .onReceive(viewModel.$gameWon) { won in
                if won {
                    timerRunning = false
                    viewModel.revealAllCards()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeInOut) {
                            activePopup = .win
                        }
                    }
                }
            }

            .onAppear {
                viewModel.setupCards(cardPairs: easternCards)
                isPreviewMode = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        isPreviewMode = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                            viewModel.shuffleCards()
                        }
                    }
                }

                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if timerRunning && timeRemaining > 0 {
                        timeRemaining -= 1
                        flashRed = timeRemaining <= 15 && timeRemaining > 0
                    } else if timeRemaining == 0 {
                        timer.invalidate()
                        activePopup = .timeUp
                        timerRunning = false
                    }
                }
            }
        }
    }

    // MARK: - Reset Game
    func resetGame() {
        timeRemaining = 90
        timerRunning = true
        flashRed = false
        isPreviewMode = true
        viewModel.setupCards(cardPairs: easternCards)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.4)) {
                isPreviewMode = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    viewModel.shuffleCards()
                }
            }
        }
    }

    // Helper
    func timeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%01d:%02d", minutes, secs)
    }
}

#Preview {
    EasternView(region: .central)
}
