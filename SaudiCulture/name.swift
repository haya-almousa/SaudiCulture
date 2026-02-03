//
//  name.swift
//  SaudiCulture
//
//  Created by Haya almousa on 03/02/2026.
//

import SwiftUI

struct Name: View {
    var body: some View {
        ZStack{
            Color("BackgroundMain")
                .ignoresSafeArea()
            Text("أكتب اسمك هنا")
                .font(.custom("Saudi-Regular", size: 28))
                .foregroundStyle(Color("brown"))
        }
    }
}
#Preview {
    Name()
}
