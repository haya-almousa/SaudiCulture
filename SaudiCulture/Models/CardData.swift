//
//  CardData.swift
//  SaudiCulture
//
//  Created by Rawan Algarny on 21/08/1447 AH.
//

import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    let text: String?
    let imageName: String?
}

struct RegionData {
    let name: String
    let cards: [CardData]
    let borderColor: Color
}
