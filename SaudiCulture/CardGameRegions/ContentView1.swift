//
//  ContentView.swift
//  SaudiCulture
//
//  Created by Rawan Algarny on 21/08/1447 AH.
//

import SwiftUI

struct ContentView1: View {
    let regions = [
        "نجد",
        "الحجاز",
        "الشرقية",
        "الجنوبية",
        "الشمالية"
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("اختر المنطقة")
                    .font(.largeTitle)
                    .padding()
                
                ForEach(0..<regions.count, id: \.self) { index in
                    NavigationLink(destination: destinationView(for: index)) {
                        Text(regions[index])
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "7A4A2E"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("مناطق السعودية")
        }
    }
    //I'LL CHANGE THIS WITH THE MAP ;)
    @ViewBuilder
    func destinationView(for index: Int) -> some View {
        switch index {
        case 0: NajdView(region: .central, levelNumber: 1)
        case 1: HejazView(region: .central, levelNumber: 1)
        case 2: EasternView(region: .central, levelNumber: 1)
        case 3: AsirView(region: .central, levelNumber: 1)
        case 4: NorthView(region: .central, levelNumber: 1)
        default: EmptyView()
        }
    }
}

#Preview {
    ContentView()
}
