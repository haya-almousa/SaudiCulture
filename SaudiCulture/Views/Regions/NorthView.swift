////
//import SwiftUI
//
//struct NorthView: View {
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
//    // ✅ ربط الفوز بالبزل (نفس الشرقيه)
//    @State private var goToNextGame = false
//    
//    // Cards for North region
//    let northCards: [Card] = [
//        Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "محوثل و المقرونة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: "بخنق و دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
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
//                    
//                    // Title
//                    Text("لعبة الكروت - الشمالية")
//                        .foregroundStyle(Color(hex: "7A4A2E"))
//                        .font(.system(size: 28, weight: .bold, design: .rounded))
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
//                            .font(.system(size: 20, weight: .bold, design: .rounded))
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
//                            .font(.system(size: 18, weight: .semibold, design: .rounded))
//                            .foregroundColor(Color(hex: "7A4A2E"))
//                        Spacer()
//                    }
//                    .padding(.horizontal, 26)
//                    
//                    Spacer()
//                }
//                .padding(.top, 60)
//                
//                // Popup
//                if let popup = activePopup {
//                    GamePopupView(
//                        type: popup,
//                        onClose: {
//                            activePopup = nil
//                            resetGame()
//                        },
//                        // ✅ نفس الشرقيه: عند الفوز يروح للبزل
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
//            // ✅ ربط الكروت بالبزل (الشمالية)
//            .navigationDestination(isPresented: $goToNextGame) {
//                LevelAshshamaliya()
//            }
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
//            /////
////            .onReceive(viewModel.$gameWon) { won in
////                if won {
////                    activePopup = .win
////                    timerRunning = false
////                }
////            }
//        ////
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
//                viewModel.setupCards(cardPairs: northCards)
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
//    // Reset Game
//    func resetGame() {
//        timeRemaining = 90
//        timerRunning = true
//        flashRed = false
//        viewModel.setupCards(cardPairs: northCards)
//    }
//    
//    func timeString(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let secs = seconds % 60
//        return String(format: "%01d:%02d", minutes, secs)
//    }
//}
//
//#Preview {
//    NorthView(region: .central)
//} second one
//
//import SwiftUI
//
//struct NorthView: View {
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
//    // 👇 Preview mode for shuffle animation
//    @State private var isPreviewMode: Bool = true
//
//    // Cards for North region
//    let northCards: [Card] = [
//        Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "محوثل و المقرونة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: "بخنق و دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
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
//                .offset(x: 153, y: -344)
//
//                VStack(spacing: 16) {
//                    // Title
//                    Text("لعبة الكروت - الشمالية")
//                         .foregroundColor(Color("brown"))
//                        .font(.custom("Saudi-Bold", size: 30))
//                        .multilineTextAlignment(.center)
//                        .offset(x: -9 ,y: -20)
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
//                            .font(.system(size: 20, weight: .bold, design: .rounded))
//                            .foregroundColor(Color(hex: "731112"))
//                    }
//
//                    // Cards Grid
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
//                            CardView(
//                                text: card.text,
//                                imageName: card.imageName,
//                                isFaceUp: isPreviewMode ? true : viewModel.isFlipped(at: index),
//                                borderColor: card.borderColor
//                            )
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                if !isPreviewMode {
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
//                            .font(.system(size: 18, weight: .semibold, design: .rounded))
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
//                LevelAshshamaliya(levelNumber: levelNumber)
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
//                viewModel.setupCards(cardPairs: northCards)
//                isPreviewMode = true
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    withAnimation(.easeInOut(duration: 0.4)) {
//                        isPreviewMode = false
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
//                            viewModel.shuffleCards()
//                        }
//                    }
//                }
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
//        isPreviewMode = true
//        viewModel.setupCards(cardPairs: northCards)
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
//    func timeString(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let secs = seconds % 60
//        return String(format: "%01d:%02d", minutes, secs)
//    }
//}
//
//#Preview {
//    NorthView(region: .central, levelNumber: 1)
//}

import SwiftUI

struct NorthView: View {
    
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
    
    // Preview mode
    @State private var isPreviewMode: Bool = true
    
    // MARK: - North Levels (Clothing Theme)
    
    let northLevels: [[Card]] = [
        
        // LEVEL 0 → exactly like original `northCards`
        [
            Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
            Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
            
            Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
            Card(text: "محوثل و المقرونة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
            
            Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
            Card(text: "بخنق و دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
            
            Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
            Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
            
            Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
        ],
        
        // LEVEL 1 → MAN DONE
        [
            Card(text: nil, imageName: "ثوب", borderColor: Color(hex: "731112"), pairID: 1),
            Card(text: "ثوب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
            
            Card(text: nil, imageName: "عقال", borderColor: Color(hex: "731112"), pairID: 2),
            Card(text: "عقال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
            
            Card(text: nil, imageName: "MAN1", borderColor: Color(hex: "731112"), pairID: 3),
            Card(text: "غتره", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
            
            Card(text: nil, imageName: "بشت", borderColor: Color(hex: "731112"), pairID: 4),
            Card(text: "بشت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
            
            Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
        ],
        // LEVEL 2 → WOMAN Not done yet
        [
            Card(text: nil, imageName: "W3", borderColor: Color(hex: "731112"), pairID: 1),
            Card(text: "محوثل", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
            
            Card(text: nil, imageName: "شيلة", borderColor: Color(hex: "731112"), pairID: 2),
            Card(text: "شيلة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
            
            Card(text: nil, imageName: "W4", borderColor: Color(hex: "731112"), pairID: 3),
            Card(text: "المقرونة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
            
            Card(text: nil, imageName: "W2", borderColor: Color(hex: "731112"), pairID: 4),
            Card(text: "لبس التراثي للشمال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
            
            Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
        ],
        // LEVEL 3 → Girl Not done yet ٢ احتاج اضيف لها قطعتين
        [
            Card(text: nil, imageName: "Gdress", borderColor: Color(hex: "731112"), pairID: 1),
            Card(text: "بخنق", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
            
            Card(text: nil, imageName: "GDress1", borderColor: Color(hex: "731112"), pairID: 2),
            Card(text: "دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
            
            Card(text: nil, imageName: "W2", borderColor: Color(hex: "731112"), pairID: 3),
            Card(text: "اللبس التراثي للشمال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
            
Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 4),
            Card(text: "لبس التراثي للنساء للشمال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
//            Card(text: nil, imageName: "بشت", borderColor: Color(hex: "731112"), pairID: 4),
//            Card(text: "بشت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
            
            Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
        ],
        // LEVEL 4 → Boy  done
        [
            Card(text: nil, imageName: "ثوب", borderColor: Color(hex: "731112"), pairID: 1),
            Card(text: "ثوب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
            
            Card(text: nil, imageName: "عقال", borderColor: Color(hex: "731112"), pairID: 2),
            Card(text: "عقال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
            
            Card(text: nil, imageName: "Boy1", borderColor: Color(hex: "731112"), pairID: 3),
            Card(text: "غتره", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
            
            Card(text: nil, imageName: "Boy2", borderColor: Color(hex: "731112"), pairID: 4),
            Card(text: "بشت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
            
            Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
        ],
    ]
    
    // Select cards depending on level
    var currentLevelCards: [Card] {
        northLevels[min(levelNumber, northLevels.count - 1)]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "FFF9F2").ignoresSafeArea()
                
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Home Button
                HStack {
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
                .offset(x: 153, y: -344)
                
                VStack(spacing: 16) {
                    Text("لعبة الكروت - الشمالية")
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
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "731112"))
                    }
                    
                    // Cards
                    LazyVGrid(columns: columns, spacing: 16) {
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
                    .padding(.horizontal, 26)
                    .blur(radius: activePopup != nil ? 10 : 0)
                    
                    HStack {
                        Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(hex: "7A4A2E"))
                        Spacer()
                    }
                    .padding(.horizontal, 26)
                    
                    Spacer()
                }
                .padding(.top, 60)
                
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
                LevelAshshamaliya(levelNumber: levelNumber)
            }
            .navigationBarBackButtonHidden(true)
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
                viewModel.setupCards(cardPairs: currentLevelCards)
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
        
        viewModel.setupCards(cardPairs: currentLevelCards)
        
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
    NorthView(region: .northern, levelNumber: 4)
}

