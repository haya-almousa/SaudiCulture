import SwiftUI

struct NajdView: View {
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    
    @StateObject private var viewModel = GameLogic()
    @State private var activePopup: GamePopupType? = nil
    
    // Timer
    @State private var timeRemaining: Int = 90
    @State private var timerRunning: Bool = true
    @State private var flashRed: Bool = false
    
    @State private var goToNextGame = false

    // Cards for Najd region
    let najdCards: [Card] = [
        // Pair 1
        Card(text: nil, imageName: "NajdW", borderColor: Color(hex: "731112"), pairID: 1),
        Card(text: "ثوب تور و دراعيه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
        // Pair 2
        Card(text: nil, imageName: "NajdM", borderColor: Color(hex: "731112"), pairID: 2),
        Card(text: "ﻋﺼﺎﺑﺔ، ﻏﺘﺮة، دﻗﻠﺔ، ﺑﺸﺖ اﻟﺒﺮﻗﺎء، ﺛﻮب", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
        // Pair 3
        Card(text: nil, imageName: "NajdG", borderColor: Color(hex: "731112"), pairID: 3),
        Card(text: "ثوب\nشيلة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
        // Pair 4
        Card(text: nil, imageName: "NajdB", borderColor: Color(hex: "731112"), pairID: 4),
        Card(text: "ﻋﻘﺎل زري, ﻏﺘﺮة, زﺑﻮن, ﺑﺸت", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
        // Lonely card
        Card(text: "لحاله بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
    ]
    
    @State private var goToMap = false

    var body: some View {
        NavigationStack{
        ZStack {
            // Background
            Color(hex: "FFF9F2").ignoresSafeArea()
            Image("الوسطى")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            HStack{
                Button(action: {
                    goToMap = true
                }) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "FCF0DD"))
                        .padding(12)
                        .background(Color(hex: "874F35"))
                        .clipShape(Circle())
                }
            }.offset(x:160,y:-350)
            
            VStack(spacing: 16) {
                
                // Title
                Text("لعبة الكروت - نجد")
                    .foregroundStyle(Color(hex: "7A4A2E"))
                    .font(.custom("Saudi-Bold", size: 28))
                
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
                            isFaceUp: viewModel.isFlipped(at: index),
                            borderColor: card.borderColor
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.cardTapped(at: index)
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
                        //                        resetGame()
                    } : nil
                )
            }
            
            
        }
        .navigationDestination(isPresented: $goToMap) {
            SaudiMapView()
        }
//        .navigationDestination(isPresented: $goToNextGame) {
//            PuzzleChoicesView(
//                startIndex: LevelFlow.shared.puzzleIndex
//            )
//        }

        .navigationDestination(isPresented: $goToNextGame) {
            PuzzleChoicesView(
                region: .central
            )
            
        }

        
        .navigationBarBackButtonHidden(true)
        
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(viewModel.$gameWon) { won in
            if won {
                activePopup = .win
                timerRunning = false
            }
        }
        .onAppear {
            viewModel.setupCards(cardPairs: najdCards)
            
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
        viewModel.setupCards(cardPairs: najdCards)
    }
    
    // Helper: format seconds to mm:ss
    func timeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%01d:%02d", minutes, secs)
    }
}

#Preview {
    NajdView()
}
