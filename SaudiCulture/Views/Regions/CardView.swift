//
//  CardView.swift
//  tapcash
//
//  Created by Ahmed on 27/10/2022.
//

import SwiftUI

struct CardView: View {
    var imageName: String?
    var text: String?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .frame(width: 100, height: 150)
                .shadow(radius: 5)

            VStack {
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }

                if let text = text {
                    Text(text)
                        .font(.custom("Saudi-Bold", size: 28))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageName: "sampleImage", text: "Sample Text")
    }
}
