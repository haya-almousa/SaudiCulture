//
//  GameLogic.swift
//  SaudiCulture
//
//  Created by Rawan Algarny on 21/08/1447 AH.
//

import SwiftUI
internal import Combine

// Card Model
struct Card: Identifiable {
    let id = UUID()
    let text: String?
    let imageName: String?
    let borderColor: Color
    let pairID: Int // Cards with same pairID are matches
}

// Game Logic
class GameLogic: ObservableObject {
    @Published var cards: [Card] = []
    @Published var flippedIndices: Set<Int> = []
    @Published var matchedPairIDs: Set<Int> = []
    @Published var firstFlippedIndex: Int? = nil
    @Published var gameWon: Bool = false
    @Published var matchedPairsCount: Int = 0 // NEW: Counter for matched pairs
    
    // Prevent multiple taps while checking second card
    private var isProcessing = false
    
    // Total number of pairs (excluding lonely card)
    private var totalPairs: Int = 0
    
    // Setup cards with shuffling
    func setupCards(cardPairs: [Card]) {
        cards = cardPairs.shuffled()
        flippedIndices.removeAll()
        matchedPairIDs.removeAll()
        firstFlippedIndex = nil
        isProcessing = false
        gameWon = false
        
        // Calculate total pairs (excluding pairID 5 - the lonely card)
        let pairIDs = Set(cardPairs.map { $0.pairID }).filter { $0 != 5 }
        totalPairs = pairIDs.count
        matchedPairsCount = 0
    }
    
    // Handle card tap
    func cardTapped(at index: Int) {
        // Ignore if already processing
        guard !isProcessing else { return }
        
        let card = cards[index]
        
        // Ignore if already matched
        guard !matchedPairIDs.contains(card.pairID) else { return }
        
        // Ignore if already flipped
        guard !flippedIndices.contains(index) else { return }
        
        // Handle lonely card (pairID 5)
        if card.pairID == 5 {
            flippedIndices.insert(index)
            isProcessing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // 3 sec delay
                withAnimation {
                    self.flippedIndices.remove(index)
                    self.isProcessing = false
                }
            }
            return
        }
        
        // First card flipped
        if firstFlippedIndex == nil {
            firstFlippedIndex = index
            flippedIndices.insert(index)
        }
        // Second card flipped
        else if let firstIndex = firstFlippedIndex {
            flippedIndices.insert(index)
            isProcessing = true
            
            let firstCard = cards[firstIndex]
            let secondCard = cards[index]
            
            if firstCard.pairID == secondCard.pairID {
                // Match found
                withAnimation(.easeIn(duration: 0.3)) {
                    matchedPairIDs.insert(firstCard.pairID)
                    matchedPairsCount += 1 // Increment counter
                }
                firstFlippedIndex = nil
                isProcessing = false
                checkGameWon()
            } else {
                // No match - flip back after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.flippedIndices.remove(firstIndex)
                        self.flippedIndices.remove(index)
                        self.firstFlippedIndex = nil
                        self.isProcessing = false
                    }
                }
            }
        }
    }
    //////new
    func revealAllCards() {
        for i in cards.indices {
            flippedIndices.insert(i)
        }
    }
    /////
    ///

    // Check if card is flipped
    func isFlipped(at index: Int) -> Bool {
        let card = cards[index]
        return flippedIndices.contains(index) || matchedPairIDs.contains(card.pairID)
    }
    
    // Reset game
    func resetGame(cardPairs: [Card]) {
        setupCards(cardPairs: cardPairs)
    }
    
    // Check if all matching cards are paired
    private func checkGameWon() {
        let pairIDs = Set(cards.map { $0.pairID }).filter { $0 != 5 } // exclude lonely card
        if matchedPairIDs.isSuperset(of: pairIDs) {
            gameWon = true
        }
    }
    
    // Get total pairs count (for display)
    func getTotalPairs() -> Int {
        return totalPairs
    }
}

#Preview {
    ContentView()
}
