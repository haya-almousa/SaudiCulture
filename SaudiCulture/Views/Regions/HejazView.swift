//
//import SwiftUI
//
//struct HejazView: View {
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
//    // Cards for Hejaz region
//    let hejazCards: [Card] = [
//        // Pair 1
//        Card(text: nil, imageName: "غربي", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "عمامه، ثوب و شاية", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        // Pair 2
//        Card(text: nil, imageName: "غربيه", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "ثوب الصدرة و مسفع ", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        // Pair 3
//        Card(text: nil, imageName: "HejazG", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: " ثوب داير و منثورو زبون", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        // Pair 4
//        Card(text: nil, imageName: "HejazB", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "غتره، بشت و ثوب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
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
//                    Text("لعبة الكروت - الحجاز")
//                        .foregroundStyle(Color(hex: "7A4A2E"))
//                        .font(.custom("Saudi-Bold", size: 28))
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
//            // ✅ بعد الفوز يروح للبزل (الغربية/الحجاز)
//            .navigationDestination(isPresented: $goToNextGame) {
//                LevelAlgharbiya()
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
//            
//            .onAppear {
//                viewModel.setupCards(cardPairs: hejazCards)
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
//        viewModel.setupCards(cardPairs: hejazCards)
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
//    HejazView(region: .central)
//}
import SwiftUI

struct HejazView: View {
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

    // Cards for Hejaz region
//    let hejazCards: [Card] = [
//        Card(text: nil, imageName: "غربي", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "عمامه، ثوب و شاية", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: nil, imageName: "غربيه", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "ثوب الصدرة و مسفع ", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: nil, imageName: "HejazG", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: " ثوب داير و منثورو زبون", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: nil, imageName: "HejazB", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "غتره، بشت و ثوب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
//        
//        
//        
//        
//        
//        
//        
//        
//        Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
//    ]

    var hejazCards: [Card] {

        switch levelNumber {// levelNumber  عشان يعرف  هو في اي مرحله و على اساسها يطلع البطايق

        // المرحلة 1 - الرجل
        case 1:
            return [
                Card(text: nil, imageName: "ﻃﺎﻗﻴﺔ", borderColor: Color(hex:"731112"), pairID:1),
                Card(text: "طاقية", imageName: nil, borderColor: Color(hex:"731112"), pairID:1),

                Card(text: nil, imageName: "عمامة", borderColor: Color(hex:"731112"), pairID:2),
                Card(text:  "عمامة", imageName: nil, borderColor: Color(hex:"731112"), pairID:2),

                Card(text: nil, imageName: "ثوب", borderColor: Color(hex:"731112"), pairID:3),
                Card(text: "ثوب", imageName: nil, borderColor: Color(hex:"731112"), pairID:3),

                Card(text: nil, imageName: "شاية", borderColor: Color(hex:"731112"), pairID:4),
                Card(text: "شاية", imageName: nil, borderColor: Color(hex:"731112"), pairID:4),

                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        // المرحلة 2 - المرأة
        case 2:
            return [
                Card(text: nil, imageName: "ﺛﻮب اﻟﺼﺪرة", borderColor: Color(hex:"731112"), pairID:1),
                Card(text: "ﺛﻮب اﻟﺼﺪر]", imageName: nil, borderColor: Color(hex:"731112"), pairID:1),

                Card(text: nil, imageName: "ﻣﺴﻔﻊ", borderColor: Color(hex:"731112"), pairID:2),
                Card(text: "ﻣﺴﻔﻊ", imageName: nil, borderColor: Color(hex:"731112"), pairID:2),

                Card(text: nil, imageName: "بيرم", borderColor: Color(hex:"731112"), pairID:3),
                Card(text: "بيرم", imageName: nil, borderColor: Color(hex:"731112"), pairID:3),

                Card(text: nil, imageName: "شاية", borderColor: Color(hex:"731112"), pairID:4),
                Card(text: "شاية", imageName: nil, borderColor: Color(hex:"731112"), pairID:4),

                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        // المرحلة 3 - الطفل
        case 3:
            return [
                Card(text: nil, imageName: "بشت", borderColor: Color(hex:"731112"), pairID:1),
                Card(text: "بشت", imageName: nil, borderColor: Color(hex:"731112"), pairID:1),

                Card(text: nil, imageName: "غترة", borderColor: Color(hex:"731112"), pairID:2),
                Card(text: "غترة", imageName: nil, borderColor: Color(hex:"731112"), pairID:2),

                Card(text: nil, imageName: "عقال", borderColor: Color(hex:"731112"), pairID:3),
                Card(text: "عقال", imageName: nil, borderColor: Color(hex:"731112"), pairID:3),

                Card(text: nil, imageName: "ثوب", borderColor: Color(hex:"731112"), pairID:4),
                Card(text: "ثوب", imageName: nil, borderColor: Color(hex:"731112"), pairID:4),

                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        // المرحلة 4 - الطفلة
        case 4:
            return [
                Card(text: nil, imageName: "ﺛﻮب ﻣﺒﻘر", borderColor: Color(hex:"731112"), pairID:1),
                Card(text: "ﺛﻮب ﻣﺒﻘر", imageName: nil, borderColor: Color(hex:"731112"), pairID:1),

                Card(text: nil, imageName: "شيلة", borderColor: Color(hex:"731112"), pairID:2),
                Card(text: "شيلة", imageName: nil, borderColor: Color(hex:"731112"), pairID:2),

                Card(text: nil, imageName: "ﺛﻮب اﻟﺼﺪرة", borderColor: Color(hex:"731112"), pairID:3),
                Card(text: "ﺛﻮب اﻟﺼﺪرة", imageName: nil, borderColor: Color(hex:"731112"), pairID:3),

                Card(text: nil, imageName: "بيرم", borderColor: Color(hex:"731112"), pairID:4),
                Card(text: "بيرم", imageName: nil, borderColor: Color(hex:"731112"), pairID:4),

                Card(text: "لحالة بالميدان ", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        default:
            return [
                Card(text: nil, imageName: "غربيه", borderColor: Color(hex:"731112"), pairID:1),
                Card(text: nil, imageName: "غربيه", borderColor: Color(hex:"731112"), pairID:1),

                Card(text: nil, imageName: "غربي", borderColor: Color(hex:"731112"), pairID:2),
                Card(text: nil, imageName:  "غربي", borderColor: Color(hex:"731112"), pairID:2),

                Card(text: nil, imageName: "طفل غربي", borderColor: Color(hex:"731112"), pairID:3),
                Card(text: nil, imageName:"طفل غربي", borderColor: Color(hex:"731112"), pairID:3),

                Card(text: nil, imageName: "طفله غربيه", borderColor: Color(hex:"731112"), pairID:4),
                Card(text: nil, imageName: "طفله غربيه", borderColor: Color(hex:"731112"), pairID:4),

                Card(text: "لحالة بالميدان ", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]
        }
    }
    
//    Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
    
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
                .offset(x: 153, y: -344)

                VStack(spacing: 16) {
                    // Title
                    Text("لعبة الكروت - الحجاز")
                        .foregroundColor(Color("brown"))
                        .font(.custom("Saudi-Bold", size: 30))
                        .multilineTextAlignment(.center)
                        .offset(x: -9 ,y: -20)
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
                            .font(.custom("Saudi-Bold", size: 28))
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

                    // Matched Pairs Counter
                    HStack {
                        Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
                            .font(.custom("Saudi-Bold", size: 28))
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
                LevelAlgharbiya(levelNumber: levelNumber)
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
                viewModel.setupCards(cardPairs: hejazCards)
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
        viewModel.setupCards(cardPairs: hejazCards)

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
    HejazView(region: .central, levelNumber: 1)
}
