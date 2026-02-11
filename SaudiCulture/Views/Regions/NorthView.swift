//
//  NorthView.swift
//  SaudiCulture
//
//  Created by Rawan Algarny on 21/08/1447 AH.
//
//
//import SwiftUI
//
//struct NorthView: View {
//    
//    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
//    
//    @StateObject private var viewModel = GameLogic()
//    @State private var showWinPopup = false
//    @State private var showTimeUpPopup = false
//    
//    // Timer
//    @State private var timeRemaining: Int = 90
//    @State private var timerRunning: Bool = true
//    @State private var flashRed: Bool = false
//    
//    // Cards for North region
//    let northCards: [Card] = [
//        // Pair 1
//        Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
//        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
//        
//        // Pair 2
//        Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
//        Card(text: "محوثل و المقرونة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
//        
//        // Pair 3
//        Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
//        Card(text: "بخنق و دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
//        
//        // Pair 4
//        Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
//        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
//        
//        // Lonely card
//        Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
//    ]
//    
//    var body: some View {
//        ZStack {
//            // Background
//            Color(hex: "FFF9F2").ignoresSafeArea()
//            Image("Palm").resizable().opacity(0.3)
//            
//            VStack(spacing: 16) {
//                // Title
//                Text("لعبة الكروت - الشمالية")
//                    .foregroundStyle(Color(hex: "7A4A2E"))
//                    .font(.system(size: 28, weight: .bold, design: .rounded))
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
//                        .font(.system(size: 20, weight: .bold, design: .rounded))
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
//                
//                // Matched Pairs Counter
//                HStack {
//                    Text("مطابقات: \(viewModel.matchedPairsCount)/\(viewModel.getTotalPairs())")
//                        .font(.system(size: 18, weight: .semibold, design: .rounded))
//                        .foregroundColor(Color(hex: "7A4A2E"))
//                    Spacer()
//                }
//                .padding(.horizontal, 26)
//                
//                Spacer()
//            }
//            .padding(.top, 20)
//            
//            // Win Popup
//            if showWinPopup {
//                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
//                
//                VStack(spacing: 20) {
//                    Text("مبروك !")
//                        .font(.system(size: 28, weight: .bold, design: .rounded))
//                        .foregroundColor(.white)
//                    
//                    Text("لقد نجحت في مطابقة جميع الكروت!")
//                        .font(.system(size: 20, weight: .medium, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 16)
//                    
//                    Button(action: {
//                        showWinPopup = false
//                        resetGame()
//                    }) {
//                        Text("يلا على اللعبه الي بعدها !")
//                            .font(.system(size: 18, weight: .bold))
//                            .foregroundColor(Color(hex: "731112"))
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(hex: "FFEFD8"))
//                            .cornerRadius(16)
//                            .padding(.horizontal, 40)
//                    }
//                }
//                .padding()
//                .background(Color(hex: "731112").opacity(0.85))
//                .cornerRadius(24)
//                .shadow(radius: 10)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .transition(.scale.combined(with: .opacity))
//                .animation(.easeInOut, value: showWinPopup)
//            }
//            
//            // Time-Up Popup
//            if showTimeUpPopup {
//                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
//                
//                VStack(spacing: 20) {
//                    HStack {
//                        Button(action: {
//                            showTimeUpPopup = false
//                            resetGame()
//                        }) {
//                            Image(systemName: "xmark")
//                                .foregroundColor(.white)
//                                .padding()
//                                .font(.system(size: 22, weight: .bold))
//                        }
//                        Spacer()
//                    }
//                    
//                    Text("انتهت اللعبه")
//                        .font(.system(size: 28, weight: .bold, design: .rounded))
//                        .foregroundColor(.white)
//                    
//                    Text(" العوض بالجيات")
//                        .font(.system(size: 20, weight: .medium, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 16)
//                    
//                }
//                .padding()
//                .background(Color(hex: "731112").opacity(0.85))
//                .cornerRadius(24)
//                .shadow(radius: 10)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .transition(.scale.combined(with: .opacity))
//                .animation(.easeInOut, value: showTimeUpPopup)
//            }
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .onReceive(viewModel.$gameWon) { won in
//            if won {
//                showWinPopup = true
//                timerRunning = false
//            }
//        }
//        .onAppear {
//            viewModel.setupCards(cardPairs: northCards)
//            
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                if timerRunning && timeRemaining > 0 {
//                    timeRemaining -= 1
//                    flashRed = timeRemaining <= 15 && timeRemaining > 0
//                } else if timeRemaining == 0 {
//                    timer.invalidate()
//                    showTimeUpPopup = true
//                    timerRunning = false
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
//    // Format seconds to mm:ss
//    func timeString(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let secs = seconds % 60
//        return String(format: "%01d:%02d", minutes, secs)
//    }
//}
//
//#Preview {
//    NorthView()
//}
import SwiftUI

struct NorthView: View {
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    
    @StateObject private var viewModel = GameLogic()
    @State private var activePopup: GamePopupType? = nil
    
    // Timer
    @State private var timeRemaining: Int = 90
    @State private var timerRunning: Bool = true
    @State private var flashRed: Bool = false
    
    // Cards for North region
    let northCards: [Card] = [
        Card(text: nil, imageName: "شمالي", borderColor: Color(hex: "731112"), pairID: 1),
        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 1),
        Card(text: nil, imageName: "شماليه", borderColor: Color(hex: "731112"), pairID: 2),
        Card(text: "محوثل و المقرونة", imageName: nil, borderColor: Color(hex: "731112"), pairID: 2),
        Card(text: nil, imageName: "NorthG", borderColor: Color(hex: "731112"), pairID: 3),
        Card(text: "بخنق و دراعه", imageName: nil, borderColor: Color(hex: "731112"), pairID: 3),
        Card(text: nil, imageName: "NorthB", borderColor: Color(hex: "731112"), pairID: 4),
        Card(text: "ثوب مرودن", imageName: nil, borderColor: Color(hex: "731112"), pairID: 4),
        Card(text: "لحالة بالميدان", imageName: "Date", borderColor: Color(hex: "731112"), pairID: 5)
    ]
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "FFF9F2").ignoresSafeArea()
            Image("Palm").resizable().opacity(0.3)
            
            VStack(spacing: 16) {
                // Title
                Text("لعبة الكروت - الشمالية")
                    .foregroundStyle(Color(hex: "7A4A2E"))
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                
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
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "7A4A2E"))
                    Spacer()
                }
                .padding(.horizontal, 26)
                
                Spacer()
            }
            .padding(.top, 20)
            
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
                        resetGame()
                    } : nil
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(viewModel.$gameWon) { won in
            if won {
                activePopup = .win
                timerRunning = false
            }
        }
        .onAppear {
            viewModel.setupCards(cardPairs: northCards)
            
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
    
    // MARK: - Reset Game
    func resetGame() {
        timeRemaining = 90
        timerRunning = true
        flashRed = false
        viewModel.setupCards(cardPairs: northCards)
    }
    
    // Helper: format seconds to mm:ss
    func timeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%01d:%02d", minutes, secs)
    }
}

#Preview {
    NorthView()
}
