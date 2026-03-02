//
//  لغز الغربية.swift
//  SaudiCulture
//
//  Created by Raghad Alamoudi on 22/08/1447 AH.
//

import SwiftUI

struct PuzzlePieceShapeGharbiya: Shape {
    let row: Int
    let col: Int
    let rows: Int
    let cols: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        let tabWidth = w * 0.25
        let tabHeight = h * 0.15
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        if row == 0 {
            path.addLine(to: CGPoint(x: w, y: 0))
        } else {
            let midX = w / 2
            path.addLine(to: CGPoint(x: midX - tabWidth/2, y: 0))
            path.addQuadCurve(
                to: CGPoint(x: midX + tabWidth/2, y: 0),
                control: CGPoint(x: midX, y: -tabHeight)
            )
            path.addLine(to: CGPoint(x: w, y: 0))
        }
        
        if col == cols - 1 {
            path.addLine(to: CGPoint(x: w, y: h))
        } else {
            let midY = h / 2
            path.addLine(to: CGPoint(x: w, y: midY - tabWidth/2))
            path.addQuadCurve(
                to: CGPoint(x: w, y: midY + tabWidth/2),
                control: CGPoint(x: w + tabHeight, y: midY)
            )
            path.addLine(to: CGPoint(x: w, y: h))
        }
        
        if row == rows - 1 {
            path.addLine(to: CGPoint(x: 0, y: h))
        } else {
            let midX = w / 2
            path.addLine(to: CGPoint(x: midX + tabWidth/2, y: h))
            path.addQuadCurve(
                to: CGPoint(x: midX - tabWidth/2, y: h),
                control: CGPoint(x: midX, y: h + tabHeight)
            )
            path.addLine(to: CGPoint(x: 0, y: h))
        }
        
        if col == 0 {
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
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

struct PuzzlePieceGharbiya: Identifiable {
    let id: Int
    let row: Int
    let col: Int
    var currentRow: Int
    var currentCol: Int
    var isInCorrectPosition: Bool {
        return currentRow == row && currentCol == col
    }
}

struct LevelAlgharbiya: View {
    private let rows = 3
    private let cols = 3
    private let puzzleSize: CGFloat = 340
    
    @State private var pieces: [PuzzlePieceGharbiya] = []
    @State private var draggingPiece: PuzzlePieceGharbiya?
    @State private var dragOffset: CGSize = .zero
    @State private var isShuffled: Bool = false
    @State private var isSolved: Bool = false
    @State private var isGlowing: Bool = false
    @State private var showCompletionDialog: Bool = false
    @State private var showHelpDialog: Bool = false
    @State private var navigateToNext: Bool = false
    
    // ⭐ زر الهوم
    @State private var navigateToHome: Bool = false
    
    
    
    @StateObject private var flow = LevelFlow.shared
 
    // ⭐ صور البزل لمستويات الغربية
    let puzzleImages = [
        "تراث الغربية",
        "بيت نصيف",
        "سوق عكاظ",
        "قلعة الاجياد",
        "قصر السقاف"
    ]

    
    // ⭐ معالم المنطقة الغربية
    private let westernLandmarks: [(name: String, info: String)] = [
        (
            "البلد",
            "منطقة تاريخية عريقة في جدة، كانت مركزًا تجاريًا مهمًا وبوابة للحجاج القادمين إلى مكة، وتتميز ببيوتها المبنية من الحجر والخشب."
        ),
        (
            "بيت نصيف",
            "من أشهر البيوت التاريخية في جدة، استُخدم لاستقبال الضيوف وكبار الشخصيات، ويعكس العمارة الحجازية التقليدية."
        ),
        (
            "سوق عكاظ",
            "سوق تاريخي شهير في الطائف، كان ملتقى ثقافيًا وتجاريًا في العصر الجاهلي، واشتهر بالشعر والأدب."
        ),
        (
            "قلعة الجياد",
            "قلعة تاريخية كانت تستخدم لأغراض دفاعية، وتُعد من الشواهد على العمارة العسكرية القديمة."
        ),
        (
            "قصر السقاف",
            "قصر تاريخي يعكس أسلوب البناء الحجازي القديم، ويُعد من المعالم الثقافية المهمة في المنطقة الغربية."
        )
    ]
    var currentPuzzleImage: String {
        let level = flow.currentLevel(for: .western)
        return puzzleImages[min(level, puzzleImages.count - 1)]
    }

    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Image("الغربيه")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    puzzleBoard
                    Spacer()
                }
                .overlay(alignment: .bottom) {
                    HStack {
                        
                        // ⭐ زر الاستفهام — الآن مطابق للوسطى (أصغر)
                        Button(action: {
                            showHelpDialog = true
                        }) {
                            Image(systemName: "questionmark")
                                .font(.system(size: 26))   // ← نفس الوسطى
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("brown"))
                                .clipShape(Circle())
                        }
                        .padding(.leading, 3)
                        
                        Spacer()
                    }
                    .padding(.bottom, 180)
                }
                .overlay(alignment: .topTrailing) {
                    
                    // ⭐ زر الهوم — مطابق للوسطى + ربط الخريطة
                    HStack {
                        Button(action: {
                            navigateToHome = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("brown"))
                                    .frame(width: 60, height: 60)
                                
                                Image("saudiMap") // تأكد الاسم مطابق في Assets
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                            }
                        }
                        .padding(.top, 60)
                        .padding(.trailing, 0.1)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)

            // ⭐ ربط صفحة الخريطة
            .navigationDestination(isPresented: $navigateToHome) {
                SaudiMapView()
            }
//            .navigationDestination(isPresented: $navigateToNext ) {
//                PuzzleChoicesView()
//            }
            .navigationDestination(isPresented: $navigateToNext) {
                PuzzleView(region: .western)
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
    }
    
    // MARK: - لوح البزل
    private var puzzleBoard: some View {
        let pieceSize = puzzleSize / CGFloat(cols)
        
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("brown"), lineWidth: 4.5)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("BackgroundMain"))
                )
                .frame(width: puzzleSize, height: puzzleSize)
            
            ZStack {
                ForEach(pieces) { piece in
                    makePieceView(piece: piece, pieceSize: pieceSize)
                }
                
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
    private func makePieceView(piece: PuzzlePieceGharbiya, pieceSize: CGFloat) -> some View {
        
        let isDragging = draggingPiece?.id == piece.id
        let offset = isDragging ? dragOffset : .zero
        
        let x = CGFloat(piece.currentCol) * pieceSize + pieceSize / 2
        let y = CGFloat(piece.currentRow) * pieceSize + pieceSize / 2
        
        return ZStack {
            if !piece.isInCorrectPosition {
                PuzzlePieceShapeGharbiya(row: piece.row, col: piece.col, rows: rows, cols: cols)
                    .fill(Color("BackgroundMain").opacity(0.3))
                    .frame(width: pieceSize, height: pieceSize)
            }
            
            ZStack {
                GeometryReader { geo in
                    Image(currentPuzzleImage)
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
                
                Rectangle()
                    .stroke(Color.black, lineWidth: isSolved ? 0 : 2.0)
                    .frame(width: pieceSize, height: pieceSize)
            }
            .frame(width: pieceSize, height: pieceSize)
            .clipShape(PuzzlePieceShapeGharbiya(row: piece.row, col: piece.col, rows: rows, cols: cols))
            .shadow(color: .black.opacity(isDragging ? 0.4 : 0.15), radius: isDragging ? 10 : 3)
            .scaleEffect(isDragging ? 1.05 : 1.0)
            .zIndex(isDragging ? 100 : Double(piece.id))
        }
        .frame(width: pieceSize, height: pieceSize)
        .contentShape(Rectangle())
        .offset(offset)
        .position(x: x, y: y)
        .gesture(
            DragGesture(minimumDistance: 0)
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
    
    private func handleDrop(piece: PuzzlePieceGharbiya, translation: CGSize, pieceSize: CGFloat) {
        let dx = Int(round(translation.width / pieceSize))
        let dy = Int(round(translation.height / pieceSize))
        
        let newCol = piece.currentCol + dx
        let newRow = piece.currentRow + dy
        
        guard newCol >= 0, newCol < cols, newRow >= 0, newRow < rows else {
            return
        }
        
        if let targetIndex = pieces.firstIndex(where: { $0.currentRow == newRow && $0.currentCol == newCol }),
           let pieceIndex = pieces.firstIndex(where: { $0.id == piece.id }) {
            
            let tempRow = pieces[targetIndex].currentRow
            let tempCol = pieces[targetIndex].currentCol
            
            pieces[targetIndex].currentRow = pieces[pieceIndex].currentRow
            pieces[targetIndex].currentCol = pieces[pieceIndex].currentCol
            
            pieces[pieceIndex].currentRow = tempRow
            pieces[pieceIndex].currentCol = tempCol
            
            checkIfSolved()
        }
    }
    
    private func checkIfSolved() {
        let allInPlace = pieces.allSatisfy { $0.isInCorrectPosition }
        
        if allInPlace && isShuffled && !isSolved {
            celebrateSolve()
        }
    }
    
    private func celebrateSolve() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isSolved = true
        }
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                showCompletionDialog = true
            }
        }
    }
    
    private var completionDialogView: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("BackgroundMain"))
                    .stroke(Color("brown"), lineWidth: 4)
                
                VStack(spacing: 16) {
                    Spacer()
                    
                    let level = flow.currentLevel(for: .western)
                    let landmark = westernLandmarks[min(level, westernLandmarks.count - 1)]
                    Text(landmark.name)
                        .font(.custom("Saudi-Bold", size: 36))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text(landmark.info)

                        .font(.custom("Saudi-Bold", size: 18))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
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
    
    private var helpDialogView: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    showHelpDialog = false
                }
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("BackgroundMain"))
                    .stroke(Color("brown"), lineWidth: 4)
                
                Image(currentPuzzleImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .padding(20)
            }
            .frame(width: 340, height: 520)
        }
    }
    
    private func setupPuzzle() {
        var allPieces: [PuzzlePieceGharbiya] = []
        var id = 0
        
        for r in 0..<rows {
            for c in 0..<cols {
                allPieces.append(PuzzlePieceGharbiya(
                    id: id,
                    row: r,
                    col: c,
                    currentRow: r,
                    currentCol: c
                ))
                id += 1
            }
        }
        
        pieces = allPieces
        isShuffled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            shufflePieces()
        }
    }
    
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
    LevelAlgharbiya()
}
