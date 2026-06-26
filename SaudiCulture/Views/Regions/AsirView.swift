//import SwiftUI
//
//struct AsirView: View {
//    var region: RegionType
//    var levelNumber: Int
//    
//    var backgroundImageName: String {
//        switch region {
//        case .central:  return "الوسطى"
//        case .northern: return "الشماليه"
//        case .southern: return "الجنوبيه"
//        case .eastern:  return "الشرقيه"
//        case .western:  return "الغربيه"
//        }
//    }
//
//    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
//    @StateObject private var viewModel = GameLogic()
//    @State private var activePopup: GamePopupType? = nil
//
//    // Timer
//    @State private var timeRemaining: Int = 90
//    @State private var timerRunning: Bool = true
//    @State private var flashRed: Bool = false
//
//    // Navigation
//    @State private var goToMap = false
//    @State private var goToNextGame = false
//
//    // 👇 NEW: controls face-up preview before shuffle
//    @State private var isPreviewMode: Bool = true
//
//    // Cards for Asir region
//    let asirCards: [Card] = [
//        Card(text: nil, imageName: "SouthG", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "ثوب مكلف و طفشه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: nil, imageName: "جنوبي", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "عصابه و بيدي", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: nil, imageName: "SouthB", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: "قميص، مصنف و إزار", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: nil, imageName: "جنوبيه", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "ثوب مجنب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                // Background
//                Color(hex: "FFF9F2").ignoresSafeArea()
//                Image(backgroundImageName)
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//
//                // Home Button
//                HStack {
//                    Button(action: {
//                        goToMap = true
//                    }) {
//                        ZStack {
//                            Circle()
//                                .fill(Color("brown"))
//                                .frame(width: 60, height: 60)
//                            
//                            Image("saudiMap")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 35, height: 35)
//                        }
//                    }
//                }
//                .offset(x: 150, y: -344)
//
//                VStack(spacing: 16) {
//                    // Title
//                    Text("لعبة الكروت - عسير")
//                        .font(.custom("Saudi-Regular", size: 30))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color("brown"))
//                        .multilineTextAlignment(.center)
//                        .offset(x: -9 ,y:5)
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
//                            .font(.custom("Saudi-Bold", size: 28))
//                            .foregroundColor(Color(hex: "731112"))
//                    }
//
//                    // Cards Grid
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
//                            CardView(
//                                text: card.text,
//                                imageName: card.imageName,
//                                isFaceUp: isPreviewMode ? true : viewModel.isFlipped(at: index), // 👈 preview mode
//                                borderColor: card.borderColor
//                            )
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                if !isPreviewMode { // 👈 disable tapping during preview
//                                    viewModel.cardTapped(at: index)
//                                }
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 26)
//                    .blur(radius: activePopup != nil ? 10 : 0)
//                    .animation(.default, value: activePopup)
//
//                    // Matched Pairs Counter
//                    HStack {
//                        Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
//                            .font(.custom("Saudi-Bold", size: 28))
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
//            .navigationDestination(isPresented: $goToNextGame) {
//                LevelAljanubiya(levelNumber: levelNumber)
//            }
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
//
//            .onReceive(viewModel.$gameWon) { won in
//                if won {
//                    timerRunning = false
//                    viewModel.revealAllCards()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        withAnimation(.easeInOut) {
//                            activePopup = .win
//                        }
//                    }
//                }
//            }
//
//            .onAppear {
//                viewModel.setupCards(cardPairs: asirCards)
//                isPreviewMode = true // 👈 show all cards face-up
//
//                // Step 1: after 2 seconds, flip all cards face-down
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    withAnimation(.easeInOut(duration: 0.4)) {
//                        isPreviewMode = false
//                    }
//                    // Step 2: after flip animation, shuffle positions
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
//                            viewModel.shuffleCards()
//                        }
//                    }
//                }
//
//                // Start timer (delayed so it doesn't count during preview)
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
//        isPreviewMode = true // 👈 show cards again on reset
//        viewModel.setupCards(cardPairs: asirCards)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            withAnimation(.easeInOut(duration: 0.4)) {
//                isPreviewMode = false
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
//                    viewModel.shuffleCards()
//                }
//            }
//        }
//    }
//
//    // MARK: - Helper
//    func timeString(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let secs = seconds % 60
//        return String(format: "%01d:%02d", minutes, secs)
//    }
//}
//
//#Preview {
//    AsirView(region: .central, levelNumber: 1)
//}


///this below works fine!!
///
import SwiftUI

struct AsirView: View {
    
    var region: RegionType
    var levelNumber: Int
    
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
    let iPadColumns = Array(repeating: GridItem(.fixed(110), spacing: 69), count: 3)
    
    @StateObject private var viewModel = GameLogic()
    @State private var activePopup: GamePopupType? = nil

    @State private var timeRemaining: Int = 90
    @State private var timerRunning: Bool = true
    @State private var flashRed: Bool = false

    @State private var goToMap = false
    @State private var goToNextGame = false
    @State private var isPreviewMode: Bool = true

    var asirLevels: [Card] {
        switch levelNumber {
        case 1:
            return [
                Card(text: nil, imageName: "S1-M", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "عصابه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "S2-M", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "بيدي", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "ثوب عادي", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: "ثوب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "جنوبي", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "اللبس الجنوبي للرجال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        case 2:
            return [
                Card(text: nil, imageName: "S1-G", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "ثوب مجنب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "S2-G", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "الشيلة المريشة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "جنوبيه", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: "اللبس التراثي  للنساء", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: nil, imageName:"تمر", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        case 3:
            return [
                Card(text: nil, imageName: "طفل جنوبي", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "اللبس التراثي  للشباب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "b2-s", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "مصنف", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "b1-s", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: "إزار", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "قميص", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "قميص", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        case 4:
            return [
                Card(text: nil, imageName: "طفله جنوبيه" , borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "اللبس التراثي  للبنات", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName:"G1-S", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "ثوب مكلف", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "hat", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: "طفشة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        default:
            return [
                Card(text: nil, imageName: "SouthG", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "SouthG", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "جنوبي", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "جنوبي", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "SouthB", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "SouthB", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "جنوبيه", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: nil, imageName: "جنوبيه", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let isIPad = geo.size.width >= 600
                
                ZStack {
                    Color(hex: "FFF9F2").ignoresSafeArea()
                    
                    Image(backgroundImageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    if isIPad {
                        iPadLayout
                    } else {
                        iPhoneLayout
                    }
                    
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
            }
            .navigationDestination(isPresented: $goToMap) {
                SaudiMapView()
            }
            .navigationDestination(isPresented: $goToNextGame) {
                LevelAljanubiya(levelNumber: levelNumber)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.setupCards(cardPairs: asirLevels)
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
            }
        }
    }
    
    private var iPhoneLayout: some View {
        ZStack {
            HStack { mapButton }
                .offset(x: 150, y: -390)

            VStack(spacing: 16) {
                Text("لعبة الكروت - عسير")
                    .font(.custom("Saudi-Regular", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("brown"))
                    .multilineTextAlignment(.center)

                timerView

                LazyVGrid(columns: columns, spacing: 16) {
                    cardsContent
                }
                .padding(.horizontal, 26)

                matchesView
                Spacer()
            }
            .padding(.top, 30)
        }
    }
    
    private var iPadLayout: some View {
        ZStack {
            HStack { mapButton }
                .offset(x: 220, y: -820)

            VStack(spacing: 12) {
                Text("لعبة الكروت - عسير")
                    .font(.custom("Saudi-Regular", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("brown"))
                    .multilineTextAlignment(.center)

                timerView

                LazyVGrid(columns: iPadColumns, spacing: 100) {
                    cardsContent
                        .frame(width: 205, height: 245)
                }
                .padding(.horizontal, 90)

                matchesView
                Spacer()
            }
            .padding(.top, 40)
        }
    }

    private var mapButton: some View {
        Button {
            goToMap = true
        } label: {
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
    
    private var timerView: some View {
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
                .font(.custom("Saudi-Bold", size: 28))
                .foregroundColor(Color(hex: "731112"))
        }
    }
    
    private var cardsContent: some View {
        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
            CardView(
                text: card.text,
                imageName: card.imageName,
                isFaceUp: isPreviewMode ? true : viewModel.isFlipped(at: index),
                borderColor: card.borderColor
            )
            .contentShape(Rectangle())
            .onTapGesture {
                if !isPreviewMode {
                    viewModel.cardTapped(at: index)
                }
            }
        }
    }
    
    private var matchesView: some View {
        HStack {
            Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
                .font(.custom("Saudi-Bold", size: 28))
                .foregroundColor(Color(hex: "7A4A2E"))
            Spacer()
        }
        .padding(.horizontal, 26)
    }

    func resetGame() {
        timeRemaining = 90
        timerRunning = true
        flashRed = false
        isPreviewMode = true
        viewModel.setupCards(cardPairs: asirLevels)
    }

    func timeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%01d:%02d", minutes, secs)
    }
}

#Preview {
    AsirView(region: .southern, levelNumber: 5)
}
