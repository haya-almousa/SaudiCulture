//
//  عادات و التقاليد .swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 22/08/1447 AH.
//

//  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
//

import SwiftUI

  

struct PuzzleView3: View {
    let region: RegionType
    let descriptionText: String
    @State private var answer: String = ""
    @State private var showText = false
    @State private var showPopup = false

    @State private var goToMap = false

    
    
    var backgroundImageName: String {
        switch region {
        case .central:  return "الوسطى"
        case .northern: return "الشماليه"
        case .southern: return "الجنوبيه"
        case .eastern:  return "الشرقيه"
        case .western:  return "الغربيه"
        }
    }
    
    var body: some View {
        NavigationStack {

        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack {
                Spacer()

                
                // الكرت
                VStack(spacing: 10) {
                    
                    
                    
                    Text("العادات و التقاليد : ")
                        .font(.custom("Saudi-Regular", size: 25))
                        .foregroundColor(Color(hex: "874F35"))
                        .padding(.bottom, 20)
                        .offset(x: 0 , y: 70)
                    
                    
                    HStack(spacing: 7) {
                        
                            Text(descriptionText)
                                .font(.custom("Saudi-Regular", size: 25))
                                .foregroundColor(Color(hex: "874F35"))
                                .multilineTextAlignment(.center)
                                .frame(width: 355, height: 520)
                                .padding(20)

                        
                        .foregroundColor(Color(hex: "874F35"))
                        .multilineTextAlignment(.center)
                        .frame(width: 355, height: 520, alignment: .center)
                        .padding(20)                    }
                    //                    .font(.custom("Saudi-Regular", size: 30))
                    //                    .foregroundColor(Color(hex: "874F35"))
                    .offset(x: 0 , y: 10 )
                    
                    
                    
                }
                .frame(width: 355, height: 520) // ← هنا التحكم بالحجم
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(hex: "874F35"), lineWidth: 4)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "FCF0DD"))
                        )
                )
                .padding()
                
                
                //                Spacer()
                
                Button(action: {
                    LevelFlow.shared.completeLevel(region: region)
                    goToMap = true
                }) {
                    Text("انهاء  ")
                        .font(.custom("Saudi-Regular", size: 18))
                        .foregroundColor(Color(hex: "FCF0DD"))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color(hex: "874F35"))
                        .cornerRadius(25)
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)

        .navigationDestination(isPresented: $goToMap) {
            SaudiMapView()
        } 
    }
    }
}

#Preview {
    PuzzleView3(region: .central, descriptionText: "hi")
}

