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
    let iPadColumns = Array(repeating: GridItem(.fixed(110), spacing: 69), count: 3)
    
    @StateObject private var viewModel = GameLogic()
    @State private var activePopup: GamePopupType? = nil
    
    @State private var timeRemaining: Int = 90
    @State private var timerRunning: Bool = true
    @State private var flashRed: Bool = false
    
    @State private var goToMap = false
    @State private var goToNextGame = false
    @State private var isPreviewMode: Bool = true
    
    var northLevels: [Card] {
        switch levelNumber {
        case 1:
            return [
                Card(text: nil, imageName: "ثوب", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "ثوب مردون", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "عقال", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "عقال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "Boy1", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: "غتره", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "Boy2", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "بشت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        case 2:
            return [
                Card(text: nil, imageName: "W3", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "محوثل", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "شيلة", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "شيلة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "W2", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لبس التراثي للشمال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        case 3:
            return [
                Card(text: nil, imageName: "ثوب", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "ثوب مردون", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "عقال", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "عقال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "Boy1", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: "غتره", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "Boy2", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "بشت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        case 4:
            return [
                Card(text: nil, imageName: "Gdress", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: "بخنق", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "GDress1", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: "دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "تمر", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لبس التراثي  للشمال", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
            ]

        default:
            return [
                Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
                Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
                Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
                Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
                Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
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
                viewModel.setupCards(cardPairs: northLevels)
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
                Text("لعبة الكروت - الشمالية")
                    .foregroundColor(Color("brown"))
                    .font(.custom("Saudi-Bold", size: 30))
                    .multilineTextAlignment(.center)
                    .offset(x: -9, y: -20)
                
                timerView
                
                LazyVGrid(columns: columns, spacing: 16) {
                    cardsContent
                }
                .padding(.horizontal, 26)
                .blur(radius: activePopup != nil ? 10 : 0)
                
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
                Text("لعبة الكروت - الشمالية")
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
                .font(.system(size: 20, weight: .bold, design: .rounded))
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
        
        viewModel.setupCards(cardPairs: northLevels)
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
