//
//  name.swift
//  SaudiCulture
//
//  Created by Haya almousa on 03/02/2026.
//

import SwiftUI

struct Name: View {
    @State private var name: String = ""
    @State private var navigateToCharacterPicker = false
    
    @AppStorage("playerName") private var savedName: String = ""               // ✅ حفظ الاسم
    @AppStorage("hasChosenCharacter") private var hasChosenCharacter: Bool = false // ✅ هل اختار شخصية؟
    
    private var isNameValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("أكتب اسمك", text: $name)
                    .font(.custom("Saudi-Regular", size: 28))
                    .foregroundStyle(Color("brown"))
                    .multilineTextAlignment(.center)
                    
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color("brown").opacity(0.5))
                    .padding(.horizontal, 48)
                
                Button("التالي") {
                    savedName = name.trimmingCharacters(in: .whitespacesAndNewlines) // ✅ حفظ الاسم
                    navigateToCharacterPicker = true
                }
                .font(.custom("Saudi-Regular", size: 20))
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Color("brown"))
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .disabled(!isNameValid)
                .opacity(isNameValid ? 1 : 0.4)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundMain"))
            .ignoresSafeArea()
            .onAppear {
                // ✅ إذا الاسم محفوظ: لا نعيد كتابته
                if !savedName.isEmpty {
                    name = savedName
                }
                // ✅ إذا الاسم محفوظ + سبق اختار شخصية: ندخله على نفس مسار التنقّل (CharacterPickerView)
                // و CharacterPickerView بتسوّي Skip تلقائيًا للترحيب
                if !savedName.isEmpty, hasChosenCharacter {
                    navigateToCharacterPicker = true
                }
            }
            .navigationDestination(isPresented: $navigateToCharacterPicker) {
                CharacterPickerView(playerName: savedName.isEmpty ? name : savedName)
            }
        }
    }
}

#Preview {
    Name()
}
