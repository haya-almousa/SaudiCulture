//
//  لغز الشرقية.swift
//  SaudiCulture
//
//  Created by Raghad Alamoudi on 22/08/1447 AH.
//

import SwiftUI
internal import Combine

// MARK: - شكل قطعة البزل (Puzzle Piece Shape)
struct PuzzlePieceShapeSharqiya: Shape {
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

// MARK: - موديل قطعة البزل
struct PuzzlePieceSharqiya: Identifiable {
    let id: Int
    let row: Int
    let col: Int
    var currentRow: Int
    var currentCol: Int
    var isInCorrectPosition: Bool {
        return currentRow == row && currentCol == col
    }
}

// MARK: - شاشة لفل الشرقية
struct LevelAlsharqiya: View {
    let levelNumber: Int

    
    init(levelNumber: Int) {
            self.levelNumber = levelNumber
        }
    private let rows = 3
    private let cols = 3
    private let puzzleSize: CGFloat = 340
    
    @State private var pieces: [PuzzlePieceSharqiya] = []
    @State private var draggingPiece: PuzzlePieceSharqiya?
    @State private var dragOffset: CGSize = .zero
    @State private var isShuffled: Bool = false
    @State private var isSolved: Bool = false
    @State private var isGlowing: Bool = false
    @State private var showCompletionDialog: Bool = false
    @State private var showHelpDialog: Bool = false
    @State private var navigateToNext: Bool = false
    
    // ⭐ زر الهوم
    @State private var navigateToHome: Bool = false
    
    
    
    // ⭐ قائمة صور البزل لكل مستوى
    let puzzleImages = [
        "تراث الشرقية",
        "مسجد جواثا",
        "سوق القيصرية",
        "ميناء العقير",
        "واحة الأحساء"
    ]

    // ⭐ بيانات المعالم لكل مستوى
    private var easternLandmarks: [(name: String, info: String)] = [
        ("قصر إبراهيم", "قصر إبراهيم في الهفوف بالأحساء يُظهر مزيج العمارة العسكرية والدينية، ويعود للقرن التاسع عشر. القصر يحتوي على أبراج دفاعية وغرف للعبادة، ويُقال أن له ممرات سرية تحت الأرض استخدمت للحماية والهروب. اليوم يُعد موقعًا سياحيًا وتراثيًا هامًا في المنطقة الشرقية."),
        
        ("مسجد جواثا", "مسجد جواثا من أقدم مساجد الأحساء، ويعود تاريخه لأكثر من 1200 سنة. يتميز ببنائه التقليدي من الحجر والطين واحتوائه على بئر قديمة. كان المسجد مركزًا لحفظ القرآن وتعليم الدين قبل المدارس الحديثة، وما زال شاهدًا على التراث الديني والثقافي."),
        
        
        ("سوق القيصرية", "سوق القيصرية سوق تاريخي في الأحساء كان مركزًا للتجارة بين البدو والحضر. يحوي أزقة ضيقة ومحلات حجرية تقليدية، ويشتهر بالحرف اليدوية مثل صناعة النحاس والفخار. اليوم يُقام فيه مهرجان سنوي للحرف التراثية ويستقطب الزوار المهتمين بالثقافة المحلية.."),
        
        ("ميناء العقير", "ميناء العقير على ساحل الخليج العربي كان بوابة تجارية مهمة بين الخليج والهند وشرق إفريقيا. يحتوي على بقايا أرصفة وأبراج قديمة، وكان يُستخدم لتصدير اللؤلؤ والتوابل. اليوم يُعتبر موقعًا أثريًا ودراسة تاريخية لهواة التراث."),
        
        ("واحة الأحساء", "واحة الأحساء واحدة من أكبر الواحات في العالم، تضم ملايين النخيل ومئات الينابيع. كانت مركزًا زراعيًا متقدمًا منذ العصر الإسلامي الأول باستخدام أنظمة ري متطورة. اليوم تمثل الواحة مزيجًا من الطبيعة والتراث مع مزارع ومناظر سياحية جميلة.")
    ]
    @StateObject private var flow = LevelFlow.shared

    // ⭐ دالة لحساب الصورة الحالية لكل مستوى
    var currentPuzzleImage: String {
//        let level = flow.currentLevel(for: .eastern)
//        return puzzleImages[min(level, puzzleImages.count - 1)]
        return puzzleImages[min(levelNumber, puzzleImages.count - 1)]

    }

    // ⭐ دالة لحساب المعلم والمعلومة الحالية
    var currentLandmark: (name: String, info: String) {
        let level = flow.currentLevel(for: .eastern)
        return easternLandmarks[min(level, easternLandmarks.count - 1)]
    }
    
        @State private var shake = false
        @State private var stopShaking = false
        let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            
            ZStack {
                Image("الشرقيه")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: -20) {

                    Spacer()

                    ZStack {

                        puzzleBoard

                        // ⭐ العنوان يطلع من البوكس
                        Text("ركّب الصورة")
                            .font(.custom("Saudi-Bold", size: 28))
                            .foregroundColor(Color("brown"))
                            .font(.custom("Saudi-Bold", size: 30))
                            .multilineTextAlignment(.center)
                            .offset(x: 3 ,y: -370)
                    }

                    Spacer()
                }
                .overlay(alignment: .bottom) {
                    HStack {
                        // ⭐ زر الاستفهام — مطابق للوسطى
                        Button(action: {
                            showHelpDialog = true
                                stopShaking = true
                        }) {
                            Text("💡")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hex: "874F35"))
                                .clipShape(Circle())
                                .offset(x: shake ? -2 : 2, y: shake ? 1 : -1)        // حركة خفيفة يمين/يسار + فوق/تحت
                                .rotationEffect(.degrees(shake ? 3 : -3))             // يميل يمين/يسار
                                .scaleEffect(shake ? 1.05 : 0.95)                     // نبض خفيف
                                .animation(
                                    shake ?
                                    Animation.easeInOut(duration: 0.15).repeatCount(4, autoreverses: true)
                                    : .default,
                                    value: shake
                                )
                        }
                        .padding(.leading, 3)
                        
                        Spacer()
                    }
                    .onReceive(timer) { _ in
                        if !stopShaking {
                            shake = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                shake = false
                            }
                        }
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
                    .offset(x:15,y:1)
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
            .navigationDestination(isPresented: $navigateToNext ) {
                PuzzleView(region: .eastern , levelNumber: levelNumber)
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
    private func makePieceView(piece: PuzzlePieceSharqiya, pieceSize: CGFloat) -> some View {
        
        let isDragging = draggingPiece?.id == piece.id
        let offset = isDragging ? dragOffset : .zero
        
        let x = CGFloat(piece.currentCol) * pieceSize + pieceSize / 2
        let y = CGFloat(piece.currentRow) * pieceSize + pieceSize / 2
        
        return ZStack {
            if !piece.isInCorrectPosition {
                PuzzlePieceShapeSharqiya(row: piece.row, col: piece.col, rows: rows, cols: cols)
                    .fill(Color("BackgroundMain").opacity(0.3))
                    .frame(width: pieceSize, height: pieceSize)
            }
            
            ZStack {
                GeometryReader { geo in
                    Image(currentPuzzleImage) // ✅ استخدم المتغير الديناميكي
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
            .clipShape(PuzzlePieceShapeSharqiya(row: piece.row, col: piece.col, rows: rows, cols: cols))
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
    
    // MARK: - معالجة السحب والإفلات
    private func handleDrop(piece: PuzzlePieceSharqiya, translation: CGSize, pieceSize: CGFloat) {
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
    
    // MARK: - التحقق من الحل
    private func checkIfSolved() {
        let allInPlace = pieces.allSatisfy { $0.isInCorrectPosition }
        
        if allInPlace && isShuffled && !isSolved {
            celebrateSolve()
        }
    }
    
    // MARK: - الاحتفال بالحل
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
    
    // MARK: - نافذة الإكمال
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
                    
                    Text(currentLandmark.name)
                        .font(.custom("Saudi-Bold", size: 36))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text(currentLandmark.info)

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
    
    // MARK: - نافذة المساعدة
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
                
                Image(currentPuzzleImage)                     .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .padding(20)
            }
            .frame(width: 340, height: 520)
        }
    }
    
    // MARK: - إعداد البزل
    private func setupPuzzle() {
        var allPieces: [PuzzlePieceSharqiya] = []
        var id = 0
        
        for r in 0..<rows {
            for c in 0..<cols {
                allPieces.append(PuzzlePieceSharqiya(
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
    LevelAlsharqiya( levelNumber: 3)
}
