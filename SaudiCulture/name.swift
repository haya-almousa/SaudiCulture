//
//  name.swift
//  SaudiCulture
//
//  Created by Haya almousa on 03/02/2026.
//

import SwiftUI

struct Name: View {
    @State private var name: String = ""

    var body: some View {
        ZStack {
            Color("BackgroundMain")
                .ignoresSafeArea()

            VStack(spacing: 5) {
                TextField("أكتب اسمك هنا", text: $name)
                    .font(.custom("Saudi-Regular", size: 30))
                    .foregroundStyle(Color("black"))
                    .multilineTextAlignment(.center)

                Rectangle()
                    .frame(height: 3)
                    .foregroundStyle(Color("brown"))
                    .padding(.horizontal, 60)
            }
            .padding()
        }
    }
}

#Preview {
    Name()
}
