//import SwiftUI
//
//struct NajdView: View {
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
//    @State private var goToNextGame = false
//
//    // Cards for Najd region
//    let najdCards: [Card] = [
//        // Pair 1
//        Card(text: nil, imageName: "NajdW", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "ثوب تور و دراعيه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        // Pair 2
//        Card(text: nil, imageName: "NajdM", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "ﻋﺼﺎﺑﺔ، ﻏﺘﺮة، دﻗﻠﺔ، ﺑﺸﺖ اﻟﺒﺮﻗﺎء، ﺛﻮب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        // Pair 3
//        Card(text: nil, imageName: "NajdG", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: "ثوب\nشيلة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        // Pair 4
//        Card(text: nil, imageName: "NajdB", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "ﻋﻘﺎل زري, ﻏﺘﺮة, زﺑﻮن, ﺑﺸت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
//        // Lonely card
//        Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
//    ]
//    
//    @State private var goToMap = false
//
//    var body: some View {
//        NavigationStack{
//        ZStack {
//            // Background
//            Color(hex: "FFF9F2").ignoresSafeArea()
//            Image(backgroundImageName)
//                           .resizable()
//                           .scaledToFill()
//                           .ignoresSafeArea()
//            
//            
//            HStack{
//                Button(action: {
//                    goToMap = true
//                }) {
//                    Image(systemName: "house.fill")
//                        .font(.system(size: 25))
//                        .foregroundColor(Color(hex: "FCF0DD"))
//                        .padding(12)
//                        .background(Color(hex: "874F35"))
//                        .clipShape(Circle())
//                }
//            }
//            .offset(x:150,y:-300)
//
//            VStack(spacing: 16) {
//                
//                // Title
//                Text("لعبة الكروت - نجد")
//                    .foregroundStyle(Color(hex: "7A4A2E"))
//                    .font(.custom("Saudi-Bold", size: 28))
//                
//                // Timer
//                ZStack {
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(Color.white.opacity(0.3))
//                        .frame(width: 100, height: 40)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color(hex: "7A4A2E").opacity(0.5), lineWidth: 2)
//                        )
//                        .shadow(radius: 3)
//                        .opacity(flashRed ? 0.3 : 1)
//                    
//                    Text("\(timeString(timeRemaining))")
//                        .font(.custom("Saudi-Bold", size: 28))
//                        .foregroundColor(Color(hex: "731112"))
//                }
//                
//                // Cards Grid
//                LazyVGrid(columns: columns, spacing: 16) {
//                    ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
//                        CardView(
//                            text: card.text,
//                            imageName: card.imageName,
//                            isFaceUp: viewModel.isFlipped(at: index),
//                            borderColor: card.borderColor
//                        )
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .contentShape(Rectangle())
//                        .onTapGesture {
//                            viewModel.cardTapped(at: index)
//                        }
//                    }
//                }
//                .padding(.horizontal, 26)
//                .blur(radius: activePopup != nil ? 10 : 0)
//                .animation(.default, value: activePopup)
//
//                
//                // Matched Pairs Counter
//                HStack {
//                    Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
//                        .font(.custom("Saudi-Bold", size: 28))
//                        .foregroundColor(Color(hex: "7A4A2E"))
//                    Spacer()
//                }
//                .padding(.horizontal, 26)
//                
//                Spacer()
//            }
//            .padding(.top, 60)
//            
//            // MARK: - Popup
//            if let popup = activePopup {
//                GamePopupView(
//                    type: popup,
//                    onClose: {
//                        activePopup = nil
//                        resetGame()
//                    },
//                    onPrimaryAction: popup == .win ? {
//                        activePopup = nil
//                        goToNextGame = true
//                        //                        resetGame()
//                    } : nil
//                )
//            }
//            
//            
//        }
//        .navigationDestination(isPresented: $goToMap) {
//            SaudiMapView()
//        }
//
//        // ✅ ربط الكروت بالبزل مباشرة (زي الشرقيه)
//        .navigationDestination(isPresented: $goToNextGame) {
//            LevelAlwosta()
//        }
//
//        .navigationBarBackButtonHidden(true)
//        
//        .navigationBarTitleDisplayMode(.inline)
//            //replace //////
////        .onReceive(viewModel.$gameWon) { won in
////            if won {
////                activePopup = .win
////                timerRunning = false
////            }
////        }
//        .onReceive(viewModel.$gameWon) { won in
//            if won {
//                timerRunning = false
//                viewModel.revealAllCards() // 👈 flips the lonely card
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 👈 1 sec delay
//                    withAnimation(.easeInOut) {
//                        activePopup = .win
//                    }
//                }
//            }
//        }
//            
//        .onAppear {
//            viewModel.setupCards(cardPairs: najdCards)
//            
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                if timerRunning && timeRemaining > 0 {
//                    timeRemaining -= 1
//                    flashRed = timeRemaining <= 15 && timeRemaining > 0
//                } else if timeRemaining == 0 {
//                    timer.invalidate()
//                    activePopup = .timeUp
//                    timerRunning = false
//                }
//            }
//        }
//    }
//    }
//    
//    // MARK: - Reset Game
//    func resetGame() {
//        timeRemaining = 90
//        timerRunning = true
//        flashRed = false
//        viewModel.setupCards(cardPairs: najdCards)
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
//    NajdView(region: .central)
//}
import SwiftUI

struct NajdView: View {
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

    var requiredPairsForLevel: Int {
        switch levelNumber {
        case 1: return 4
        case 2: return 4
        case 3: return 4
        case 4: return 4
        default: return 4
        }
    }

    var najdCards: [Card] {
        switch levelNumber {
        case 1:
            return [
                Card(text: nil, imageName: "بشت اسود", borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: "بشت اسود", imageName: nil, borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: nil, imageName: "غترة بيضاء", borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: "غترة", imageName: nil, borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: nil, imageName: "عقال زري", borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: "عقال زري", imageName: nil, borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: nil, imageName: "NajdB", borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: "اللبس التراثي نجد", imageName: nil, borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex:"731112"), pairID: 5)
            ]

        case 2:
            return [
                Card(text: nil, imageName: "ثوب بنت", borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: "ثوب", imageName: nil, borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: nil, imageName: "شيلة", borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: "شيلة", imageName: nil, borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: nil, imageName: "نجدية", borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: "اللبس التراثي  نجد", imageName: nil, borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: nil, imageName:"تمر", borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex:"731112"), pairID: 5)
            ]

        case 3:
            return [
                Card(text: nil, imageName: "جوخة", borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: "جوخة", imageName: nil, borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: nil, imageName: "طاقيه زري", borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: "طاقية زري", imageName: nil, borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: nil, imageName: "غتره بيضاء طفل", borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: "غترة", imageName: nil, borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: nil, imageName: "عقال", borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: "عقال", imageName: nil, borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex:"731112"), pairID: 5)
            ]

        case 4:
            return [
                Card(text: nil, imageName: "قبع", borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: "قبع", imageName: nil, borderColor: Color(hex:"731112"), pairID: 1),
                Card(text: nil, imageName: "مقطع", borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: "مقطع او دراعه", imageName: nil, borderColor: Color(hex:"731112"), pairID: 2),
                Card(text: nil, imageName:"طفله نجديه", borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: " اللبس التراثي  نجد", imageName: nil, borderColor: Color(hex:"731112"), pairID: 3),
                Card(text: nil, imageName:"تمر", borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex:"731112"), pairID: 4),
                Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex:"731112"), pairID: 5)
            ]

        default:
            return [
                Card(text: nil, imageName: "طفله نجديه", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "طفله نجديه", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "طفل نجدي", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "طفل نجدي", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "NajdG", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "NajdG", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "NajdB", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: nil, imageName: "NajdB", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
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
                LevelAlwosta(levelNumber: levelNumber)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: viewModel.matchedPairsCount) { newValue in
                if newValue == requiredPairsForLevel {
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
                viewModel.setupCards(cardPairs: najdCards)
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

    private var iPhoneLayout: some View {
        ZStack {
            HStack { mapButton }
                .offset(x: 153, y: -344)

            VStack(spacing: 16) {
                Text("لعبة الكروت - نجد")
                    .foregroundColor(Color("brown"))
                    .font(.custom("Saudi-Bold", size: 30))
                    .multilineTextAlignment(.center)
                    .offset(x: -9, y: -18)

                timerView

                LazyVGrid(columns: columns, spacing: 16) {
                    cardsContent
                }
                .padding(.horizontal, 26)
                .blur(radius: activePopup != nil ? 10 : 0)
                .animation(.default, value: activePopup)

                matchesView

                Spacer()
            }
            .padding(.top, 40)
        }
    }

    private var iPadLayout: some View {
        ZStack {
            HStack { mapButton }
                .offset(x: 220, y: -820)

            VStack(spacing: 12) {
                Text("لعبة الكروت - نجد")
                    .foregroundColor(Color("brown"))
                    .font(.custom("Saudi-Bold", size: 30))
                    .multilineTextAlignment(.center)

                timerView

                LazyVGrid(columns: iPadColumns, spacing: 100) {
                    cardsContent
                        .frame(width: 205, height: 245)
                }
                .padding(.horizontal, 90)
                .blur(radius: activePopup != nil ? 10 : 0)
                .animation(.default, value: activePopup)

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
            Text("مطابقات: \(viewModel.matchedPairsCount)/\(requiredPairsForLevel)")
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
        viewModel.setupCards(cardPairs: najdCards)

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

    func timeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%01d:%02d", minutes, secs)
    }
}

#Preview {
    NajdView(region: .central, levelNumber: 2)
}
