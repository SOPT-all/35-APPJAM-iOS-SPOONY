//
//  FixedBottomSheetView.swift
//  Spoony-iOS
//
//  Created by 이지훈 on 1/18/25.
//

import SwiftUI

struct FixedBottomSheetView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    private let screenHeight = UIScreen.main.bounds.height
    private let fixedHeight: CGFloat
    private let headerHeight: CGFloat = 20.adjustedH
    @State private var isDisabled = false
    
    init() {
        self.fixedHeight = UIScreen.main.bounds.height * 0.5
    }
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 10) {
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 36.adjusted, height: 5.adjustedH)
                        .padding(.top, 10)
                }
                .frame(height: headerHeight)
                .background(.white)
                
                VStack(spacing: 16) {
                    Image(.imageGoToList)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125.adjusted, height: 95.adjustedH)
                        .padding(.leading, 10)
                    
                    Text("아직 추가된 장소가 없어요.\n다른 사람의 리스트를 떠먹어 보세요!")
                        .font(.body2m)
                        .foregroundStyle(.gray500)
                        .multilineTextAlignment(.center)
                    
                    SpoonyButton(
                        style: .secondary,
                        size: .xsmall,
                        title: "떠먹으러 가기",
                        disabled: $isDisabled
                    ) {
                        navigationManager.push(.detailView)
                    }
                    .padding(.top, 8)
                }
                .padding(.top, 24)
                
                Spacer()
            }
            .frame(height: fixedHeight)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            .offset(y: screenHeight - fixedHeight)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FixedBottomSheetView()
}
