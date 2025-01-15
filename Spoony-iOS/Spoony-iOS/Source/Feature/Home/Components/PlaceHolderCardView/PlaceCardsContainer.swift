//
//  PlaceCardsContainer.swift
//  Spoony-iOS
//
//  Created by 이지훈 on 1/15/25.
//

import SwiftUI

struct PlaceCardsContainer: View {
    let places: [CardPlace]
    @State private var currentPage = 0
    
    var body: some View {
        VStack(spacing: 4) {
            TabView(selection: $currentPage) {
                ForEach(Array(places.enumerated()), id: \.element.id) { index, place in
                    PlaceCard(
                        placeName: place.name,
                        visitorCount: place.visitorCount,
                        address: place.address,
                        images: place.images,
                        title: place.title,
                        subTitle: place.subTitle,
                        description: place.description
                    )
                    .padding(.horizontal, 26)
                    .tag(index)
                }
            }
            .frame(height: UIScreen.main.bounds.height * (240/812))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // 인디케이터
            HStack(spacing: 8) {
                ForEach(0..<places.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.spoonBlack : Color.gray500)
                        .frame(width: 6, height: 6)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.gray200)
            .cornerRadius(48)
        }
    }
}
