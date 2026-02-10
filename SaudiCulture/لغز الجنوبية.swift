//
//  لغز الجنوبية.swift
//  SaudiCulture
//
//  Created by Raghad Alamoudi on 22/08/1447 AH.
//

import SwiftUI

// MARK: - شكل قطعة البزل (Puzzle Piece Shape)
struct PuzzlePieceShapeJanubiya: Shape {
    let row: Int
    let col: Int
    let rows: Int
    let cols: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // حجم الموجة (نسبة من حجم القطعة)
        let tabWidth = w * 0.25
        let tabHeight = h * 0.15
        
        // البداية من الزاوية اليسرى العليا
        path.move(to: CGPoint(x: 0, y: 0))
        
        // ═══ الحافة العلوية ═══
        if row == 0 {
            // حافة مستقيمة
            path.addLine(to: CGPoint(x: w, y: 0))
        } else {
            // موجة بارزة للخارج
            let midX = w / 2
            path.addLine(to: CGPoint(x: midX - tabWidth/2, y: 0))
            
            path.addQuadCurve(
                to: CGPoint(x: midX + tabWidth/2, y: 0),
                control: CGPoint(x: midX, y: -tabHeight)
            )
            
            path.addLine(to: CGPoint(x: w, y: 0))
        }
        
        // ═══ الحافة اليمنى ═══
        if col == cols - 1 {
            // حافة مستقيمة
            path.addLine(to: CGPoint(x: w, y: h))
        } else {
            // موجة بارزة للخارج
            let midY = h / 2
            path.addLine(to: CGPoint(x: w, y: midY - tabWidth/2))
            
            path.addQuadCurve(
                to: CGPoint(x: w, y: midY + tabWidth/2),
                control: CGPoint(x: w + tabHeight, y: midY)
            )
            
            path.addLine(to: CGPoint(x: w, y: h))
        }
        
        // ═══ الحافة السفلية ═══
        if row == rows - 1 {
            // حافة مستقيمة
            path.addLine(to: CGPoint(x: 0, y: h))
        } else {
            // موجة داخلية
            let midX = w / 2
            path.addLine(to: CGPoint(x: midX + tabWidth/2, y: h))
            
            path.addQuadCurve(
                to: CGPoint(x: midX - tabWidth/2, y: h),
                control: CGPoint(x: midX, y: h + tabHeight)
            )
            
            path.addLine(to: CGPoint(x: 0, y: h))
        }
        
        // ═══ الحافة اليسرى ═══
        if col == 0 {
            // حافة مستقيمة
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            // موجة داخلية
            let midY = h / 2
            path.addLine(to: CGPoint(x: 0, y: midY + tabWidth/2))
            
            path.addQuadCurve(
                to: CGPoint(x: 0, y: midY - tabWidth/2),
                control: CGPoint(x: -tabHeight, y: midY)
            )
            
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - موديل قطعة البزل
struct PuzzlePieceJanubiya: Identifiable {
    let id: Int
    let row: Int
    let col: Int
    var currentRow: Int
    var currentCol: Int
    var isInCorrectPosition: Bool {
        return currentRow == row && currentCol == col
    }
}

// MARK: - شاشة لفل الجنوبية
struct LevelAljanubiya: View {
    // إعدادات البزل
    // ═══════════════════════════════════════════════════
    // 📝 لتعديل عدد القطع:
    //    - غيّر rows و cols (مثلاً: 3×3 أو 5×5)
    // 📝 لتعديل حجم البزل:
    //    - غيّر puzzleSize (مثلاً: 280 أو 360)
    // ═══════════════════════════════════════════════════
    private let rows = 3
    private let cols = 3
    private let puzzleSize: CGFloat = 340
    
    // حالة اللعبة
    @State private var pieces: [PuzzlePieceJanubiya] = []
    @State private var draggingPiece: PuzzlePieceJanubiya?
    @State private var dragOffset: CGSize = .zero
    @State private var isShuffled: Bool = false  // هل القطع متخلبطة؟
    @State private var isSolved: Bool = false    // هل البزل محلول؟
    @State private var isGlowing: Bool = false   // تأثير اللمعان
    @State private var showCompletionDialog: Bool = false  // نافذة الإكمال
    @State private var showHelpDialog: Bool = false  // نافذة المساعدة (الصورة الكاملة)
    @State private var navigateToNext: Bool = false  // للانتقال للصفحة التالية
    @State private var navigateToHome: Bool = false  // للرجوع للصفحة الرئيسية
    
    var body: some View {
        ZStack {
            // ✅ الخلفية
            Image("الجنوبيه")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // ✅ المربع + البزل
            VStack {
                Spacer()
                
                puzzleBoard
                
                Spacer()
            }
            .overlay(alignment: .bottom) {
                HStack {
                    // زر المساعدة (؟) - منزّل تحت شوي
                    Button(action: {
                        showHelpDialog = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("brown"))
                                .frame(width: 44, height: 44)
                            
                            Text("؟")  // علامة استفهام عربية
                                .font(.custom("Saudi-Regular", size: 24))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 30)
                    
                    Spacer()
                }
                .padding(.bottom, 180)
            }
            .overlay(alignment: .topTrailing) {
                // زر الهوم (بدل انهاء اللعبة)
                Button(action: {
                    navigateToHome = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color("brown"))
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 60)
                .padding(.trailing, 20)
            }
        }
        .onAppear {
            setupPuzzle()
        }
        .overlay {
            if showCompletionDialog {
                completionDialogView
            }
        }
        .overlay {
            if showHelpDialog {
                helpDialogView
            }
        }
    }
    
    // MARK: - لوح البزل
    private var puzzleBoard: some View {
        let pieceSize = puzzleSize / CGFloat(cols)
        
        return ZStack {
            // الإطار البني
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("brown"), lineWidth: 4.5)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("BackgroundMain"))
                )
                .frame(width: puzzleSize, height: puzzleSize)
            
            // القطع
            ZStack {
                ForEach(pieces) { piece in
                    makePieceView(piece: piece, pieceSize: pieceSize)
                }
                
                // تأثير اللمعان عند الحل
                if isGlowing {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.4))
                        .frame(width: puzzleSize, height: puzzleSize)
                        .transition(.opacity)
                }
            }
            .frame(width: puzzleSize, height: puzzleSize)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    // MARK: - عرض قطعة واحدة
    private func makePieceView(piece: PuzzlePieceJanubiya, pieceSize: CGFloat) -> some View {
        let isDragging = draggingPiece?.id == piece.id
        let offset = isDragging ? dragOffset : .zero
        
        // الموقع الحالي في الشبكة
        let x = CGFloat(piece.currentCol) * pieceSize + pieceSize / 2
        let y = CGFloat(piece.currentRow) * pieceSize + pieceSize / 2
        
        return ZStack {
            // ═══ الخلفية (الشكل الصحيح للقطعة) ═══
            if !piece.isInCorrectPosition {
                PuzzlePieceShapeJanubiya(row: piece.row, col: piece.col, rows: rows, cols: cols)
                    .fill(Color("BackgroundMain").opacity(0.3))
                    .frame(width: pieceSize, height: pieceSize)
            }
            
            // ═══ القطعة نفسها ═══
            ZStack {
                // الصورة (الجزء الصحيح من تراث الجنوبية)
                GeometryReader { geo in
                    Image("تراث الجنوبية")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: puzzleSize, height: puzzleSize)
                        .offset(
                            x: -CGFloat(piece.col) * pieceSize,
                            y: -CGFloat(piece.row) * pieceSize
                        )
                }
                .frame(width: pieceSize, height: pieceSize)
                .clipped()
                
                // الحدود السوداء المربعة (بدون أطراف)
                Rectangle()
                    .stroke(Color.black, lineWidth: isSolved ? 0 : 2.0)
                    .frame(width: pieceSize, height: pieceSize)
            }
            .frame(width: pieceSize, height: pieceSize)
            .clipShape(PuzzlePieceShapeJanubiya(row: piece.row, col: piece.col, rows: rows, cols: cols))
            .shadow(color: .black.opacity(isDragging ? 0.4 : 0.15), radius: isDragging ? 10 : 3)
            .scaleEffect(isDragging ? 1.05 : 1.0)
            .zIndex(isDragging ? 100 : Double(piece.id))
        }
        .offset(offset)
        .position(x: x, y: y)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if draggingPiece == nil {
                        draggingPiece = piece
                    }
                    dragOffset = value.translation
                }
                .onEnded { value in
                    handleDrop(piece: piece, translation: value.translation, pieceSize: pieceSize)
                    draggingPiece = nil
                    dragOffset = .zero
                }
        )
    }
    
    // MARK: - معالجة السحب والإفلات
    private func handleDrop(piece: PuzzlePieceJanubiya, translation: CGSize, pieceSize: CGFloat) {
        let dx = Int(round(translation.width / pieceSize))
        let dy = Int(round(translation.height / pieceSize))
        
        let newCol = piece.currentCol + dx
        let newRow = piece.currentRow + dy
        
        // تأكد من الحدود
        guard newCol >= 0, newCol < cols, newRow >= 0, newRow < rows else {
            return
        }
        
        // ابحث عن القطعة في المكان الجديد
        if let targetIndex = pieces.firstIndex(where: { $0.currentRow == newRow && $0.currentCol == newCol }),
           let pieceIndex = pieces.firstIndex(where: { $0.id == piece.id }) {
            
            // تبديل الأماكن
            let tempRow = pieces[targetIndex].currentRow
            let tempCol = pieces[targetIndex].currentCol
            
            pieces[targetIndex].currentRow = pieces[pieceIndex].currentRow
            pieces[targetIndex].currentCol = pieces[pieceIndex].currentCol
            
            pieces[pieceIndex].currentRow = tempRow
            pieces[pieceIndex].currentCol = tempCol
            
            // تحقق إذا البزل انحل
            checkIfSolved()
        }
    }
    
    // MARK: - التحقق من الحل
    private func checkIfSolved() {
        // شيك إذا كل القطع في مكانها الصحيح
        let allInPlace = pieces.allSatisfy { $0.isInCorrectPosition }
        
        if allInPlace && isShuffled && !isSolved {
            // البزل انحل! 🎉
            celebrateSolve()
        }
    }
    
    // MARK: - الاحتفال بالحل
    private func celebrateSolve() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isSolved = true
        }
        
        // تأثير اللمعان المتكرر (مرتين فقط)
        for i in 0..<2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isGlowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isGlowing = false
                    }
                }
            }
        }
        
        // بعد انتهاء اللمعان، أظهر النافذة
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                showCompletionDialog = true
            }
        }
    }
    
    // MARK: - نافذة الإكمال
    private var completionDialogView: some View {
        ZStack {
            // خلفية شفافة داكنة
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            // النافذة
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("BackgroundMain"))
                    .stroke(Color("brown"), lineWidth: 4)
                
                VStack(spacing: 16) {
                    Spacer()
                    
                    // العنوان
                    Text("رجال ألمع")
                        .font(.custom("Saudi-Bold", size: 36))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    // النص التفصيلي
                    Text("قرية تراثية تاريخية تقع في جبال عسير، تشتهر بمبانيها الحجرية متعددة الأدوار ونوافذها الملوّنة، وتعكس التراث الجنوبي الأصيل والحياة الاجتماعية القديمة في المنطقة.")
                        .font(.custom("Saudi-Bold", size: 18))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // زر التالي (داخل النافذة)
                    Button(action: {
                        navigateToNext = true
                    }) {
                        Text("التالي")
                            .font(.custom("Saudi-Regular", size: 24))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 54)
                            .background(
                                Capsule()
                                    .fill(Color("brown"))
                            )
                    }
                    .padding(.bottom, 30)
                }
            }
            .frame(width: 340, height: 520)
        }
    }
    
    // MARK: - نافذة المساعدة (الصورة الكاملة)
    private var helpDialogView: some View {
        ZStack {
            // خلفية شفافة داكنة
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    showHelpDialog = false  // إغلاق عند الضغط على الخلفية
                }
            
            // النافذة
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("BackgroundMain"))
                    .stroke(Color("brown"), lineWidth: 4)
                
                // الصورة الكاملة
                Image("تراث الجنوبية")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .padding(20)
            }
            .frame(width: 340, height: 520)
        }
    }
    
    // MARK: - إعداد البزل
    private func setupPuzzle() {
        var allPieces: [PuzzlePieceJanubiya] = []
        var id = 0
        
        // إنشاء كل القطع في مكانها الصحيح (مكتملة)
        for r in 0..<rows {
            for c in 0..<cols {
                allPieces.append(PuzzlePieceJanubiya(
                    id: id,
                    row: r,
                    col: c,
                    currentRow: r,      // نفس المكان الأصلي
                    currentCol: c
                ))
                id += 1
            }
        }
        
        pieces = allPieces
        isShuffled = false
        
        // بعد ثانيتين، خلبط القطع قدام المستخدم
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            shufflePieces()
        }
    }
    
    // MARK: - خلبطة القطع (مع animation)
    private func shufflePieces() {
        var positions = pieces.map { ($0.row, $0.col) }
        positions.shuffle()
        
        withAnimation(.easeInOut(duration: 0.8)) {
            for i in 0..<pieces.count {
                pieces[i].currentRow = positions[i].0
                pieces[i].currentCol = positions[i].1
            }
            isShuffled = true
        }
    }
}

#Preview {
    LevelAljanubiya()
}
